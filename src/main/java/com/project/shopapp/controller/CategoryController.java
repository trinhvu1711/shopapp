package com.project.shopapp.controller;

import com.project.shopapp.components.LocalizationUtils;
import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.responses.UpdateCategoryResponse;
import com.project.shopapp.service.CategoryService;
import com.project.shopapp.utils.MessageKeys;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.LocaleResolver;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

//@Validated
@RestController
@RequestMapping("${api.prefix}/categories")
@RequiredArgsConstructor
public class CategoryController {
    private final CategoryService categoryService;
    private final LocalizationUtils localizationUtils;
    @PostMapping("")
//      Data transfer Object
    public ResponseEntity<UpdateCategoryResponse> createCategory(
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult result) {
        if (result.hasErrors()) {
            List<String> errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(UpdateCategoryResponse.builder()
                                                            .message(localizationUtils.getlocalizeMessage(MessageKeys.CREATE_CATEGORY_FAILED,errorMessages))
                                                            .build());
        }
        categoryService.createCategory(categoryDTO);
        return ResponseEntity.ok(UpdateCategoryResponse.builder()
                                         .message(localizationUtils.getlocalizeMessage(MessageKeys.CREATE_CATEGORY_SUCCESSFULLY))
                                         .build());
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

    @PutMapping("/{id}")
    public ResponseEntity<UpdateCategoryResponse> updateCategory(
            @PathVariable Long id,
            @Valid @RequestBody CategoryDTO categoryDTO,
            HttpServletRequest request
    ) {
        categoryService.updateCategory(id, categoryDTO);
        return ResponseEntity.ok(UpdateCategoryResponse.builder()
                                         .message(localizationUtils.getlocalizeMessage(MessageKeys.UPDATE_CATEGORY_SUCCESSFULLY))
                                         .build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<UpdateCategoryResponse> deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return ResponseEntity.ok(UpdateCategoryResponse.builder()
                                         .message(localizationUtils.getlocalizeMessage(MessageKeys.DELETE_CATEGORY_SUCCESSFULLY))
                                         .build());
    }
}
