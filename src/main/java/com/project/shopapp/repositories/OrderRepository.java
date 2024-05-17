package com.project.shopapp.repositories;

import com.project.shopapp.models.ListCart;
import com.project.shopapp.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserId(long userId);
    @Query("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.orderDetails od WHERE o.id = :orderId")
    Optional<Order> getOrderWithOrderDetails(@Param("orderId") Long orderId);
}
