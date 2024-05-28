package com.project.shopapp.repositories;

import com.project.shopapp.models.WishList;
import com.project.shopapp.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface WishListRepository extends JpaRepository<WishList, Long> {
    Optional<List<WishList>> getWishListByUserAndActiveIsTrue(User user);
    Optional<WishList> findByProductIdAndIdProductVariantAndUserId(Long productId, long idProductVariant, Long userId);
}
