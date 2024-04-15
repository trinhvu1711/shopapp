package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name="variants")
@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Variant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "available_for_sale", nullable = false)
    private boolean availableForSale;
    private float price;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
    private String currency;

}
