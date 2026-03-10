package com.tp2.tpapp.controller;

import com.tp2.tpapp.entity.Etudiant;
import com.tp2.tpapp.service.EtudiantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/etudiants")
@RequiredArgsConstructor
public class EtudiantController {

    private final EtudiantService service;

    @GetMapping
    public String liste(Model model) {
        model.addAttribute("etudiants", service.findAll());
        model.addAttribute("etudiant", new Etudiant());
        model.addAttribute("total", service.compter());
        model.addAttribute("editMode", false);
        return "index";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute Etudiant etudiant,
                       BindingResult result,
                       Model model,
                       RedirectAttributes redirectAttrs) {

        if (!result.hasErrors() && service.emailDejaUtilise(etudiant.getEmail())) {
            result.rejectValue("email", "duplicate", "Cet email est déjà utilisé");
        }

        if (result.hasErrors()) {
            model.addAttribute("etudiants", service.findAll());
            model.addAttribute("total", service.compter());
            model.addAttribute("editMode", false);
            return "index";
        }

        service.save(etudiant);
        redirectAttrs.addFlashAttribute("success", "✅ Étudiant ajouté !");
        return "redirect:/etudiants";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        model.addAttribute("etudiant", service.findById(id));
        model.addAttribute("etudiants", service.findAll());
        model.addAttribute("total", service.compter());
        model.addAttribute("editMode", true);
        return "index";
    }

    @PostMapping("/update/{id}")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute Etudiant etudiant,
                         BindingResult result,
                         Model model,
                         RedirectAttributes redirectAttrs) {

        if (!result.hasErrors() && service.emailDejaUtiliseParAutre(etudiant.getEmail(), id)) {
            result.rejectValue("email", "duplicate", "Email déjà utilisé par un autre étudiant");
        }

        if (result.hasErrors()) {
            model.addAttribute("etudiants", service.findAll());
            model.addAttribute("total", service.compter());
            model.addAttribute("editMode", true);
            return "index";
        }

        etudiant.setId(id);
        service.save(etudiant);
        redirectAttrs.addFlashAttribute("success", "✅ Étudiant modifié !");
        return "redirect:/etudiants";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        service.delete(id);
        redirectAttrs.addFlashAttribute("success", "🗑 Étudiant supprimé.");
        return "redirect:/etudiants";
    }
}