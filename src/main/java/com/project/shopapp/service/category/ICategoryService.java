package com.project.shopapp.service.category;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.responses.CategoriesResponse;
import com.project.shopapp.responses.CategoryResponse;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface ICategoryService {
    Category createCategory(CategoryDTO categoryDTO);
    Category getCategoryById(long id);
    List<Category> getAllCategories(PageRequest pageRequest);
    Category updateCategory(long categoryId, CategoryDTO categoryDTO);
    void deleteCategory(long id);
    List<CategoriesResponse> getAllCategoriesAdmin();
    List<CategoryResponse> getAllCategoriesResponse();
}
