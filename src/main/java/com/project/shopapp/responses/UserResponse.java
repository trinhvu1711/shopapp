package com.project.shopapp.responses;

import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserResponse {
    private Long id;
    private String fullName;
    private String phoneNumber;
    private String email;
    private String address;
    private boolean active;
    private Date dateOfBirth;
    private int facebookAccountId;
    private int googleAccountId;
    private Role role;
    private String image;
    public static UserResponse fromUser(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .fullName(user.getFullName())
                .phoneNumber(user.getPhoneNumber())
                .address(user.getAddress())
                .active(user.isActive())
                .dateOfBirth(user.getDateOfBirth())
                .facebookAccountId(user.getFacebookAccountId())
                .googleAccountId(user.getGoogleAccountId())
                .role(user.getRole())
                .build();
    }
}
