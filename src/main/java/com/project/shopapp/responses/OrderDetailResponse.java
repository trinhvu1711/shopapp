package com.project.shopapp.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.shopapp.models.OrderDetail;
import com.project.shopapp.models.Product;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetailResponse {
    private Long id;
    private Long orderId;
    @JsonProperty("product_id")
    private Long productId;
    private Float price;
    @JsonProperty("number_of_products")
    private int numberOfProducts;
    @JsonProperty("total_money")
    private int totalMoney;
    private String color;

    public static OrderDetailResponse fromOrderDetail(OrderDetail orderDetail){
        return OrderDetailResponse
                .builder()
                .orderId(orderDetail.getOrder().getId())
                .id(orderDetail.getId())
                .productId(orderDetail.getProduct().getId())
                .price(orderDetail.getPrice())
                .numberOfProducts(orderDetail.getNumberOfProducts())
                .totalMoney(orderDetail.getTotalMoney())
                .color(orderDetail.getColor())
                .build();
    }
}
