package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="products")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Product extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name", nullable = false, length = 350)
    private String name;

    @Column(name = "thumbnail", length = 300)
    private String thumbnail;
    private String description;
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
    @Column(name="description_html")
    private String descriptionHtml;
    @OneToMany(mappedBy = "product",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<ProductImage> productImages;
    @ManyToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY)
    @JoinTable(
            name = "product_variants",
            joinColumns = { @JoinColumn(name = "product_id") },
            inverseJoinColumns = { @JoinColumn(name = "variant_id") }
    )
    private List<Variant> variants;
    @OneToMany(mappedBy = "product",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<Comment> comments = new ArrayList<>();
}
