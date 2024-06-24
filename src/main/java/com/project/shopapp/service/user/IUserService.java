package com.project.shopapp.service.user;

import com.project.shopapp.dtos.UpdateUserDTO;
import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.dtos.UserUpdateDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import com.project.shopapp.responses.LoginResponse;
import com.project.shopapp.responses.UserAdminResponse;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

public interface IUserService {
    User createUser(UserDTO userDTO) throws DataNotFoundException;

    LoginResponse login(String phoneNumber, String password) throws Exception;

    User getUserDetailsFromToken(String extractedToken) throws Exception;

    List<UserAdminResponse> getAllUsers();

    User updateUserAdmin(long id, UserUpdateDTO userDTO) throws DataNotFoundException;
    boolean deleteUser(long id) throws DataNotFoundException;
    @Transactional
    User updateUser(Long userId, UpdateUserDTO userDTO) throws Exception;
    List<Role> getAllRole() throws DataNotFoundException;
    User getUserById(Long userId) throws DataNotFoundException;
}
