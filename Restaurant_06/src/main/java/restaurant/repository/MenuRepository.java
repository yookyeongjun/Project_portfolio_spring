package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Menu;

public interface MenuRepository extends JpaRepository<Menu, Long>{

}
