package com.project.shopapp.controller;

import com.project.shopapp.dtos.CartDTO;
import com.project.shopapp.models.Cart;
import com.project.shopapp.responses.CartResponse;
import com.project.shopapp.service.cart.CartService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

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
            // Check if the product already exists in the cart
            Optional<Cart> existingItemOptional = cartService.getExistingCart(cartDTO.getProductId(), cartDTO.getListCartId(), cartDTO.getIdProductVariant());
            if (existingItemOptional.isPresent()) {
                // If the product exists, update its quantity
                Cart existingItem = existingItemOptional.get();
                int totalQuantity = existingItem.getNumberOfProducts() + cartDTO.getNumberOfProducts();
                int totalMoney = (int) (existingItem.getPrice() * totalQuantity);
                return ResponseEntity.ok(cartService.updateCartQuantity(existingItem.getId(), totalQuantity, totalMoney));
            } else {
                // If the product doesn't exist, create a new cart item
                Cart newCart = cartService.createCart(cartDTO);
                CartResponse cartResponse = CartResponse.fromCart(newCart);
                return ResponseEntity.ok(cartResponse);
            }



        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{id}")//http://localhost:8088/api/v1/order_details/6
    public ResponseEntity<?> getCart(
            @Valid @PathVariable("id") Long id) {
        try {
            Cart cart = cartService.getCart(id);
            return ResponseEntity.ok(CartResponse.fromCart(cart));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/order/{listCartId}")//http://localhost:8088/api/v1/order_details/6
    public ResponseEntity<?> getCarts(
            @Valid @PathVariable("listCartId") Long listCartId) {
        try {
            List<Cart> carts = cartService.findByListCartsId(listCartId);
            List<CartResponse> cartResponse = carts.stream().map(CartResponse::fromCart).toList();
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
            Cart cart = cartService.updateCart(id,cartDTO);
            return ResponseEntity.ok(cart);
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
    @PutMapping("/update_quantity/{id}") // http://localhost:8088/api/v1/orders_detail/6?quantity=10
    public ResponseEntity<?> updateCartQuantity(
            @PathVariable("id") Long id,
            @RequestParam("quantity") int quantity) {
        try {
            Cart existingItem = cartService.getCart(id);
            int totalMoney = (int) (existingItem.getPrice() * quantity);
            Cart cart = cartService.updateCartQuantity(id, quantity, totalMoney);
            return ResponseEntity.ok(cart);
        } catch (Exception e) {
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
