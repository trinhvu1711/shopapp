package com.project.shopapp.controller;

import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductDTOWithThumbnailFile;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.models.Variant;
import com.project.shopapp.responses.ProductResponse;
import com.project.shopapp.service.product.ProductService;
import com.project.shopapp.service.variant.IVariantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RestController
@RequestMapping("${api.prefix}/admin/products")
@RequiredArgsConstructor
public class ProductAdminController {
    private final ProductService productService;
    private final IVariantService variantService;

    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ResponseEntity<?> createProduct(
            @Valid @RequestPart("product") ProductDTOWithThumbnailFile productWithThumbnailDTO,
            @RequestPart("thumbnail") MultipartFile thumbnail,
            @RequestPart("files") List<MultipartFile> files,
            BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }

            // Check if the file is valid
            if (thumbnail.getSize() == 0) {
                return ResponseEntity.badRequest().body("Thumbnail file is empty");
            }
            if (thumbnail.getSize() > 10 * 1024 * 1024) {
                return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("File is too large! Maximum size is 10MB");
            }
            String contentType = thumbnail.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("File must be an image");
            }

            // Save file
            String filename = storeFile(thumbnail);

            // Set thumbnail to filename
            ProductDTO productDTO = ProductDTO.builder()
                    .categoryId(productWithThumbnailDTO.getCategoryId())
                    .description(productWithThumbnailDTO.getDescription())
                    .name(productWithThumbnailDTO.getName())
                    .thumbnail(filename)
                    .build();

//            Create product
            Product newProduct = productService.createProduct(productDTO);

//            Upload images
            List<ProductImage> productImages = uploadImages(newProduct.getId(), files);
            newProduct.setProductImages(productImages);

//            Update variants
            if(productWithThumbnailDTO.getVariants() != null && !productWithThumbnailDTO.getVariants().isEmpty()){
                List<Long> variantsDTO = productWithThumbnailDTO.getVariants().stream()
                        .map(Long::parseLong)
                        .toList();
                List<Variant> variants = variantService.createProductVariant(newProduct.getId(), variantsDTO);
                newProduct.setVariants(variants);
            }

            ProductResponse response = ProductResponse.fromProduct(newProduct);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping(value = "/delete/{id}")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ResponseEntity<?> deleteProduct(@PathVariable Long id) {
        try {
            productService.deleteProduct(id);
            return ResponseEntity.ok("Product deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ResponseEntity<?> updateProduct(
            @PathVariable Long id,
            @Valid @RequestPart("product") ProductDTOWithThumbnailFile productWithThumbnailDTO,
            @RequestPart(required = false) MultipartFile thumbnail,
            @RequestPart(required = false) List<MultipartFile> files,
            BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            ProductDTO productDTO = ProductDTO.builder()
                    .categoryId(productWithThumbnailDTO.getCategoryId())
                    .description(productWithThumbnailDTO.getDescription())
                    .name(productWithThumbnailDTO.getName())
                    .build();
            // Check if the file is valid
            if (thumbnail != null && thumbnail.getSize() > 0) {
                if (thumbnail.getSize() > 10 * 1024 * 1024) {
                    return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("File is too large! Maximum size is 10MB");
                }
                String contentType = thumbnail.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("File must be an image");
                }

                // Save file
                String filename = storeFile(thumbnail);

                // Set thumbnail to filename
                productDTO.setThumbnail(filename);
            }

            // Update product
            Product updatedProduct = productService.updateProduct(id, productDTO);

            // Upload images
            if (files != null && !files.isEmpty()) {
                List<ProductImage> productImages = updateUploadImages(updatedProduct.getId(), files);
                updatedProduct.setProductImages(productImages);
            }

            // Update variants
            if (productWithThumbnailDTO.getVariants() != null && !productWithThumbnailDTO.getVariants().isEmpty()) {
                List<Long> variantsDTO = productWithThumbnailDTO.getVariants().stream()
                        .map(Long::parseLong)
                        .toList();
                List<Variant> variants = variantService.updateProductVariant(updatedProduct.getId(), variantsDTO);
                updatedProduct.setVariants(variants);
            }

            ProductResponse response = ProductResponse.fromProduct(updatedProduct);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @GetMapping("/get/{id}")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ResponseEntity<?> getProduct(@PathVariable Long id) {
        try {
            Product product = productService.getProductById(id);
            ProductResponse response = ProductResponse.fromProduct(product);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    public List<ProductImage> uploadImages(
            Long productId,
            List<MultipartFile> files) throws Exception {
        Product existingProduct = productService.getProductById(productId);
//        check image file is valid
        files = files == null ? new ArrayList<MultipartFile>() : files;
        if (files.size() > ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS) {
            throw new Exception("You can only upload maximum " + ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS + " images");
        }
        List<ProductImage> productImages = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file.getSize() == 0) {
                continue;
            }
            if (file.getSize() > 10 * 1024 * 1024) {
                throw new Exception("File is too large! Maximum size is 1000");
            }
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new Exception("File must be an image");
            }
//                    save file in dto
            String filename = storeFile(file);
//                    save product to db
            ProductImage productImage = productService.createProductImage(
                    existingProduct.getId(),
                    ProductImageDTO.builder()
                            .productId(existingProduct.getId())
                            .imageUrl(filename)
                            .build());
            productImages.add(productImage);
        }
        return productImages;
    }

    public List<ProductImage> updateUploadImages(
            Long productId,
            List<MultipartFile> files) throws Exception {
        Product existingProduct = productService.getProductById(productId);
//        check image file is valid
        files = files == null ? new ArrayList<MultipartFile>() : files;
        if (files.size() > ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS) {
            throw new Exception("You can only upload maximum " + ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS + " images");
        }
        List<ProductImage> productImages = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file.getSize() == 0) {
                continue;
            }
            if (file.getSize() > 10 * 1024 * 1024) {
                throw new Exception("File is too large! Maximum size is 1000");
            }
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new Exception("File must be an image");
            }
//                    save file in dto
            String filename = storeFile(file);
//                    save product to db
            ProductImage productImage = productService.updateProductImage(
                    existingProduct.getId(),
                    ProductImageDTO.builder()
                            .productId(existingProduct.getId())
                            .imageUrl(filename)
                            .build());
            productImages.add(productImage);
        }
        return productImages;
    }

    private String storeFile(MultipartFile file) throws IOException {
        if (!isImageFile(file) || file.getOriginalFilename() == null) {
            throw new IOException("Invalid image format");
        }
        String filename = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;
        Path uploadDir = Paths.get("uploads");
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        Path destination = Paths.get(uploadDir.toString(), uniqueFilename);
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        return uniqueFilename;
    }

    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }
}
