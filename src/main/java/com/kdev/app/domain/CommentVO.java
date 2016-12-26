package com.kdev.app.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "comments")
@Getter
@Setter
public class CommentVO {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	@Column(columnDefinition = "TEXT")
	private String description;
	private String tags;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="created", insertable=false, updatable=false, columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private Date created;
	
	@ManyToOne
	@PrimaryKeyJoinColumn(name = "userid", referencedColumnName = "id")
    private UserVO user;
	
	@Column(name = "board_id")
	private int board_id;
}
