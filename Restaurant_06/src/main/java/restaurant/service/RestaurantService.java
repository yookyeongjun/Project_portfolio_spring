package restaurant.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Menu;
import restaurant.model.Restaurant;
import restaurant.repository.FavoritesRepository;
import restaurant.repository.MenuRepository;
import restaurant.repository.RestaurantRepository;
import restaurant.repository.RestaurantRepositoryCustom;

@Service
@RequiredArgsConstructor
public class RestaurantService {
	private final RestaurantRepository restaurantRepository;
	private final RestaurantRepositoryCustom rRepositoryQuerydsl;
	private final MenuRepository menuRepository;
	private final FavoritesRepository fRepository;
	
	public HashMap<Long,Long> getFavoritesMap(Long uid){
		HashMap<Long,Long> hm = new HashMap<>();
		List<Long> li = fRepository.getMap(uid);
		for(Long rid : li) {
			hm.put(rid, uid);
		}
		return hm;
	}
	public Page<Restaurant> search(String keywords,String order,Pageable pageable){
		Page<Restaurant> list = rRepositoryQuerydsl.searchWithCustom(keywords,order,pageable);
		return list;
//		if(order.equals("readCnt")){
//			List<Restaurant> list = restaurantRepository.searchByNameOrderByReadCnt(keyword);
//			List<Restaurant> tempList = restaurantRepository.searchByMenuNameOrderByReadCnt(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			tempList = restaurantRepository.searchByDescriptionOrderByReadCnt(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			return list;
//		} else if(order.equals("recent")) {
//			List<Restaurant> list = restaurantRepository.searchByNameOrderByRegdate(keyword);
//			List<Restaurant> tempList = restaurantRepository.searchByMenuNameOrderByRegdate(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			tempList = restaurantRepository.searchByDescriptionOrderByRegdate(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			return list;
//		} else {
//			List<Restaurant> list = restaurantRepository.searchByName(keyword);
//			List<Restaurant> tempList = restaurantRepository.searchByMenuName(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			tempList = restaurantRepository.searchByDescription(keyword);
//			tempList.removeAll(list);
//			list.addAll(tempList);
//			return list;
//		}
	}
	@Transactional
	public void setEnabled(Long id,boolean enabled) {
		restaurantRepository.getById(id).setEnabled(enabled);
		
	}
	public List<Restaurant> popularList(){
		return restaurantRepository.popularList();
	}
	public List<Restaurant> recentList(){
		return restaurantRepository.recentList();
	}
	@Transactional
	public Restaurant view(Long rnum) {
		Restaurant loaded = restaurantRepository.getById(rnum);
		loaded.setReadCount(loaded.getReadCount() + 1);
		return loaded;
	}

	public List<Restaurant> findAll() {
		return restaurantRepository.findAllByEnabled(true);
	}
	public List<Restaurant> findByOid(Long oid){
		return restaurantRepository.findAllByOwner_id(oid);
	}
	@Transactional
	public Long register(Restaurant restaurant,PrincipalDetails p) {
		restaurant.setOwner(p.getUser());
		restaurantRepository.save(restaurant);
		return restaurant.getId();
	}

	@Transactional
	public void update(Restaurant restaurant, List<MultipartFile> files, HttpSession session) {
		Restaurant loaded = restaurantRepository.findById(restaurant.getId()).get();
		String uploadFolder;
		UUID uuid = UUID.randomUUID();
		MultipartFile f = files.get(0);
		if (!f.getOriginalFilename().equals("empty")) {
			uploadFolder = session.getServletContext().getRealPath("/") + "restaurantImg";
			String uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
			File saveFile = new File(uploadFolder, uploadFileName);
			try {
				f.transferTo(saveFile);
				restaurant.setThumImage("\\restaurantImg\\" + uploadFileName);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			if(loaded.getThumImage() == null)
				restaurant.setThumImage("/img/NoThumbnail.png");
			else
				restaurant.setThumImage(loaded.getThumImage());
		}
		uploadFolder = session.getServletContext().getRealPath("/") + "menuImg";
		for (int i = 1; i < files.size(); i++) {
			f = files.get(i);
			if (!f.getOriginalFilename().equals("empty")) {
				String uploadFileName = "";
				uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
				File saveFile = new File(uploadFolder, uploadFileName);
				try {
					f.transferTo(saveFile);
					restaurant.getMenuList().get(i - 1).setImg("\\menuImg\\" + uploadFileName);
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				Menu tempMenu = restaurant.getMenuList().get(i-1);
				for(Menu iMenu : loaded.getMenuList()) {
					if(tempMenu.getId() == iMenu.getId()) {
						tempMenu.setImg(iMenu.getImg());
						break;
					}
				}
				if(tempMenu.getImg() == null)
					tempMenu.setImg("/img/NoMenuImg.jpg");
			}
		}
		loaded.copy(restaurant);
		
		ArrayList<Long> lmlIds = new ArrayList<>();
		for(int i = 0;i<loaded.getMenuList().size();i++) { //loaded의 메뉴 아이디들을 리스트에 담음.
			lmlIds.add(loaded.getMenuList().get(i).getId());
		}
		ArrayList<Long> rmlIds = new ArrayList<>();
		for(int i = 0;i<restaurant.getMenuList().size();i++) { //restaurant의 메뉴 아이디들을 리스트에 담음.
			rmlIds.add(restaurant.getMenuList().get(i).getId());
		}
		lmlIds.removeAll(rmlIds); //loaded Ids에서 restaurant Ids 차집합.
		menuRepository.deleteAllById(lmlIds); //차집합 결과 삭제.
		
		menuRepository.saveAll(restaurant.getMenuList());
	}
	//가게 폐업
	public void rDelete(Long rid) {
		restaurantRepository.deleteById(rid);
	}
	public Long getCount() {
		return restaurantRepository.count();
	}
}
