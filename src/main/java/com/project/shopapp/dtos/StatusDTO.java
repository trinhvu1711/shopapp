package com.project.shopapp.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class StatusDTO {
    private Long orderId;
    private String status;
    private boolean isPaid;
}
