package com.project.shopapp.responses;

import com.project.shopapp.models.Product;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductListResponse {
    private List<Product> products;
    private int totalPage;
}
