package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

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

}
