package com.project.shopapp.controller;

import com.project.shopapp.dtos.OrderDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/orders")
public class OrderController {
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
            return ResponseEntity.ok("create order successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{user_id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> getOrders(
            @Valid @PathVariable("user_id") Long userId) {
       try {
           return ResponseEntity.ok(String.format("get order with user id = %s", userId));
       } catch (Exception e){
           return ResponseEntity.badRequest().body(e.getMessage());
       }
    }

    @PutMapping("/{id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> updateOrders(
            @Valid @PathVariable("id") Long id,
            @Valid @RequestBody OrderDTO orderDTO) {
        try {
            return ResponseEntity.ok(String.format("update order with order id = %s", id));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @DeleteMapping("/{id}")//http://localhost:8088/api/v1/orders/6
    public ResponseEntity<?> deleteOrders(
            @Valid @PathVariable("id") Long id) {
        try {
            return ResponseEntity.ok(String.format("delete order with order id = %s", id));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
}
