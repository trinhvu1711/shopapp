package com.project.shopapp.responses;

import com.project.shopapp.models.Role;
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
}
