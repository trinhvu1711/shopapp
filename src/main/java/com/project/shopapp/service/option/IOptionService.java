package com.project.shopapp.service.option;

import com.project.shopapp.dtos.OptionDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Option;

import java.util.List;

public interface IOptionService {
    Option getOptionById(long id);
    Option createOption(OptionDTO optionDTO) throws DataNotFoundException;
    List<Option> getAllOptions();
    Option updateOption(long optionId, OptionDTO optionDTO) throws DataNotFoundException;
    void deleteOption(long id);
}
