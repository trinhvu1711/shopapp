package com.project.shopapp.controller;

import com.project.shopapp.service.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/coupons")
@RequiredArgsConstructor
public class CouponController {
    private final CouponService couponService;

    @GetMapping("/calculate")
    public ResponseEntity<Double> calculateCouponValue(
            @RequestParam("couponCode") String couponCode,
            @RequestParam("totalAmount") double totalAmount) {
        double finalAmount = couponService.calculateCouponValue(couponCode, totalAmount);
        return ResponseEntity.ok(finalAmount);
    }
}
