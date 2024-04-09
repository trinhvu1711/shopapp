package com.project.shopapp.repositories;

import com.project.shopapp.models.Product;
import com.project.shopapp.models.Variant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VariantRepository extends JpaRepository<Variant, Long> {
    List<Variant> getVariantsByProduct(Product product);
}
