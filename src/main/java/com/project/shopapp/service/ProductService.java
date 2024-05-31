package com.project.shopapp.service;

import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.exceptions.InvalidParamException;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.models.Variant;
import com.project.shopapp.repositories.CategoryRepository;
import com.project.shopapp.repositories.ProductImageRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.responses.ProductAdminResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService implements IProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;

    @Override
    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException {
        Category existingCategory = categoryRepository.findById(productDTO.getCategoryId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find category with id " + productDTO.getCategoryId()));
        Product newProduct = Product.builder()
                .name(productDTO.getName())
                .thumbnail(productDTO.getThumbnail())
                .category(existingCategory)
                .description(productDTO.getDescription())
                .descriptionHtml(productDTO.getDescriptionHtml())
                .build();
        return productRepository.save(newProduct);
    }

    @Override
    public Product getProductById(Long productId) throws DataNotFoundException {
        Optional<Product> optionalProductWithImages = productRepository.getProductWithImages(productId);
        Optional<Product> optionalProductWithVariants = productRepository.getProductWithVariants(productId);
        if (optionalProductWithImages.isPresent() && optionalProductWithVariants.isPresent()) {
            Product product = optionalProductWithImages.get();
            product.setVariants(optionalProductWithVariants.get().getVariants()); // Set variants
            return product;
        }

        throw new DataNotFoundException("Cannot find product with id =" + productId);
    }

//    @Override
//    public Product getProductById(Long productId) throws DataNotFoundException {
//        Optional<Product> optionalProduct = productRepository.getDetailProduct(productId);
//        if(optionalProduct.isPresent()) {
//            return optionalProduct.get();
//        }
//        throw new DataNotFoundException("Cannot find product with id =" + productId);
//    }

    @Override
    public Page<Product> getAllProducts(String keyword,
                                        Long categoryId, PageRequest pageRequest) {
        // Lấy danh sách sản phẩm theo trang (page), giới hạn (limit), và categoryId (nếu có)
        Page<Product> productsPage;
        productsPage = productRepository.searchProducts(categoryId, keyword, pageRequest);
        return productsPage;
    }

    @Override
    public Product updateProduct(long id, ProductDTO productDTO) throws DataNotFoundException {
        Product existingProduct = getProductById(id);
        if (existingProduct != null) {
            existingProduct.setName(productDTO.getName());
            Category existingCategory = categoryRepository.findById(productDTO.getCategoryId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find category with id " + productDTO.getCategoryId()));
            existingProduct.setCategory(existingCategory);
            existingProduct.setDescription(productDTO.getDescription());
            existingProduct.setThumbnail(productDTO.getThumbnail());
            existingProduct.setDescriptionHtml(productDTO.getDescriptionHtml());
            return productRepository.save(existingProduct);
        }
        return null;
    }

    @Override
    public void deleteProduct(long id) {
        Optional<Product> optionalProduct = productRepository.findById(id);
        optionalProduct.ifPresent(productRepository::delete);
    }

    @Override
    public boolean existByName(String name) {
        return productRepository.existsByName(name);
    }

    @Override
    public ProductImage createProductImage(long productId, ProductImageDTO productImageDTO) throws Exception {
        Product existingProduct = productRepository.findById(productImageDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + productImageDTO.getProductId()));
        ProductImage newProductImage = ProductImage.builder()
                .product(existingProduct)
                .imageUrl(productImageDTO.getImageUrl())
                .build();
        int size = productImageRepository.findByProductId(productId).size();
        if (size > ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS) {
            throw new InvalidParamException("Number of image must be <= " + ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS);
        }
        return productImageRepository.save(newProductImage);
    }

    @Override
    public List<ProductAdminResponse> searchProducts(String keyword) {
        List<Product> products = productRepository.searchProducts(keyword);
        List<ProductAdminResponse> productAdminResponses = new ArrayList<>();

        for (Product product : products) {
            List<Variant> variants = product.getVariants();
            List<String> variantNames = new ArrayList<>();
            List<String> variantPrices = new ArrayList<>();
            if (variants.size() > 0) {
                variants.stream().forEach(variant -> {
                    variantNames.add(variant.getName());
                    variantPrices.add(variant.getPrice() + " " + variant.getCurrency());
                });
            }
            ProductAdminResponse productAdminResponse = ProductAdminResponse.builder()
                    .id(product.getId())
                    .name(product.getName())
                    .category(product.getCategory().getName())
                    .variant(variantNames)
                    .price(variantPrices)
                    .description(product.getDescription())
                    .build();
            productAdminResponses.add(productAdminResponse);
        }
        return productAdminResponses;
    }
}
