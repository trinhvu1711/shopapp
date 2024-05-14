package com.project.shopapp.controller;

import com.project.shopapp.dtos.CartDTO;
import com.project.shopapp.dtos.CartDTO;
import com.project.shopapp.models.Cart;
import com.project.shopapp.responses.CartResponse;
import com.project.shopapp.service.CartService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/carts")
@RequiredArgsConstructor
public class CartController {
    private final CartService cartService;
    @PostMapping("")
    public ResponseEntity<?> createCart(@RequestBody @Valid CartDTO cartDTO,
                                         BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            Cart newCart = cartService.createCart(cartDTO);
            CartResponse cartResponse = CartResponse.fromCart(newCart);
            return ResponseEntity.ok(cartResponse);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{id}")//http://localhost:8088/api/v1/order_details/6
    public ResponseEntity<?> getCart(
            @Valid @PathVariable("id") Long id) {
        try {
            Cart orderDetail = cartService.getCart(id);
            return ResponseEntity.ok(CartResponse.fromCart(orderDetail));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/order/{listCartId}")//http://localhost:8088/api/v1/order_details/6
    public ResponseEntity<?> getCarts(
            @Valid @PathVariable("listCartId") Long listCartId) {
        try {
            List<Cart> orderDetails = cartService.findByListCartsId(listCartId);
            List<CartResponse> cartResponse = orderDetails.stream().map(CartResponse::fromCart).toList();
            return ResponseEntity.ok(cartResponse);
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/{id}")//http://localhost:8088/api/v1/orders_detail/6
    public ResponseEntity<?> updateCart(
            @Valid @PathVariable("id") Long id,
            @Valid @RequestBody CartDTO cartDTO) {
        try {
            Cart orderDetail = cartService.updateCart(id,cartDTO);
            return ResponseEntity.ok(orderDetail);
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @DeleteMapping("/{id}")//http://localhost:8088/api/v1/order_detail/6
    public ResponseEntity<?> deleteCart(
            @Valid @PathVariable("id") Long id) {
        try {
            cartService.deleteCart(id);
            return ResponseEntity.ok(String.format("Delete order detail with id = %s successfully", id));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
}
