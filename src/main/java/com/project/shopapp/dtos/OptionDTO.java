package com.project.shopapp.dtos;

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
}
