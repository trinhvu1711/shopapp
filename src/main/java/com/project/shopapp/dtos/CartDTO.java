package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.shopapp.models.ListCart;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.Min;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CartDTO {
    @JsonProperty("cart_id")
    @Min(value = 1, message = "Cart's ID must be > 0")
    private Long cartId;
    @JsonProperty("product_id")
    @Min(value = 1, message = "Product's ID must be > 0")
    private Long productId;

    @JsonProperty("list_cart_id")
    private Long listCartId;
    @Min(value = 0, message = "Cart's price must be > 0")
    private Float price;
    @Min(value = 1, message = "number of products must be > 0")
    @JsonProperty("number_of_products")
    private int numberOfProducts;
    @Min(value = 0, message = "total money must be > 0")
    @JsonProperty("total_money")
    private int totalMoney;
    @JsonProperty("id_product_variant")
    private Long idProductVariant ;
}
