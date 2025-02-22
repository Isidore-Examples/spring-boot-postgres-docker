package za.co.bennett.isidore.hello_docker.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import za.co.bennett.isidore.hello_docker.entity.BasicEntity;

public interface HelloRepository extends JpaRepository<BasicEntity, Long> {
}