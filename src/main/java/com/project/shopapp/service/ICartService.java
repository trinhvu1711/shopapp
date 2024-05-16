package com.project.shopapp.service;

import com.project.shopapp.dtos.CartDTO;
import com.project.shopapp.models.Cart;

import java.util.List;
import java.util.Optional;

public interface ICartService {
    Cart createCart(CartDTO cartDTO) throws Exception;
    Cart getCart(Long id) throws Exception;
    Cart updateCart(Long id, CartDTO cartDTO) throws Exception;
    Cart updateCartQuantity(Long id, int quantity, int totalMoney) throws Exception;

    void deleteCart(Long id);
    List<Cart> findByListCartsId(Long listCartsId);
    Optional<Cart> getExistingCart(Long productId, Long listCartId, long idProductVariant);
}
