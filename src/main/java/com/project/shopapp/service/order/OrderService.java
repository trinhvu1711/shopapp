package com.project.shopapp.service.order;

import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.OrderStatus;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.OrderRepository;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class OrderService implements IOrderService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final ModelMapper modelMapper;
    private final JwtTokenUtil jwtTokenUtil;

    @Override
    public Order createOrder(OrderDTO orderDTO) throws Exception {
        User user;
        try {
            user = userRepository
                    .findById(orderDTO.getUserId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + orderDTO.getUserId()));
        } catch (DataNotFoundException e) {
            // Fetch the guest user with id = 0 if the user is not found
            user = userRepository.findById(0L)
                    .orElseThrow(() -> new DataNotFoundException("Cannot find guest user with id: 0"));
        }

        modelMapper.typeMap(OrderDTO.class, Order.class)
                .addMappings(mapper -> mapper.skip(Order::setId));
        Order order = new Order();
        modelMapper.map(orderDTO, order);
        order.setUser(user);
        order.setOrderDate(new Date());
        order.setStatus(OrderStatus.PENDING);
        order.setPaid(false);
        LocalDate shippingDate = orderDTO.getShippingDate() == null ? LocalDate.now() : orderDTO.getShippingDate();
        if (shippingDate.isBefore(LocalDate.now())) {
            throw new DataNotFoundException("Date must be at least today");
        }
        order.setShippingDate(shippingDate);
        order.setActive(true);
        order.setTrackingNumber(orderDTO.getTrackingNumber());
        orderRepository.save(order);
        return order;
    }

    @Override
    public Order getOrder(Long id) {
        return orderRepository.getOrderWithOrderDetails(id).orElseThrow(null);
    }

    @Override
    public Order getOrderByTrackingNumber(String trackingNumber) {
        return orderRepository.getOrderWithOrderDetailsByTrackingNumber(trackingNumber).orElseThrow(null);
    }

    @Override
    public Order getOrderByUserId(Long userId) {
        return orderRepository.getOrderWithOrderDetailsUser(userId).orElseThrow(null);
    }

    @Override
    public Order updateOrder(Long id, OrderDTO orderDTO) throws Exception {
        Order existingOrder = orderRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find order with id: " + id));
        User existingUser = userRepository.findById(orderDTO.getUserId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + id));
        modelMapper.typeMap(OrderDTO.class, Order.class)
                .addMappings(mapper -> mapper.skip(Order::setId));
        modelMapper.map(orderDTO, existingOrder);
        existingOrder.setUser(existingUser);
        return orderRepository.save(existingOrder);
    }

    @Override
    public void deleteOrder(Long id) {
        Order order = orderRepository.findById(id).orElseThrow(null);
        if (order != null) {
            order.setActive(false);
            orderRepository.save(order);
        }
    }

    @Override
    public List<Order> findByUserId(Long userId) {
        return orderRepository.findByUserId(userId);
    }

    @Override
    public List<Order> getOrdersFromToken(String extractedToken, String status) throws Exception {
        if (jwtTokenUtil.isTokenExpired(extractedToken)) {
            throw new Exception("Token is expired");
        }
        String email = jwtTokenUtil.extractEmail(extractedToken);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            Optional<List<Order>> order = orderRepository.getOrderByUserAndStatus(user.get(), status);
            if (order.isPresent()) {
                return order.get();
            }
        } else {
            throw new Exception("Order not found");
        }
        return null;
    }

    @Override
    public Order updateOrderStatus(String extractedToken, String trackingNumber, String status) throws Exception {
        if (jwtTokenUtil.isTokenExpired(extractedToken)) {
            throw new Exception("Token is expired");
        }
        String email = jwtTokenUtil.extractEmail(extractedToken);
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            Order existingOrder = orderRepository.getByTrackingNumber(trackingNumber)
                    .orElseThrow(() -> new DataNotFoundException("Cannot find order with tracking id: " + trackingNumber));
            existingOrder.setStatus(OrderStatus.CANCELED);
            return orderRepository.save(existingOrder);
        } else {
            throw new Exception("Can't update status Order ");
        }
    }

    @Override
    public Order paidOrder(String trackingNumber) throws Exception {
        Order existingOrder = orderRepository.getByTrackingNumber(trackingNumber)
                .orElseThrow(() -> new DataNotFoundException("Cannot find order with tracking id: " + trackingNumber));
        existingOrder.setPaid(true);
        return orderRepository.save(existingOrder);

    }
}
