package restaurant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import restaurant.model.Restaurant;

public interface RestaurantRepositoryCustom { //네이밍으로 QueryDsl이 인식하기에 중요함.
	public Page<Restaurant> searchWithCustom(String keyword,String order,Pageable pageable);
}
