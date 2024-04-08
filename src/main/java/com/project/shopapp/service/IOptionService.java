package com.project.shopapp.service;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.dtos.OptionDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Option;

import java.util.List;

public interface IOptionService {
    Option getOptionById(long id);
    Option createOption(OptionDTO optionDTO);
    List<Option> getAllOptions();
    Option updateOption(long optionId, OptionDTO optionDTO);
    void deleteOption(long id);
}
