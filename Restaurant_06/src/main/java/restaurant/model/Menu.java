package restaurant.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity
@Table(name = "menu")
public class Menu {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private int price;
	private String description;
	private String img;
	@ManyToOne
	private Restaurant restaurant;
	
	@PrePersist
    public void prePersist() {
        this.img = this.img == null ? "/img/NoMenuImg.jpg" : this.img;
    }
}
