package com.project.shopapp.service;

import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.dtos.UserUpdateDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.User;
import com.project.shopapp.responses.LoginResponse;
import com.project.shopapp.responses.UserAdminResponse;

import java.util.List;

public interface IUserService {
    User createUser(UserDTO userDTO) throws DataNotFoundException;

    LoginResponse login(String phoneNumber, String password) throws Exception;

    User getUserDetailsFromToken(String extractedToken) throws Exception;

    List<UserAdminResponse> getAllUsers();

    User updateUser(long id, UserUpdateDTO userDTO) throws DataNotFoundException;
    boolean deleteUser(long id) throws DataNotFoundException;
}
