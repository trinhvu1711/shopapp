package com.project.shopapp.service;

import com.project.shopapp.dtos.CartDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Cart;
import com.project.shopapp.models.ListCart;
import com.project.shopapp.models.Product;
import com.project.shopapp.repositories.CartRepository;
import com.project.shopapp.repositories.ListCartRepository;
import com.project.shopapp.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CartService implements ICartService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final ListCartRepository listCartRepository;
    @Override
    public Cart createCart(CartDTO cartDTO) throws Exception {
        Product product = productRepository.findById(cartDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find Product with id: " + cartDTO.getProductId()));
        ListCart listCart = listCartRepository.findById(cartDTO.getListCartId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find List Cart with id: " + cartDTO.getListCartId()));
        Cart cartDetail = Cart
                .builder()
                .listCart(listCart)
                .numberOfProducts(cartDTO.getNumberOfProducts())
                .totalMoney((int) (cartDTO.getPrice() * cartDTO.getNumberOfProducts()))
                .product(product)
                .price(cartDTO.getPrice())
                .idProductVariant(cartDTO.getIdProductVariant())
                .build();
        return cartRepository.save(cartDetail);
    }

    @Override
    public Cart getCart(Long id) throws Exception {
        return cartRepository.findById(id).orElseThrow(() -> new DataNotFoundException("Cannot find Cart with id "+ id));
    }

    @Override
    public Cart updateCart(Long id, CartDTO cartDTO) throws Exception {
        Cart existingCart = cartRepository.findById(id)
                .orElseThrow(() ->new DataNotFoundException("cannot find Cart with id"));
        Product existingProduct = productRepository.findById(cartDTO.getProductId())
                .orElseThrow(() ->new DataNotFoundException("cannot find Product with productId"));
        existingCart.setIdProductVariant(cartDTO.getIdProductVariant());
        existingCart.setTotalMoney((int) (existingCart.getPrice() * existingCart.getNumberOfProducts()));
        existingCart.setProduct(existingProduct);
        existingCart.setNumberOfProducts(cartDTO.getNumberOfProducts());
        existingCart.setTotalMoney(cartDTO.getTotalMoney());
        return cartRepository.save(existingCart);
    }

    @Override
    public Cart updateCartQuantity(Long id, int quantity, int totalMoney) throws Exception {
        Cart existingCart = cartRepository.findById(id)
                .orElseThrow(() ->new DataNotFoundException("cannot find Cart with id"));
        existingCart.setNumberOfProducts(quantity);
        existingCart.setTotalMoney(totalMoney);
        return cartRepository.save(existingCart);
    }

    @Override
    public void deleteCart(Long id) {
        cartRepository.deleteById(id);
    }

    @Override
    public List<Cart> findByListCartsId(Long listCartsId) {
        return cartRepository.findByListCartId(listCartsId);
    }

    @Override
    public Optional<Cart> getExistingCart(Long productId, Long listCartId, long idProductVariant) {
        return cartRepository.findByProductIdAndListCartIdAndIdProductVariant(productId, listCartId, idProductVariant);
    }
}
