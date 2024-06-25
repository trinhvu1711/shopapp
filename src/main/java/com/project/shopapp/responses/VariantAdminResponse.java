package com.project.shopapp.responses;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class VariantAdminResponse {
    private long id;
    private String name;
    private List<OptionResponse> options;
    private boolean availableForSale;
    private Float price;
    private String currency;
    private Float discount;
}
