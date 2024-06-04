package com.project.shopapp.service.coupon;

import com.project.shopapp.models.Coupon;
import com.project.shopapp.models.CouponCondition;
import com.project.shopapp.repositories.CouponConditionRepository;
import com.project.shopapp.repositories.CouponRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponService implements ICouponService {
    private final CouponRepository couponRepository;
    private final CouponConditionRepository couponConditionRepository;
    @Override
    public double calculateCouponValue(String couponCode, double totalAmount) {
        Coupon coupon = couponRepository.findByCode(couponCode)
                .orElseThrow(() -> new IllegalArgumentException("Coupon not found"));
        if (!coupon.isActive()) {
            throw  new IllegalArgumentException("Coupon is not active");
        }
        double discount = calculateDiscount(coupon, totalAmount);
        double finalAmount = totalAmount - discount;
        return finalAmount;
    }

    private double calculateDiscount(Coupon coupon, double totalAmount){
        List<CouponCondition> conditions = couponConditionRepository.findByCouponId(coupon.getId());
        double discount = 0.0;
        double updateTotalAmount = totalAmount;
        for (CouponCondition c: conditions){
            String attribute = c.getAttribute();
            String operator = c.getOperator();
            String value = c.getValue();
            double percentDiscount = Double.parseDouble(String.valueOf(c.getDiscountAmount()));
            if (attribute.equals("minimum_amount")){
                if(operator.equals(">") && updateTotalAmount > Double.parseDouble(value)){
                    discount += updateTotalAmount * percentDiscount / 100;
                }
            }else if (attribute.equals("applicable_date")){
                LocalDate applicableDate = LocalDate.parse(value);
                LocalDate currentDate = LocalDate.now();
                if (operator.equalsIgnoreCase("BETWEEN") && currentDate.isEqual(applicableDate)){
                    discount += updateTotalAmount * percentDiscount / 100;
                }
            }
            updateTotalAmount = updateTotalAmount - discount;
        }
        return discount;
    }

    @Override
    public List<Coupon> getAllCoupon() {
        return couponRepository.findAll();
    }
}
