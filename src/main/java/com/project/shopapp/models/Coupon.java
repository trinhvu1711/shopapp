package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name="coupons")
@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Coupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "code", nullable = false, unique = true)
    private String code;
    @Column(name = "active", nullable = false)
    private boolean active;
//    @OneToMany(mappedBy = "coupon",
//            cascade = CascadeType.ALL,
//            fetch = FetchType.LAZY)
//    private List<CouponCondition> couponCondition;

}
