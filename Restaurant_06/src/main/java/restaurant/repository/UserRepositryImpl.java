package restaurant.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import restaurant.model.QUser;
import restaurant.model.Restaurant;
import restaurant.model.User;

@Repository
@RequiredArgsConstructor
public class UserRepositryImpl implements UserRepositoryCustom{
	private final JPAQueryFactory queryFactory;
	
	@Override
	public Page<User> userPage(Pageable pageable,Long uid) {
		BooleanBuilder builder = new BooleanBuilder();
		QUser user = QUser.user;
		QueryResults<User> results = 
				queryFactory.selectDistinct(user)
							.from(user)
							.offset(pageable.getOffset())
							.limit(pageable.getPageSize())
							.fetchResults();
		return new PageImpl<User>(results.getResults(),pageable,results.getTotal());
	}

}
