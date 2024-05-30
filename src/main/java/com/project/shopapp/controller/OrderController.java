package com.project.shopapp.controller;

import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.models.Order;
import com.project.shopapp.service.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @PostMapping("")
    public ResponseEntity<?> createOrder(@RequestBody @Valid OrderDTO orderDTO,
                                         BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            Order order = orderService.createOrder(orderDTO);
            return ResponseEntity.ok(order);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/user/{user_id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> getOrders(
            @Valid @PathVariable("user_id") Long userId) {
        try {
            List<Order> orders = orderService.findByUserId(userId);
            return ResponseEntity.ok(orders);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/tracking/{tracking_number}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> getOrders(
            @Valid @PathVariable("tracking_number") String trackingNumber) {
        try {
            Order orders = orderService.getOrderByTrackingNumber(trackingNumber);
            return ResponseEntity.ok(orders);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> getOrder(
            @Valid @PathVariable("id") Long orderId) {
        try {
            Order existingOrder = orderService.getOrder(orderId);
            return ResponseEntity.ok(existingOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/{id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> updateOrders(
            @Valid @PathVariable("id") Long id,
            @Valid @RequestBody OrderDTO orderDTO) {
        try {
            Order existingOrder = orderService.updateOrder(id, orderDTO);
            return ResponseEntity.ok(existingOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @DeleteMapping("/{id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> deleteOrders(
            @Valid @PathVariable("id") Long id) {
        try {
            orderService.deleteOrder(id);
            return ResponseEntity.ok(String.format("delete order with order id = %s", id));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @PostMapping("/details")//http://localhost:8088/api/v1/orders/details
    public ResponseEntity<?> getOrderByToken(
            @RequestHeader("Authorization") String token, @RequestParam(defaultValue = "") String status) {
        try {
            String extractedToken = token.substring(7);
            List<Order> existingOrder = orderService.getOrdersFromToken(extractedToken, status);
            return ResponseEntity.ok(existingOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/cancel")//http://localhost:8088/api/v1/orders/cancel
    public ResponseEntity<?> cancelOrder(
            @RequestHeader("Authorization") String token, @RequestParam String trackingNumber) {
        try {
            String extractedToken = token.substring(7);
            Order existingOrder = orderService.updateOrderStatus(extractedToken,trackingNumber, "canceled");
            return ResponseEntity.ok(existingOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
