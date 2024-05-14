package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name="cart")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "list_cart_id")
    private ListCart listCart;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    @Column(name = "price", nullable = false)
    private float price;
    @Column(name = "number_of_products", nullable = false)
    private int numberOfProducts;
    @Column(name = "total_money", nullable = false)
    private int totalMoney;
    @Column(name = "id_product_variant", nullable = false)
    private long idProductVariant;
}
