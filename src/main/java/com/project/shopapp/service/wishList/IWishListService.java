package com.project.shopapp.service.wishList;

import com.project.shopapp.dtos.WishListDTO;
import com.project.shopapp.models.WishList;

import java.util.List;
import java.util.Optional;

public interface IWishListService {
    WishList createWishList(WishListDTO wishListDTO, String token) throws Exception;

    void deleteWishList(Long id);

    List<WishList> getWishListsFromToken(String extractedToken) throws Exception;
    Optional<WishList> getExistingWishList(Long productId, Long userId, Long idProductVariant);
}
