package com.project.shopapp.service.variant;

import com.project.shopapp.dtos.VariantAdminDTO;
import com.project.shopapp.dtos.VariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Variant;
import com.project.shopapp.responses.VariantAdminResponse;
import com.project.shopapp.responses.VariantResponse;

import java.util.List;

public interface IVariantService {
    Variant getVariantById(long id) throws DataNotFoundException;
    Variant createVariant(VariantAdminDTO variantDTO) throws Exception;
    Variant updateAdminVariant(long variantId, VariantAdminDTO variantDTO) throws Exception;
    List<Variant> getAllVariants();
    Variant updateVariant(long variantId, VariantDTO variantDTO) throws Exception;
    void deleteVariant(long id);
    List<Variant> createProductVariant(long productId, List<Long> variants) throws Exception;
    List<Variant> updateProductVariant(long productId, List<Long> variants) throws Exception;
    List<VariantResponse> getAllVariantsAdmin() throws Exception;
    List<VariantAdminResponse> getListVariants() throws Exception;
    VariantAdminResponse getVariantAdminById(long id) throws DataNotFoundException;
}
