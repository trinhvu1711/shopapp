package com.project.shopapp.configuration;

import com.project.shopapp.filters.JwtTokenFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.CorsConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import java.util.Arrays;
import java.util.List;

import static org.springframework.http.HttpMethod.*;

@Configuration
//@EnableMethodSecurity
@EnableWebSecurity(debug = true)
@EnableGlobalMethodSecurity(prePostEnabled = true)
@EnableWebMvc
@RequiredArgsConstructor
public class WebSecurityConfig {
    private final JwtTokenFilter jwtTokenFilter;
    @Value("${api.prefix}")
    private String apiPrefix;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(
                        httpSecuritySessionManagementConfigurer ->
                                httpSecuritySessionManagementConfigurer.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter.class)
                .authorizeHttpRequests((request) -> {
                    request
                            .requestMatchers(
                                    String.format("%s/users/register", apiPrefix),
                                    String.format("%s/users/login", apiPrefix),
                                    String.format("%s/users/getAll", apiPrefix)
                            )
                            .permitAll()
                            .requestMatchers(PUT, String.format("%s/users/update-user/**", apiPrefix)).hasAuthority("ROLE_ADMIN")
                            .requestMatchers(DELETE, String.format("%s/users/delete-user/**", apiPrefix)).hasAuthority("ROLE_ADMIN")
                            .requestMatchers(POST, String.format("%s/users/create-user", apiPrefix)).hasAuthority("ROLE_ADMIN")
                            .requestMatchers(PUT,
                                             String.format("%s/users/details/**", apiPrefix)).permitAll()
//                            Order
                            .requestMatchers(GET,
                                             String.format("%s/orders/**", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/orders", apiPrefix)).permitAll()
                            .requestMatchers(GET,
                                             String.format("%s/orders/tracking/**", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/orders/cancel", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/orders/details", apiPrefix)).permitAll()
                            .requestMatchers(PUT,
                                             String.format("%s/orders/**", apiPrefix)).hasAuthority("ROLE_ADMIN")
//                            Product
                            .requestMatchers(GET,
                                             String.format("%s/products", apiPrefix)).permitAll()
                            .requestMatchers(GET,
                                             String.format("%s/products/**", apiPrefix)).permitAll()
                            .requestMatchers(GET,
                                             String.format("%s/categories", apiPrefix)).permitAll()

//                            List cart
                            .requestMatchers(GET,
                                             String.format("%s/list_carts/**", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/list_carts/**", apiPrefix)).permitAll()
//                            Carts
                            .requestMatchers(GET,
                                             String.format("%s/carts/**", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/carts/**", apiPrefix)).permitAll()
                            .requestMatchers(DELETE,
                                             String.format("%s/carts/**", apiPrefix)).permitAll()
                            .requestMatchers(PUT,
                                             String.format("%s/carts/update_quantity/**", apiPrefix)).permitAll()

//                            Order details
                            .requestMatchers(GET,
                                             String.format("%s/order_details/**", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/order_details", apiPrefix)).permitAll()

//                          Wish list
                            .requestMatchers(POST,
                                             String.format("%s/wishlist", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/wishlist/details", apiPrefix)).permitAll()
                            .requestMatchers(DELETE,
                                             String.format("%s/wishlist/**", apiPrefix)).permitAll()
//                          Coupon
                            .requestMatchers(GET,
                                             String.format("%s/coupons/calculate", apiPrefix)).permitAll()
                            .requestMatchers(GET,
                                             String.format("%s/coupons", apiPrefix)).permitAll()

//                          Comment
                            .requestMatchers(GET,
                                             String.format("%s/comments", apiPrefix)).permitAll()
                            .requestMatchers(POST,
                                             String.format("%s/comments/**", apiPrefix)).permitAll()
                            .anyRequest().authenticated();



//                            .anyRequest().permitAll();
                })
                .csrf(AbstractHttpConfigurer::disable);
        http.cors(new Customizer<CorsConfigurer<HttpSecurity>>() {
            @Override
            public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {
                CorsConfiguration configuration = new CorsConfiguration();
                configuration.setAllowedOrigins(List.of("*"));
                configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
                configuration.setAllowedHeaders(Arrays.asList("authorization", "content-type", "x-auth-token"));
                configuration.setExposedHeaders(List.of("x-auth-token"));
                UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
                source.registerCorsConfiguration("/**", configuration);
                httpSecurityCorsConfigurer.configurationSource(source);
            }
        });
        return http.build();
    }
}
