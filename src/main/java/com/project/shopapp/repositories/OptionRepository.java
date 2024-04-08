package com.project.shopapp.repositories;

import com.project.shopapp.models.Option;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OptionRepository extends JpaRepository<Option, Long> {
}
