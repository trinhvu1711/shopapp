package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class VariantDTO {
    @JsonProperty("option_id")
    private long optionId;
    @NotEmpty(message = "variant's name cannot be empty")
    private String name;
    @JsonProperty("available_for_sale")
    private boolean availableForSale;
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    @Max(value = 10000000, message = "Price must be less than or equal to 10,000,000")
    private Float price;
    @JsonProperty("product_id")
    @Min(value = 1, message = "Product's id must be > 0")
    private long productId;
}
