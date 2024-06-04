package com.project.shopapp.controller;

import com.project.shopapp.models.Coupon;
import com.project.shopapp.responses.CouponCalculationResponse;
import com.project.shopapp.service.coupon.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/coupons")
@RequiredArgsConstructor
public class CouponController {
    private final CouponService couponService;

    //    show all category
    @GetMapping("")//http://localhost:8088/api/v1/categories?page=10&limit=10
    public ResponseEntity<List<Coupon>> getAllCoupon() {

        List<Coupon> coupon = couponService.getAllCoupon();
        return ResponseEntity.ok(coupon);
    }

    @GetMapping("/calculate")
    public ResponseEntity<CouponCalculationResponse> calculateCouponValue(
            @RequestParam("couponCode") String couponCode,
            @RequestParam("totalAmount") double totalAmount) {
        try {
            double finalAmount = couponService.calculateCouponValue(couponCode, totalAmount);
            CouponCalculationResponse response = CouponCalculationResponse
                    .builder()
                    .result(finalAmount)
                    .errorMessage("")
                    .build();
            return ResponseEntity.ok(response);

        }catch (Exception e){
            return ResponseEntity.badRequest().body(
                    CouponCalculationResponse.builder().result(totalAmount).errorMessage(e.getMessage()).build());
        }
    }
}
