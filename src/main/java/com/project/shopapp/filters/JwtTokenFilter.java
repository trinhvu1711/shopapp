package com.project.shopapp.filters;

import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.models.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Component
@RequiredArgsConstructor
public class JwtTokenFilter extends OncePerRequestFilter {

    @Value("${api.prefix}")
    private String apiPrefix;

    private final UserDetailsService userDetailsService;
    private final JwtTokenUtil jwtTokenUtil;

    private static final List<String> BYPASS_PATHS = Arrays.asList(
            "/products", "/products/**",
            "/categories",
            "/users/register", "/users/login",
            "/orders", "/orders/**", "/orders/details",
            "/orders/tracking/**",
            "/carts/update_quantity/**",
            "/order_details", "/order_details/**",
            "/list_carts", "/list_carts/**",
            "/carts", "/carts/**",  "/wishlist/**",
            "/products/search",
            "/users/getAll/**",
            "/variants/all",
            "/variants/get/**",
            "/categories/get/**",
            "/categories/get-all-categories",
            "/products/search",
            "/coupons/calculate", "/coupons",
            "/comments"

    );

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain)
            throws ServletException, IOException {
        try {
            if (isBypassPath(request)) {
                filterChain.doFilter(request, response);
                return;
            }

            final String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
                return;
            }

            final String token = authHeader.substring(7);
            final String email = jwtTokenUtil.extractEmail(token);

            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                User userDetails = (User) userDetailsService.loadUserByUsername(email);
                if (jwtTokenUtil.validateToken(token, userDetails)) {
                    UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                }
            }
            filterChain.doFilter(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
        }
    }

    private boolean isBypassPath(@NonNull HttpServletRequest request) {
        String requestPath = request.getServletPath().replaceFirst("/" + apiPrefix, "");
        if ("GET".equalsIgnoreCase(request.getMethod()) && requestPath.equals("/payment/vn-pay")) {
            return true;
        }
        if ("GET".equalsIgnoreCase(request.getMethod()) && requestPath.equals("/payment/vn-pay-callback")) {
            return true;
        }
        if ("POST".equalsIgnoreCase(request.getMethod()) && requestPath.equals("/orders/pay")) {
            return false;
        }
        if (!"GET".equalsIgnoreCase(request.getMethod()) && requestPath.equals("/comments")) {
            return false;
        }
        for (String path : BYPASS_PATHS) {
            if (path.endsWith("/**")) {
                String basePath = path.substring(0, path.length() - 3); // Remove "/**"
                if (requestPath.startsWith(basePath)) {
                    return true;
                }
            } else if (requestPath.equals(path)) {
                return true;
            }
        }

        return false;
    }
}
