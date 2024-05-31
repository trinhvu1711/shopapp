package com.project.shopapp.responses;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductAdminResponse {
    private long id;
    private String name;
    private String category;
    private String description;
    private List<String> variant;
    private List<String> price;
}
