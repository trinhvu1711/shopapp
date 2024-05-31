package com.project.shopapp.repositories;

import com.project.shopapp.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {
    boolean existsByName(String name);

    Page<Product> findAll(Pageable pageable);

    @Query("SELECT p FROM Product p WHERE " +
            "(:categoryId IS NULL OR :categoryId = 0 OR p.category.id = :categoryId) " +
            "AND (:keyword IS NULL OR :keyword = '' OR p.name LIKE %:keyword% OR p.description LIKE %:keyword%)")
    Page<Product> searchProducts
            (@Param("categoryId") Long categoryId,
             @Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT p FROM Product p WHERE p.name LIKE %:keyword%")
    List<Product> searchProducts(@Param("keyword") String keyword);

    // Query to fetch product with images
    @Query("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.productImages pi WHERE p.id = :productId")
    Optional<Product> getProductWithImages(@Param("productId") Long productId);

    // Query to fetch product with variants
    @Query("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.variants v WHERE p.id = :productId")
    Optional<Product> getProductWithVariants(@Param("productId") Long productId);
}
