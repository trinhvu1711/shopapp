package com.project.shopapp.service;

import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.models.Order;

import java.util.List;

public interface IOrderService {
    Order createOrder(OrderDTO orderDTO) throws Exception;
    Order getOrder(Long id);
    Order getOrderByTrackingNumber(String trackingNumber);
    Order getOrderByUserId(Long userId);
    Order updateOrder(Long id, OrderDTO orderDTO) throws Exception;
    void deleteOrder(Long id);
    List<Order> findByUserId(Long userId);

    List<Order> getOrdersFromToken(String extractedToken, String status) throws Exception;

    Order updateOrderStatus(String extractedToken, String trackingNumber, String status) throws Exception;
}
