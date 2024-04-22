package com.project.shopapp.repositories;

import com.project.shopapp.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {
    boolean existsByName(String name);
    Page<Product> findAll(Pageable pageable);
    @Query("SELECT DISTINCT p FROM Product p " +
            "LEFT JOIN FETCH p.productImages pi " +
            "LEFT JOIN FETCH p.variants v " +
            "WHERE p.id = :productId")
    Optional<Product> getDetailProduct(@Param("productId") Long productId);

    // Query to fetch product with images
    @Query("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.productImages pi WHERE p.id = :productId")
    Optional<Product> getProductWithImages(@Param("productId") Long productId);

    // Query to fetch product with variants
    @Query("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.variants v WHERE p.id = :productId")
    Optional<Product> getProductWithVariants(@Param("productId") Long productId);
}
