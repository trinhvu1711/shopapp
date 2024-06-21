package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTOWithThumbnailFile {
    private String name;
    private String description;
    @JsonProperty("category_id")
    private long categoryId;
    @JsonProperty("variants")
    private List<Long> variants;
}
