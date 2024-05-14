package com.project.shopapp.service;

import com.project.shopapp.dtos.ListCartDTO;
import com.project.shopapp.models.ListCart;

import java.util.List;

public interface IListCartService {
    ListCart createListCart(ListCartDTO listCartDTO) throws Exception;
    ListCart getListCart(Long id);
    ListCart updateListCart(Long id, ListCartDTO listCartDTO) throws Exception;
    void deleteListCart(Long id);
    List<ListCart> findByUserId(Long userId);
}
