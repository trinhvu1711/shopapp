package com.project.shopapp.service.variant;

import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Variant;

import java.util.List;

public interface IVariantService {
    Variant getVariantById(long id) throws DataNotFoundException;
    Variant createVariant(VariantDTO variantDTO) throws Exception;
    List<Variant> getAllVariants();
    Variant updateVariant(long variantId, VariantDTO variantDTO) throws Exception;
    void deleteVariant(long id);
}