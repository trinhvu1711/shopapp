package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VariantAdminDTO {
    private long id;
    @JsonProperty("options")
    private List<Long> options;
    @JsonProperty("available_for_sale")
    private boolean availableForSale;
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    @Max(value = 100000000, message = "Price must be less than or equal to 100,000,000")
    private Float price;
    @NotEmpty(message = "currency cannot be empty")
    private String currency;
    private Float discount;
}
