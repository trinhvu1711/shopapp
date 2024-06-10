package com.project.shopapp.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

public abstract class PaymentDTO {
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class VNPayResponse {
        public String code;
        public String message;
        public String paymentUrl;
    }

}