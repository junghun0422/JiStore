package com.ji.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ji.store.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, String> { }
