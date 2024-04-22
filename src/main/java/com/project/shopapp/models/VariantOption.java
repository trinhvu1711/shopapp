package com.project.shopapp.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name="variant_options")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class VariantOption {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "variant_id")
    @JsonIgnore
    private Variant variant;
    @JoinColumn(name = "option_id")
    @OneToMany
    private List<Option> option;

}
