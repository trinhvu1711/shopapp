package com.project.shopapp.controller;

import com.project.shopapp.dtos.ListCartDTO;
import com.project.shopapp.models.ListCart;
import com.project.shopapp.service.ListCartService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/list_carts")
@RequiredArgsConstructor
public class ListCartController {
    private final ListCartService listCartService;
    @PostMapping("")
    public ResponseEntity<?> createListCart(@RequestBody @Valid ListCartDTO listCartDTO,
                                         BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            ListCart listCart = listCartService.createListCart(listCartDTO);
            return ResponseEntity.ok(listCart);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/user/{user_id}")//http://localhost:8088/api/v1/listCarts/6
    public ResponseEntity<?> getListCarts(
            @Valid @PathVariable("user_id") Long userId) {
       try {
           List<ListCart> listCarts = listCartService.findByUserId(userId);
           return ResponseEntity.ok(listCarts);
       } catch (Exception e){
           return ResponseEntity.badRequest().body(e.getMessage());
       }
    }

    @GetMapping("/{id}")//http://localhost:8088/api/v1/listCarts/6
    public ResponseEntity<?> getListCart(
            @Valid @PathVariable("id") Long listCartId) {
        try {
            ListCart existingListCart = listCartService.getListCart(listCartId);
            return ResponseEntity.ok(existingListCart);
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/{id}")//http://localhost:8088/api/v1/listCarts/6
    public ResponseEntity<?> updateListCarts(
            @Valid @PathVariable("id") Long id,
            @Valid @RequestBody ListCartDTO listCartDTO) {
        try {
            ListCart existingListCart = listCartService.updateListCart(id, listCartDTO);
            return ResponseEntity.ok(existingListCart);
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @DeleteMapping("/{id}")//http://localhost:8088/api/v1/listCarts/6
    public ResponseEntity<?> deleteListCarts(
            @Valid @PathVariable("id") Long id) {
        try {
            listCartService.deleteListCart(id);
            return ResponseEntity.ok(String.format("delete listCart with listCart id = %s", id));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
}
