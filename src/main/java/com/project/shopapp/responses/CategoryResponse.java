package com.project.shopapp.responses;

import com.project.shopapp.models.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CategoryResponse {
    private long id;
    private String name;
    private String imageUrl;
    private String slug;
    public static CategoryResponse fromCategory(Category category) {
        return CategoryResponse.builder()
                .name(category.getName())
                .id(category.getId())
                .imageUrl(category.getImageUrl())
                .slug(category.getSlug())
                .build();
    }

}
