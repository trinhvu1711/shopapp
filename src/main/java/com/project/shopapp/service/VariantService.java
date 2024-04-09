package com.project.shopapp.service;

import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Option;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.Variant;
import com.project.shopapp.repositories.OptionRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.VariantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class VariantService implements IVariantService {
    private final VariantRepository variantRepository;
    private final OptionRepository optionRepository;
    private final ProductRepository productRepository;
    @Override
    public Variant createVariant(VariantDTO variantDTO) throws Exception {
        Option option = optionRepository.findById(variantDTO.getOptionId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptionId()));
        Product existingProduct = productRepository.findById(variantDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + variantDTO.getProductId()));
        Variant variant = Variant.builder()
                .name(variantDTO.getName())
                .price(variantDTO.getPrice())
                .availableForSale(variantDTO.isAvailableForSale())
                .option(option)
                .product(existingProduct)
                .currency(variantDTO.getCurrency())
                .build();
        return variantRepository.save(variant);
    }

    @Override
    public Variant getVariantById(long id) {
        return variantRepository.findById(id).orElseThrow(() -> new RuntimeException("Variant not found"));
    }

//    @Override
    public List<Variant> getVariantByProductId(long productId) throws DataNotFoundException {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + productId));

        return variantRepository.getVariantsByProduct(existingProduct);

    }

    @Override
    public List<Variant> getAllVariants() {
        return variantRepository.findAll();
    }

    @Override
    public Variant updateVariant(long variantId, VariantDTO variantDTO) throws Exception {
        Variant existingVariant = getVariantById(variantId);
        if (existingVariant != null) {
            Option option = optionRepository.findById(variantDTO.getOptionId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptionId()));
            Product existingProduct = productRepository.findById(variantDTO.getProductId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + variantDTO.getProductId()));
            existingVariant.setName(variantDTO.getName());
            existingVariant.setPrice(variantDTO.getPrice());
            existingVariant.setAvailableForSale(variantDTO.isAvailableForSale());
            existingVariant.setProduct(existingProduct);
            existingVariant.setOption(option);
            existingVariant.setCurrency(variantDTO.getCurrency());
            return variantRepository.save(existingVariant);
        }
        return null;


    }

    @Override
    public void deleteVariant(long id) {
        Optional<Variant> optionalVariant = variantRepository.findById(id);
        optionalVariant.ifPresent(variantRepository::delete);
    }
}
