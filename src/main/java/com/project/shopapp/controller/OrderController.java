package com.project.shopapp.controller;

import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.dtos.StatusDTO;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.User;
import com.project.shopapp.responses.OrderAdminResponse;
import com.project.shopapp.responses.OrderUpdateResponse;
import com.project.shopapp.service.order.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

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

    @PostMapping("/update-status")
    public ResponseEntity<?> updateOrderStatus(@RequestBody StatusDTO statusDTO, BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            orderService.updateOrderAddminStatus(statusDTO);

            return ResponseEntity.ok("Update status successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<?> getOrdersUpdateResponse(
            @Valid @PathVariable("id") Long id) {
        try {
            OrderUpdateResponse orders = orderService.getOrderUpdateResponse(id);
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

    @GetMapping("/get-all")//http://localhost:8088/api/v1/orders/get-all
    public ResponseEntity<?> getAllOrders() {
        try {
            List<OrderAdminResponse> existingOrder = orderService.getAllOrders();
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
            Order existingOrder = orderService.updateOrderStatus(extractedToken, trackingNumber, "canceled");
            return ResponseEntity.ok(existingOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/pay")//http://localhost:8088/api/v1/orders/pay
    public ResponseEntity<?> payOrder(@Valid @RequestParam String trackingNumber) {
        try {
            Order existingOrder = orderService.getOrderByTrackingNumber(trackingNumber);
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !(authentication.getPrincipal() instanceof User user)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized access");
            }

            if (!Objects.equals(user.getId(), existingOrder.getUser().getId())) {
                return ResponseEntity.badRequest().body("You cannot pay as another user");
            }
            return ResponseEntity.ok(orderService.paidOrder(trackingNumber));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
