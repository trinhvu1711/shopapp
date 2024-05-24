package com.project.shopapp.service;

import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.RoleRepository;
import com.project.shopapp.repositories.UserRepository;
import com.project.shopapp.responses.LoginResponse;
import com.project.shopapp.responses.UserResponse;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService{
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenUtil jwtTokenUtil;
    private final AuthenticationManager authenticationManager;
    @Override
    public User createUser(UserDTO userDTO) throws DataNotFoundException {
        String email = userDTO.getEmail();
        if (userRepository.existsByEmail(email)){
            throw new DataIntegrityViolationException("Email already exists");
        }
        User newUser = User.builder()
                .fullName(userDTO.getFullName())
                .phoneNumber(userDTO.getPhoneNumber())
                .password(userDTO.getPassword())
                .address(userDTO.getAddress())
                .dateOfBirth(userDTO.getDateOfBirth())
                .facebookAccountId(userDTO.getFacebookAccountId())
                .googleAccountId(userDTO.getGoogleAccountId())
                .email(userDTO.getEmail())
                .build();
        Role role = roleRepository.findById(userDTO.getRoleId()).orElseThrow(()-> new DataNotFoundException("Role not found"));
        newUser.setRole(role);
         if (userDTO.getFacebookAccountId() == 0 && userDTO.getGoogleAccountId() == 0){
             String password = userDTO.getPassword();
             String encodedPassword = passwordEncoder.encode(password);
             newUser.setPassword(encodedPassword);
         }
        return userRepository.save(newUser);
    }

    @Override
    public LoginResponse login(String email, String password) throws Exception{
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if(optionalUser.isEmpty()){
            throw new DataNotFoundException("Invalid email / password");
        }
        User existingUser = optionalUser.get();
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                email, password, existingUser.getAuthorities()
        );

        if (existingUser.getFacebookAccountId() == 0
                && existingUser.getGoogleAccountId() == 0){
            if (!passwordEncoder.matches(password, existingUser.getPassword())){
                throw new BadCredentialsException("Wrong email or password");
            }
        }
        authenticationManager.authenticate(authenticationToken);
        String jwtToken = jwtTokenUtil.generateToken(existingUser);
        UserResponse userResponse = UserResponse.builder()
                .id(existingUser.getId())
                .active(existingUser.isActive())
                .role(existingUser.getRole())
                .googleAccountId(existingUser.getGoogleAccountId())
                .address(existingUser.getAddress())
                .phoneNumber(existingUser.getPhoneNumber())
                .fullName(existingUser.getFullName())
                .facebookAccountId(existingUser.getFacebookAccountId())
                .email(existingUser.getEmail())
                .dateOfBirth(existingUser.getDateOfBirth())
                .build();
        return LoginResponse.builder()
                .accessToken(jwtToken)
                .userResponse(userResponse)
                .build();
    }

    @Override
    public User getUserDetailsFromToken(String extractedToken) throws Exception {
        if(jwtTokenUtil.isTokenExpired(extractedToken)){
            throw new Exception("Token is expired");
        }
        String email = jwtTokenUtil.extractEmail(extractedToken);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()){
            return user.get();
        }else {
            throw new Exception("User not found");
        }
    }

    public RoleRepository getRoleRepository() {
        return roleRepository;
    }
}
