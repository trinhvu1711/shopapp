package com.project.shopapp.controller;

import com.project.shopapp.dtos.WishListDTO;
import com.project.shopapp.models.WishList;
import com.project.shopapp.service.WishListService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/wishlist")
@RequiredArgsConstructor
public class WishlistController {
    private final WishListService wishListService;

    @PostMapping("")
    public ResponseEntity<?> createWishList(@RequestBody @Valid WishListDTO wishlistDTO,
                                            BindingResult result, @RequestHeader("Authorization") String token) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            String extractedToken = token.substring(7);
            WishList newWishList = wishListService.createWishList(wishlistDTO, extractedToken);
            return ResponseEntity.ok(newWishList);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")//http://localhost:8088/api/v1/order_detail/6
    public ResponseEntity<?> deleteWishList(
            @Valid @PathVariable("id") Long id) {
        try {
            wishListService.deleteWishList(id);
            return ResponseEntity.ok(String.format("Delete order detail with id = %s successfully", id));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }
    @PostMapping("/details")
    public ResponseEntity<?> getWishListByToken(
            @RequestHeader("Authorization") String token
    ) {
        try {
            String extractedToken = token.substring(7);
            List<WishList> wishList = wishListService.getWishListsFromToken(extractedToken);
            return ResponseEntity.ok(wishList);
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
