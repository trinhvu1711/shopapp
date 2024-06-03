package com.project.shopapp.controller;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.service.category.CategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//@Validated
@RestController
@RequestMapping("${api.prefix}/categories")
@RequiredArgsConstructor
public class CategoryController {
    private final CategoryService categoryService;

    @PostMapping("")
//      Data transfer Object
    public ResponseEntity<?> createCategory(
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult result) {
        if (result.hasErrors()) {
            List<String> errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errorMessages);
        }
        categoryService.createCategory(categoryDTO);
        return ResponseEntity.ok("Create category successfully");
    }

    //    show all category
    @GetMapping("")//http://localhost:8088/api/v1/categories?page=10&limit=10
    public ResponseEntity<List<Category>> getAllCategory(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit) {
        PageRequest pageRequest = PageRequest.of(
                page, limit, Sort.by("id").ascending()
        );
        List<Category> categories = categoryService.getAllCategories(pageRequest);
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/get-all")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> getAllCategoriesAdmin() {
        try {
            return ResponseEntity.ok(categoryService.getAllCategoriesAdmin());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateCategory(
            @PathVariable Long id,
            @Valid @RequestBody CategoryDTO categoryDTO
    ) {
        categoryService.updateCategory(id, categoryDTO);
        return ResponseEntity.ok("Update category successfully");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return ResponseEntity.ok("Delete category with id " + id);
    }
}
