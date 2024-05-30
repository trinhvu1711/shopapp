package com.project.shopapp.repositories;

import com.project.shopapp.models.Order;
import com.project.shopapp.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserId(long userId);
    @Query("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.orderDetails od WHERE o.id = :orderId")
    Optional<Order> getOrderWithOrderDetails(@Param("orderId") Long orderId);
    @Query("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.orderDetails od WHERE o.trackingNumber = :trackingNumber")
    Optional<Order> getOrderWithOrderDetailsByTrackingNumber(@Param("trackingNumber") String trackingNumber);
    @Query("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.orderDetails od WHERE o.user.id = :userId")
    Optional<Order> getOrderWithOrderDetailsUser(@Param("userId") Long userId);

    @Query("SELECT o FROM Order o WHERE o.user = :user " +
            "AND (:status IS NULL OR :status = '' OR o.status = :status)")
    Optional<List<Order>> getOrderByUserAndStatus(@Param("user") User user,
                                            @Param("status") String status);
    Optional<Order> getByTrackingNumber(@Param("trackingNumber") String trackingNumber);
}
