package com.project.shopapp.service.coupon;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Coupon;
import com.project.shopapp.responses.CategoriesResponse;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface ICouponService {
    double calculateCouponValue(String couponCode, double totalAmount);
    List<Coupon> getAllCoupon();
}
