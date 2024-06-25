package com.project.shopapp.service.option;

import com.project.shopapp.dtos.OptionDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Option;
import com.project.shopapp.models.Variant;
import com.project.shopapp.repositories.OptionRepository;
import com.project.shopapp.repositories.VariantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionService implements IOptionService {
    private final OptionRepository optionRepository;
    private final VariantRepository variantRepository;

    @Override
    public Option createOption(OptionDTO optionDTO) throws DataNotFoundException {
        Variant variant = variantRepository.findById(optionDTO.getVariantId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + optionDTO.getVariantId()));
        Option option = Option.builder()
                .name(optionDTO.getName())
                .value(optionDTO.getValue())
//                .variant(variant)
                .build();
        return optionRepository.save(option);
    }

    @Override
    public Option getOptionById(long id) {
        return optionRepository.findById(id).orElseThrow(() -> new RuntimeException("Option not found"));
    }

    @Override
    public List<Option> getAllOptions() {
        return optionRepository.findAll();
    }

    @Override
    public Option updateOption(long optionId, OptionDTO optionDTO) throws DataNotFoundException {
        Option existingOption = getOptionById(optionId);
        if(existingOption != null ){
            Variant variant = variantRepository.findById(optionDTO.getVariantId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find product with id " + optionDTO.getVariantId()));
            existingOption.setName(optionDTO.getName());
            existingOption.setValue(optionDTO.getValue());
//            existingOption.setVariant(variant);
            return optionRepository.save(existingOption);
        }
       return null;
    }

    @Override
    public void deleteOption(long id) {
        optionRepository.deleteById(id);
    }

    @Override
    public List<Option> getConfiguration() throws DataNotFoundException {
        List<Option> options = optionRepository.findByName("Cấu hình");
        return options;
    }

    @Override
    public List<Option> getColor() throws DataNotFoundException {
        List<Option> options = optionRepository.findByName("Màu");
        return options;
    }
}
