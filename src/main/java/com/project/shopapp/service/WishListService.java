package com.project.shopapp.service;

import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.dtos.WishListDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.WishList;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.WishListRepository;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class WishListService implements IWishListService {
    private final UserRepository userRepository;
    private final WishListRepository wishListRepository;
    private final JwtTokenUtil jwtTokenUtil;
    private final ProductRepository productRepository;

    @Override
    public WishList createWishList(WishListDTO wishListDTO, String token) throws Exception {

        String email = jwtTokenUtil.extractEmail(token);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            Long userId = user.get().getId();
            Optional<WishList> existingWishList = getExistingWishList(wishListDTO.getProductId(), wishListDTO.getIdProductVariant(), userId);
            if (existingWishList.isPresent()) {
                return null;
            }
            Product product = productRepository.findById(wishListDTO.getProductId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find Product with id: " + wishListDTO.getProductId()));

            WishList wishList = WishList.builder()
                    .product(product)
                    .idProductVariant(wishListDTO.getIdProductVariant())
                    .user(user.get())
                    .build();
            wishList.setActive(true);
            wishListRepository.save(wishList);
            return wishList;
        }
        return null;
    }


    @Override
    public void deleteWishList(Long id) {
        WishList wishList = wishListRepository.findById(id).orElseThrow(null);
        wishListRepository.delete(wishList);

    }


    @Override
    public List<WishList> getWishListsFromToken(String extractedToken) throws Exception {
        if (jwtTokenUtil.isTokenExpired(extractedToken)) {
            throw new Exception("Token is expired");
        }
        String email = jwtTokenUtil.extractEmail(extractedToken);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            Optional<List<WishList>> wishList = wishListRepository.getWishListByUserAndActiveIsTrue(user.get());
            if (wishList.isPresent()) {
                return wishList.get();
            }
        } else {
            throw new Exception("WishList not found");
        }
        return null;
    }

    @Override
    public Optional<WishList> getExistingWishList(Long productId, Long userId, Long idProductVariant) {
        return wishListRepository.findByProductIdAndIdProductVariantAndUserId(productId, userId, idProductVariant);
    }
}
