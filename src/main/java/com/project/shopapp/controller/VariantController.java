package com.project.shopapp.controller;

import com.project.shopapp.dtos.VariantAdminDTO;
import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Variant;
import com.project.shopapp.service.variant.VariantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//@Validated
@RestController
@RequestMapping("${api.prefix}/variants")
@RequiredArgsConstructor
public class VariantController {
    private final VariantService variantService;

    @PostMapping("")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
//      Data transfer Object
    public ResponseEntity<?> createVariant(
            @Valid @RequestBody VariantAdminDTO variantDTO,
            BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            variantService.createVariant(variantDTO);
            return ResponseEntity.ok("Create variant successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //    show all category
    @GetMapping("")//http://localhost:8088/api/v1/variants?page=10&limit=10
    public ResponseEntity<List<Variant>> getAllVariant() {
        List<Variant> variants = variantService.getAllVariants();
        return ResponseEntity.ok(variants);
    }
    @GetMapping("/all")
    public ResponseEntity<?> getAllVariants() {
        try {
            return ResponseEntity.ok(variantService.getAllVariants());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @GetMapping("/get-all")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> getAllVariantsAdmin() {
        try {
            return ResponseEntity.ok(variantService.getAllVariantsAdmin());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @GetMapping("/{id}")//http://localhost:8088/api/v1/variants?page=10&limit=10
    public ResponseEntity<Variant> getVariant(@PathVariable Long id) throws DataNotFoundException {
        Variant variants = variantService.getVariantById(id);
        return ResponseEntity.ok(variants);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateVariant(
            @PathVariable Long id,
            @Valid @RequestBody VariantDTO variantDTO
    ) {
        try {
            variantService.updateVariant(id, variantDTO);
            return ResponseEntity.ok("Update variant successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteVariant(@PathVariable Long id) {
        try {
            variantService.deleteVariant(id);
            return ResponseEntity.ok("Delete variant with id " + id);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
