package com.project.shopapp.responses;

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
}
