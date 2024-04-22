package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

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
    private String currency;
    @ManyToMany(cascade = { CascadeType.ALL })
    @JoinTable(
            name = "variant_options",
            joinColumns = { @JoinColumn(name = "variant_id") },
            inverseJoinColumns = { @JoinColumn(name = "option_id") }
    )
    private List<Option> options;
}
