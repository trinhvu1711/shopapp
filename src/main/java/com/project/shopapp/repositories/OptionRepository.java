package com.project.shopapp.repositories;

import com.project.shopapp.models.Option;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OptionRepository extends JpaRepository<Option, Long> {
    List<Option> findByName(String name);
}
