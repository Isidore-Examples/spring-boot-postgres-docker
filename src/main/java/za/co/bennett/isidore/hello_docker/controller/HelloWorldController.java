package za.co.bennett.isidore.hello_docker.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import za.co.bennett.isidore.hello_docker.entity.BasicEntity;
import za.co.bennett.isidore.hello_docker.repository.HelloRepository;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/hello")
public class HelloWorldController {

    private final HelloRepository helloRepository;

    @PostMapping("/")
    public ResponseEntity<BasicEntity> create(@RequestBody BasicEntity entity) {
        log.info("saving entity: {}", entity);
        return ResponseEntity.ok(helloRepository.save(entity));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BasicEntity> findById(@PathVariable Long id) {
        log.info("returning entity with id: {}", id);
        return ResponseEntity.of(helloRepository.findById(id));
    }

    @GetMapping("/")
    public ResponseEntity<List<BasicEntity>> findAll() {
        log.info("returning all entities");
        return ResponseEntity.ok(helloRepository.findAll());
    }
}
