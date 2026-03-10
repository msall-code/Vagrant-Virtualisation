package com.tp2.tpapp.repository;

import com.tp2.tpapp.entity.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {

    List<Etudiant> findAllByOrderByIdDesc();

    boolean existsByEmail(String email);

    boolean existsByEmailAndIdNot(String email, Long id);
}