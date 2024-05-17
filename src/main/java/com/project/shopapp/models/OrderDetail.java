package com.project.shopapp.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name="order_details")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "order_id")
    private Order order;
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
