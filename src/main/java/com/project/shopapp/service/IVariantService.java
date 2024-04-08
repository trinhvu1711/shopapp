package com.project.shopapp.service;

import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.models.Variant;

import java.util.List;

public interface IVariantService {
    Variant getVariantById(long id);
    Variant createVariant(VariantDTO variantDTO) throws Exception;
    List<Variant> getAllVariants();
    Variant updateVariant(long variantId, VariantDTO variantDTO) throws Exception;
    void deleteVariant(long id);
}
