package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name="list_cart")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ListCart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @Column(name = "active")
    private boolean active;
    @OneToMany(mappedBy = "listCart",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<Cart> carts;
}
