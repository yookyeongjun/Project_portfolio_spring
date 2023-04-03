package restaurant.controller;

import java.util.HashMap;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Favorites;
import restaurant.model.PageRequest;
import restaurant.model.Restaurant;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/restaurant/*")
@RequiredArgsConstructor
public class RestaurantController {
	private final RestaurantService rService;
	private final UserService uService;
	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "") String keywords,
			@RequestParam(defaultValue = "") String order,
			PageRequest pageRequest,
			Model model,
			@AuthenticationPrincipal PrincipalDetails p) {
		if(p != null) model.addAttribute("fMap", rService.getFavoritesMap(p.getUser().getId()));
		else model.addAttribute("fMap",new HashMap<Long,Long>());
		
		Page<Restaurant> result;
	    result = rService.search(keywords,order,pageRequest.of());
		model.addAttribute("rPage",result);
		model.addAttribute("","");
		return "/restaurant/list";
	}
	@GetMapping("view/{rnum}")
	public String view(@PathVariable Long rnum,
						Model model, @AuthenticationPrincipal PrincipalDetails p) {
		model.addAttribute("restaurant", rService.view(rnum));
		if(p != null) model.addAttribute("findLike", uService.findLike(p.getUser().getId(), rnum));
		else model.addAttribute("findLike",new Favorites());
		model.addAttribute("reviewList", uService.findByReview(rnum));
		return "/restaurant/detail";
	}

}