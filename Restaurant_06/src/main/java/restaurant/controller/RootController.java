package restaurant.controller;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import restaurant.model.User;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequiredArgsConstructor
public class RootController {
	//주입
	private final RestaurantService rService;
	private final UserService uService;
	private final AuthenticationManager authenticationManager;
	@GetMapping("test")
	public String test() {
		return "test";
	}
	
	@GetMapping("/")
	public String root(Model model) {
		model.addAttribute("popularList", rService.popularList());
		model.addAttribute("recentList", rService.recentList());
		model.addAttribute("rstrCount",rService.getCount());
		return "root";
	}
	
	//로그인
	@PostMapping("/user/login")
	@ResponseBody
    public String customLoginProcess(
            @RequestParam String username,
            @RequestParam String password
    ) {
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);
        try {
            // AuthenticationManager 에 token 을 넘기면 UserDetailsService 가 받아 처리하도록 한다.
            Authentication authentication = authenticationManager.authenticate(token);
            // 실제 SecurityContext 에 authentication 정보를 등록한다.
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            String status;
            if (e.getClass().equals(BadCredentialsException.class)) {
                status = "비밀번호가 잘못되었습니다.";
            } else if (e.getClass().equals(DisabledException.class)) {
                status = "사용할 수 없는 계정입니다.";
            } else if (e.getClass().equals(LockedException.class)) {
                status = "사용할 수 없는 계정입니다.";
            } else if (e.getClass().equals(InternalAuthenticationServiceException.class)){
                status = "내부 로그인 서비스 에러입니다.";
            } else {
            	status = "Unknown Error";
            }
            return status;
        }
        return "success";
    }
	
	//회원가입
	@GetMapping("/user/join")
	private String join() {
		return "/user/join";
	}
	@PostMapping("/user/join")
	@ResponseBody
	public String join(@RequestBody User user) {
		return uService.join(user);
	}
	@GetMapping("/admin/info")
	public String info() {
		return "/admin/info";
	}
}
