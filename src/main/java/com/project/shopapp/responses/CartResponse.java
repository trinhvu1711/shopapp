package com.project.shopapp.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.shopapp.models.Cart;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CartResponse {
    private Long id;
    @JsonProperty("list_cart_id")
    private Long listCartId;
    @JsonProperty("product_id")
    private Long productId;
    private Float price;
    @JsonProperty("number_of_products")
    private int numberOfProducts;
    @JsonProperty("total_money")
    private int totalMoney;
    @JsonProperty("id_product_variant")
    private Long idProductVariant ;

    public static CartResponse fromCart(Cart cart){
        return CartResponse
                .builder()
                .listCartId(cart.getListCart().getId())
                .id(cart.getId())
                .productId(cart.getProduct().getId())
                .price(cart.getPrice())
                .numberOfProducts(cart.getNumberOfProducts())
                .totalMoney(cart.getTotalMoney())
                .idProductVariant(cart.getIdProductVariant())
                .build();
    }
}
