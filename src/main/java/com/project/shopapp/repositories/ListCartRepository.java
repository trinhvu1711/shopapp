package com.project.shopapp.repositories;

import com.project.shopapp.models.ListCart;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ListCartRepository extends JpaRepository<ListCart, Long> {
    List<ListCart> findByUserId(long userId);
    @Query("SELECT DISTINCT lc FROM ListCart lc LEFT JOIN FETCH lc.carts c WHERE lc.id = :listCartId")
    Optional<ListCart> getListCartWithCarts(@Param("listCartId") Long listCartId);
}
