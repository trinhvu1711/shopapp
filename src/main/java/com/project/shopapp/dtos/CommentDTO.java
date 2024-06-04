package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CommentDTO {
    @JsonProperty("product_id")
    private long productId;
    @JsonProperty("user_id")
    private long userId;
    private String content;
}
