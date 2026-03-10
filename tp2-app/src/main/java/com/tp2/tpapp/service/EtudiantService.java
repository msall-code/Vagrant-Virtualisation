package com.tp2.tpapp.service;

import com.tp2.tpapp.entity.Etudiant;
import com.tp2.tpapp.repository.EtudiantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EtudiantService {

    private final EtudiantRepository repository;

    public List<Etudiant> findAll() {
        return repository.findAllByOrderByIdDesc();
    }

    public Etudiant findById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Étudiant introuvable : id=" + id));
    }

    public void save(Etudiant etudiant) {
        repository.save(etudiant);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }

    public boolean emailDejaUtilise(String email) {
        return repository.existsByEmail(email);
    }

    public boolean emailDejaUtiliseParAutre(String email, Long id) {
        return repository.existsByEmailAndIdNot(email, id);
    }

    public long compter() {
        return repository.count();
    }
}