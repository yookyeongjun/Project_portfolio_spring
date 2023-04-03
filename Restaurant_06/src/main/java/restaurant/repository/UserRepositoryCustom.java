package restaurant.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import restaurant.model.User;

public interface UserRepositoryCustom {
	public Page<User> userPage(Pageable pageable,Long uid);
}
