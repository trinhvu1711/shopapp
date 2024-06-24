package com.project.shopapp.responses;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class OrderDetailsUpdate {
    private String productName;
    private int numberOfProducts;
    private float price;
    private int totalMoney;
}
