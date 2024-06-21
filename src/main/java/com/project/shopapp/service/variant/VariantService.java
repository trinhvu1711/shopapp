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

        List<Option> options = List.of(option1, option2);
        String variantName = option1.getValue() + " / " + option2.getValue();

        return variantRepository.save(Variant.builder()
                .name(variantName)
                .price(variantDTO.getPrice())
                .availableForSale(variantDTO.isAvailableForSale())
                .options(options)
                .currency(variantDTO.getCurrency())
                .build());
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
    public List<Variant> updateProductVariant(long productId, List<Long> variants) throws Exception {
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

}
