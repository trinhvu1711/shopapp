package com.project.shopapp.repositories;

import com.project.shopapp.models.Product;
import com.project.shopapp.models.Variant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface VariantRepository extends JpaRepository<Variant, Long> {
//    List<Variant> getVariantsByProduct(Product product);
    boolean existsByName(String name);
    Page<Variant> findAll(Pageable pageable);
    @Query("SELECT v FROM Variant v LEFT JOIN FETCH v.options WHERE v.id = :variantId")
    Optional<Variant> getVariant(@Param("variantId") Long variantId);

}
