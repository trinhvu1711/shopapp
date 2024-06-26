package com.project.shopapp.service.user;

import com.project.shopapp.ShopAppApplication;
import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.dtos.*;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import com.project.shopapp.models.Variant;
import com.project.shopapp.repositories.RoleRepository;
import com.project.shopapp.repositories.UserRepository;
import com.project.shopapp.responses.LoginResponse;
import com.project.shopapp.responses.UserAdminResponse;
import com.project.shopapp.responses.UserResponse;
import com.project.shopapp.service.order.OrderService;
import com.project.shopapp.service.variant.VariantService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenUtil jwtTokenUtil;
    private final AuthenticationManager authenticationManager;

    @Override
    public User createUser(UserDTO userDTO) throws DataNotFoundException {
        String email = userDTO.getEmail();
        if (userRepository.existsByEmail(email)) {
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
        Role role = roleRepository.findById(userDTO.getRoleId()).orElseThrow(() -> new DataNotFoundException("Role not found"));
        newUser.setRole(role);
        if (userDTO.getFacebookAccountId() == 0 && userDTO.getGoogleAccountId() == 0) {
            String password = userDTO.getPassword();
            String encodedPassword = passwordEncoder.encode(password);
            newUser.setPassword(encodedPassword);
        }
        return userRepository.save(newUser);
    }

    @Override
    public LoginResponse login(String email, String password) throws Exception {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isEmpty()) {
            throw new DataNotFoundException("Invalid email / password");
        }
        User existingUser = optionalUser.get();
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                email, password, existingUser.getAuthorities()
        );

        if (existingUser.getFacebookAccountId() == 0
                && existingUser.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(password, existingUser.getPassword())) {
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
                .image(existingUser.getImage())
                .build();
        return LoginResponse.builder()
                .accessToken(jwtToken)
                .userResponse(userResponse)
                .build();
    }

    @Override
    public User getUserDetailsFromToken(String extractedToken) throws Exception {
        if (jwtTokenUtil.isTokenExpired(extractedToken)) {
            throw new Exception("Token is expired");
        }
        String email = jwtTokenUtil.extractEmail(extractedToken);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            return user.get();
        } else {
            throw new Exception("User not found");
        }
    }

    public List<UserAdminResponse> getAllUsers() {
        List<User> users = userRepository.findAll();
        List<UserAdminResponse> userResponses = users.stream().map(user -> {
            return UserAdminResponse.builder()
                    .id(user.getId())
                    .fullName(user.getFullName() == null ? "N/A" : user.getFullName())
                    .phoneNumber(user.getPhoneNumber() == null ? "N/A" : user.getPhoneNumber())
                    .role(user.getRole() == null ? "GUEST" : user.getRole().getName())
                    .isActive(user.isActive() ? "Active" : "Inactive")
                    .build();
        }).collect(Collectors.toList());
        return userResponses;
    }

    @Override
    public User updateUserAdmin(long id, UserUpdateDTO userDTO) throws DataNotFoundException {
        User existingUser = userRepository.findById(id).orElseThrow(() -> new DataNotFoundException("User not found"));

        if (userDTO.getFullName() != null) {
            existingUser.setFullName(userDTO.getFullName());
        }
        if (userDTO.getPhoneNumber() != null) {
            existingUser.setPhoneNumber(userDTO.getPhoneNumber());
        }
        if (userDTO.getAddress() != null) {
            existingUser.setAddress(userDTO.getAddress());
        }
        if (userDTO.getDateOfBirth() != null) {
            existingUser.setDateOfBirth(userDTO.getDateOfBirth());
        }
        if (userDTO.getImage() != null) {
            existingUser.setImage(userDTO.getImage());
        }
        if (userDTO.getRoleId() > 0) {
            Role role = roleRepository.findById(userDTO.getRoleId()).orElseThrow(() -> new DataNotFoundException("Role not found"));
            existingUser.setRole(role);
        }

        return userRepository.save(existingUser);
    }

    @Override
    public boolean deleteUser(long id) throws DataNotFoundException {
        User existingUser = userRepository.findById(id).orElseThrow(() -> new DataNotFoundException("User not found"));
        existingUser.getComments().clear();
        userRepository.save(existingUser);
        userRepository.deleteById(existingUser.getId());
        return !userRepository.existsById(id);
    }

    @Transactional
    @Override
    public User updateUser(Long userId, UpdateUserDTO userDTO) throws Exception {
        User existingUser = userRepository.findById(userId).
                orElseThrow(() -> new DataNotFoundException("User not found"));
        String newEmail = userDTO.getEmail();
        if (!existingUser.getEmail().equals(newEmail) &&
                userRepository.existsByEmail(newEmail)
        ) {

            throw new Exception("Email already exist");
        }
        if (userDTO.getFullName() != null) {
            existingUser.setFullName(userDTO.getFullName());
        }
        if (userDTO.getAddress() != null) {
            existingUser.setAddress(userDTO.getAddress());
        }
        if (userDTO.getDateOfBirth() != null) {
            existingUser.setDateOfBirth(userDTO.getDateOfBirth());
        }
        if (userDTO.getFacebookAccountId() > 0) {
            existingUser.setFacebookAccountId(userDTO.getFacebookAccountId());
        }
        if (userDTO.getGoogleAccountId() > 0) {
            existingUser.setGoogleAccountId(userDTO.getGoogleAccountId());
        }

        // Update the password if it is provided in the DTO
        if (userDTO.getPassword() != null
                && !userDTO.getPassword().isEmpty()) {
            if (!userDTO.getPassword().equals(userDTO.getRetypePassword())) {
                throw new DataNotFoundException("Password and retype password not the same");
            }
            String newPassword = userDTO.getPassword();
            String encodedPassword = passwordEncoder.encode(newPassword);
            existingUser.setPassword(encodedPassword);
        }
        // Save the updated user
        return userRepository.save(existingUser);
    }

    @Override
    public List<Role> getAllRole() throws DataNotFoundException {
        List<Role> roles = roleRepository.findAll();
        if (roles.isEmpty()) {
            throw new DataNotFoundException("No role found");
        }
        roles.removeIf(r -> r.getId() == 0);
        return roles;
    }

    @Override
    public User getUserById(Long userId) throws DataNotFoundException {
        User user= userRepository.findById(userId).orElseThrow(() -> new DataNotFoundException("User not found"));
        return user;
    }

    public RoleRepository getRoleRepository() {
        return roleRepository;
    }

//    public static void main(String[] args) {
//        ApplicationContext context = SpringApplication.run(ShopAppApplication.class, args);
//        VariantService orderService = context.getBean(VariantService.class);
//try {
//    List<Long> options= new ArrayList<>();
//    options.add(12L);
//    options.add(8L);
//            orderService.updateAdminVariant(73.new VariantAdminDTO(options,false,35000000,0.23,"VND"));
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
