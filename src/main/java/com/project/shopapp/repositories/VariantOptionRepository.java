package com.project.shopapp.repositories;

import com.project.shopapp.models.VariantOption;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VariantOptionRepository extends JpaRepository<VariantOption, Long> {
}
