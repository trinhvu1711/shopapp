package com.project.shopapp.responses;

import com.project.shopapp.models.Order;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class OrderAdminResponse {
    private Long id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String address;
    private String status;
    private String note;
    private boolean paid;
    private LocalDate shippingDate;
    private Date orderDate;
    private String trackingNumber;
    public static OrderAdminResponse fromOrderAdminResponse(Order orderAdminResponse){
        return OrderAdminResponse
                .builder()
                .id(orderAdminResponse.getId())
                .fullName(orderAdminResponse.getFullName())
                .email(orderAdminResponse.getEmail())
                .phoneNumber(orderAdminResponse.getPhoneNumber())
                .address(orderAdminResponse.getAddress())
                .status(orderAdminResponse.getStatus())
                .note(orderAdminResponse.getNote())
                .paid(orderAdminResponse.isPaid())
                .shippingDate(orderAdminResponse.getShippingDate())
                .orderDate(orderAdminResponse.getOrderDate())
                .trackingNumber(orderAdminResponse.getTrackingNumber())
                .build();
    }
}
