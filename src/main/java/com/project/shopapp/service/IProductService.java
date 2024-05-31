package com.project.shopapp.service;

import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.responses.ProductAdminResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IProductService {
    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException;

    Product getProductById(Long id) throws DataNotFoundException;
//    Page<Product> getAllProducts(PageRequest pageRequest, String keyword, Long categoryId);

//    Page<Product> getAllProducts(PageRequest pageRequest, String keyword, Long categoryId);

    Page<Product> getAllProducts(String keyword,
                                 Long categoryId, PageRequest pageRequest);

    Product updateProduct(long id, ProductDTO productDTO) throws DataNotFoundException;

    void deleteProduct(long id);

    boolean existByName(String name);

    ProductImage createProductImage(long productId, ProductImageDTO productImageDTO) throws Exception;

    List<ProductAdminResponse> searchProducts(String keyword);

}
