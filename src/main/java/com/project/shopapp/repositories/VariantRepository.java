package com.project.shopapp.repositories;

import com.project.shopapp.models.Option;
import com.project.shopapp.models.Variant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VariantRepository extends JpaRepository<Variant, Long> {
}
