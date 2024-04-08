package com.project.shopapp.service;

import com.project.shopapp.dtos.OptionDTO;
import com.project.shopapp.models.Option;
import com.project.shopapp.repositories.CategoryRepository;
import com.project.shopapp.repositories.OptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionService implements IOptionService {
    private final OptionRepository optionRepository;

    @Override
    public Option createOption(OptionDTO optionDTO) {
        Option option = Option.builder()
                .name(optionDTO.getName())
                .value(optionDTO.getValue())
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
    public Option updateOption(long optionId, OptionDTO optionDTO) {
        Option existingOption = getOptionById(optionId);
        if(existingOption != null ){
            existingOption.setName(optionDTO.getName());
            existingOption.setValue(optionDTO.getValue());
            return optionRepository.save(existingOption);
        }
       return null;
    }

    @Override
    public void deleteOption(long id) {
        optionRepository.deleteById(id);
    }
}
