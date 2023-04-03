package restaurant.model;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity
@Table(name = "restaurant")
public class Restaurant {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id; //기본키
	private String name; //식당명
	private String address; //주소
	private String tel; //전화번호
	private String openTime; //여는 시각
	private String closeTime; //닫는 시각
	private String rsvTime; //예약할 수 있는 마지막 시각
	@Column(length = 1000)
	private String description; //설명
	@Transient
	private MultipartFile thumImageFile;
	private String thumImage; //썸네일 이미지 주소
	private String url; //사이트 홈페이지
	private String businessNum; //사업자번호
	private Long readCount;
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy/MM/dd", timezone = "Asia/Seoul")
	private Date regdate;
	
	private boolean enabled;
	
	@OneToMany(mappedBy = "restaurant",cascade = CascadeType.REMOVE)
	private List<Menu> menuList;
	
	@OneToMany(mappedBy = "restaurant",cascade = CascadeType.REMOVE)
	private List<Review> reviewList;
	
	@OneToMany(mappedBy = "restaurant",cascade = CascadeType.REMOVE)
	private List<Reservations> reservations;
	
	@OneToMany(mappedBy = "restaurant",cascade = CascadeType.REMOVE)
	private List<Favorites> favorites;
	
	@ManyToOne
	@JoinColumn(name = "owner_id")
	private User owner;
	
	@PrePersist
    public void prePersist() {
        this.enabled = false;
        this.readCount = 0L;
        this.thumImage = "/img/NoThumbnail.png";
    }
	
	public void copy(Restaurant restaurant) {
		this.setName(restaurant.getName());
		this.setAddress(restaurant.getAddress());
		this.setDescription(restaurant.getDescription());
		this.setEnabled(restaurant.isEnabled());
		this.setOpenTime(restaurant.getOpenTime());
		this.setCloseTime(restaurant.getCloseTime());
		this.setRsvTime(restaurant.getRsvTime());
		this.setTel(restaurant.getTel());
		this.setUrl(restaurant.getUrl());
		this.thumImage = restaurant.getThumImage();
	}
}
