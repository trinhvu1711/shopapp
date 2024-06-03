package com.project.shopapp.controller;

import com.project.shopapp.dtos.OptionDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Option;
import com.project.shopapp.service.option.OptionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//@Validated
@RestController
@RequestMapping("${api.prefix}/options")
@RequiredArgsConstructor
public class OptionController {
    private final OptionService optionService;
    @PostMapping("")
//      Data transfer Object
    public ResponseEntity<?> createOption(
            @Valid @RequestBody OptionDTO optionDTO,
            BindingResult result) throws DataNotFoundException {
        if (result.hasErrors()){
            List<String> errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errorMessages);
        }
        optionService.createOption(optionDTO);
        return ResponseEntity.ok("Create option successfully");
    }

    //    show all category
    @GetMapping("")//http://localhost:8088/api/v1/options?page=10&limit=10
    public ResponseEntity<List<Option>> getAllOption(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit) {
        List<Option> options = optionService.getAllOptions();
        return ResponseEntity.ok(options);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateOption(
            @PathVariable Long id,
            @Valid @RequestBody OptionDTO optionDTO
    ) throws DataNotFoundException {
        optionService.updateOption(id, optionDTO);
        return ResponseEntity.ok("Update option successfully" );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteOption(@PathVariable Long id) {
        optionService.deleteOption(id);
        return ResponseEntity.ok("Delete option with id " + id);
    }
}
