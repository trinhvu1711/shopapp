package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OptionDTO {
    @NotEmpty(message = "option's name cannot be empty")
    private String name;
    @NotEmpty(message = "option's value cannot be empty")
    private String value;
    @JsonProperty("variant_id")
    @Min(value = 1, message = "Variant's id must be > 0")
    private long variantId;
}
