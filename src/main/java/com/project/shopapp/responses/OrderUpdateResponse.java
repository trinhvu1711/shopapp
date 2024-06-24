package com.project.shopapp.responses;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class OrderUpdateResponse {
    private String fullName;
    private String phoneNumber;
    private String status;
    private boolean isPaid;
    private String trackingNumber;
    private Date orderDate;
    List<OrderDetailsUpdate> orderDetails;
}
