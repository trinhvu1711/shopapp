package com.project.shopapp.repositories;

import com.project.shopapp.models.ListCart;
import com.project.shopapp.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ListCartRepository extends JpaRepository<ListCart, Long> {
    List<ListCart> findByUserId(long userId);
}
