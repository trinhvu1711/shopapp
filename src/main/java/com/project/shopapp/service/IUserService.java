package com.project.shopapp.service;

import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.User;
import com.project.shopapp.responses.LoginResponse;

public interface IUserService {
    User createUser(UserDTO userDTO) throws DataNotFoundException;
    LoginResponse login(String phoneNumber, String password) throws Exception;

    User getUserDetailsFromToken(String extractedToken) throws Exception;
}
