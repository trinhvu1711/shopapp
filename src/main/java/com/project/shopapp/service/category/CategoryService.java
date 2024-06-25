package com.project.shopapp.service.category;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.repositories.CategoryRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.responses.CategoriesResponse;
import com.project.shopapp.responses.CategoryResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService implements ICategoryService {
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;

    @Override
    public Category createCategory(CategoryDTO categoryDTO) {
        Category category = Category.builder()
                .name(categoryDTO.getName())
                .imageUrl(categoryDTO.getImageUrl())
                .slug(categoryDTO.getSlug())
                .build();
        return categoryRepository.save(category);
    }

    @Override
    public Category getCategoryById(long id) {
        return categoryRepository.findById(id).orElseThrow(() -> new RuntimeException("Category not found"));
    }

    @Override
    public List<Category> getAllCategories(PageRequest pageRequest) {
        return categoryRepository.findAll(pageRequest).getContent();
    }

    @Override
    public Category updateCategory(long categoryId, CategoryDTO categoryDTO) {
        Category existingCategory = getCategoryById(categoryId);
        existingCategory.setName(categoryDTO.getName());
        existingCategory.setImageUrl(categoryDTO.getImageUrl());
        categoryRepository.save(existingCategory);
        return existingCategory;
    }

    @Override
    public void deleteCategory(long id) {
        Category existingCategory = categoryRepository.findById(id).orElseThrow(() -> new RuntimeException("Category not found"));
        existingCategory.getProducts().forEach(product -> {
            product.setCategory(null);
            productRepository.save(product);
        });

        categoryRepository.deleteById(id);
    }

    @Override
    public List<CategoriesResponse> getAllCategoriesAdmin() {
        List<Category> categories = categoryRepository.findAll();
        return categories.stream().map(category -> CategoriesResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .build()).toList();
    }

    @Override
    public List<CategoryResponse> getAllCategoriesResponse() {
        List<Category> categories = categoryRepository.findAll();
        return categories.stream().map(category -> CategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .imageUrl(category.getImageUrl())
                .slug(category.getSlug())
                .build()).toList();
    }
}
