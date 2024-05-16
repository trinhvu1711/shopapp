package com.project.shopapp.repositories;

import com.project.shopapp.models.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {
    List<Cart> findByListCartId(Long listCartId);
    Optional<Cart> findByProductIdAndListCartIdAndIdProductVariant(Long productId, Long listCartId, long idProductVariant);
}
