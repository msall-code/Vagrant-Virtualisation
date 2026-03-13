package sn.tp3.backend.controller;

import sn.tp3.backend.entity.User;
import sn.tp3.backend.repository.UserRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "*")
public class UserController {
    private final UserRepository userRepository;
    public UserController(UserRepository userRepository) { this.userRepository = userRepository; }

    @GetMapping
    public List<User> all() { return userRepository.findAll(); }

    @PostMapping
    public User create(@RequestBody User user) { return userRepository.save(user); }

    @PutMapping("/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody User user){

        User existing = userRepository.findById(id).orElseThrow();

        existing.setName(user.getName());
        existing.setEmail(user.getEmail());

        return userRepository.save(existing);
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id){
        userRepository.deleteById(id);
    }
}