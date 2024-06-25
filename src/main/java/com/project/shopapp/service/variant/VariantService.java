package com.project.shopapp.service.variant;

import com.project.shopapp.dtos.VariantAdminDTO;
import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Option;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.Variant;
import com.project.shopapp.repositories.OptionRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.VariantRepository;
import com.project.shopapp.responses.OptionResponse;
import com.project.shopapp.responses.VariantAdminResponse;
import com.project.shopapp.responses.VariantResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class VariantService implements IVariantService {
    private final VariantRepository variantRepository;
    private final OptionRepository optionRepository;
    private final ProductRepository productRepository;

    @Override
    public Variant createVariant(VariantAdminDTO variantDTO) throws Exception {
        Option option1 = optionRepository.findById(variantDTO.getOptions().get(0))
                .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptions().get(0)));
        Option option2 = optionRepository.findById(variantDTO.getOptions().get(1))
                .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptions().get(1)));

        String variantName = option1.getValue() + " / " + option2.getValue();

        return variantRepository.save(Variant.builder()
                .name(variantName)
                .price(variantDTO.getPrice())
                .availableForSale(variantDTO.isAvailableForSale())
                .currency(variantDTO.getCurrency())
                .discount(variantDTO.getDiscount())
                .build());
    }

    public Variant updateAdminVariant(long id, VariantAdminDTO variantDTO) throws Exception {
        Option option1 = optionRepository.findById(variantDTO.getOptions().get(0))
                .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptions().get(0)));
        Option option2 = optionRepository.findById(variantDTO.getOptions().get(1))
                .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptions().get(1)));

        List<Option> options = List.of(option1, option2);
        String variantName = option1.getValue() + " / " + option2.getValue();
        Variant existingVariant = variantRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find variant with id " + id));

        existingVariant.setName(variantName);
        existingVariant.setPrice(variantDTO.getPrice());
        existingVariant.setAvailableForSale(variantDTO.isAvailableForSale());
        existingVariant.setOptions(options);
        existingVariant.setCurrency(variantDTO.getCurrency());
        existingVariant.setDiscount(variantDTO.getDiscount());
        try {
            existingVariant = variantRepository.save(existingVariant);
        } catch (Exception e) {
            throw new Exception("Cannot update variant");
        }
        return existingVariant;
    }

    @Override
    public Variant getVariantById(long id) throws DataNotFoundException {
        Optional<Variant> optionalVariant = variantRepository.getVariant(id);
        if (optionalVariant.isPresent()) {
            return optionalVariant.get();
        }
        throw new DataNotFoundException("Cannot find variant with id =" + id);
    }

//    @Override
//    public List<Variant> getVariantByProductId(long productId) throws DataNotFoundException {
//        Product existingProduct = productRepository.findById(productId)
//                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + productId));
//
//        return variantRepository.getVariantsByProduct(existingProduct);
//
//    }

    @Override
    public List<Variant> getAllVariants() {
        return variantRepository.findAll();
    }


    @Override
    public Variant updateVariant(long variantId, VariantDTO variantDTO) throws Exception {
        Variant existingVariant = getVariantById(variantId);
        if (existingVariant != null) {
//            Option option = optionRepository.findById(variantDTO.getOptionId())
//                    .orElseThrow(() -> new DataNotFoundException("Cannot find option with id " + variantDTO.getOptionId()));
            Product existingProduct = productRepository.findById(variantDTO.getProductId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + variantDTO.getProductId()));
            existingVariant.setName(variantDTO.getName());
            existingVariant.setPrice(variantDTO.getPrice());
            existingVariant.setAvailableForSale(variantDTO.isAvailableForSale());
//            existingVariant.setProduct(existingProduct);
//            existingVariant.setOption(option);
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

    @Override
    public List<Variant> createProductVariant(long productId, List<Long> variants) throws Exception {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + productId));
        List<Variant> variantList = new ArrayList<>();
        for (Long variantId : variants) {
            Variant existingVariant = variantRepository.findById(variantId)
                    .orElseThrow(() -> new DataNotFoundException("Cannot find variant with id " + variantId));

            variantList.add(existingVariant);
        }
        existingProduct.setVariants(variantList);
        productRepository.save(existingProduct);

        return variantList;
    }

    @Override
    public List<Variant> updateProductVariant(long productId, List<Long> variants) throws Exception {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + productId));
        if (existingProduct.getVariants() == null) {
            existingProduct.setVariants(new ArrayList<>());
        }

        existingProduct.getVariants().clear();

        productRepository.save(existingProduct);

        for (Long variantId : variants) {
            Variant existingVariant = variantRepository.findById(variantId)
                    .orElseThrow(() -> new DataNotFoundException("Cannot find variant with id " + variantId));

            existingProduct.getVariants().add(existingVariant);
        }

        productRepository.save(existingProduct);

        return existingProduct.getVariants();
    }

    @Override
    public List<VariantResponse> getAllVariantsAdmin() throws Exception {
        List<Variant> variants = variantRepository.findAll();
        if (variants.isEmpty()) {
            throw new DataNotFoundException("No variant found");
        }
        List<VariantResponse> responses = variants.stream()
                .map(variant -> VariantResponse.builder()
                        .id(variant.getId())
                        .name(variant.getName())
                        .build())
                .toList();
        return responses;
    }

    @Override
    public List<VariantAdminResponse> getListVariants() throws Exception {
        List<Variant> variants = variantRepository.findAll();
        if (variants.isEmpty()) {
            throw new DataNotFoundException("No variant found");
        }
        List<VariantAdminResponse> responses = variants.stream()
                .map(variant -> VariantAdminResponse.builder()
                        .id(variant.getId())
                        .name(variant.getName())
                        .price(variant.getPrice())
                        .availableForSale(variant.isAvailableForSale())
                        .currency(variant.getCurrency())
                        .discount(variant.getDiscount())
                        .options(variant.getOptions().stream()
                                .map(option -> OptionResponse.builder()
                                        .id(option.getId())
                                        .name(option.getName())
                                        .value(option.getValue())
                                        .build())
                                .toList())
                        .build())
                .toList();
        return responses;
    }

    @Override
    public VariantAdminResponse getVariantAdminById(long id) throws DataNotFoundException {
        Variant variant = variantRepository.findById(id).orElseThrow(() -> new DataNotFoundException("Cannot find variant with id " + id));
        return VariantAdminResponse.builder()
                .id(variant.getId())
                .name(variant.getName())
                .price(variant.getPrice())
                .availableForSale(variant.isAvailableForSale())
                .currency(variant.getCurrency())
                .discount(variant.getDiscount())
                .options(variant.getOptions().stream()
                        .map(option -> OptionResponse.builder()
                                .id(option.getId())
                                .name(option.getName())
                                .value(option.getValue())
                                .build())
                        .toList())
                .build();

    }

}
