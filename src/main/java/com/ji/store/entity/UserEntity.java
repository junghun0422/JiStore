package com.ji.store.entity;

import java.security.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor
@Setter @Getter
@Table( name = "user" )
public class UserEntity 
{
	@Id
	@Column( name = "user_id")
	private String user_id;
	
	@Column( name = "user_nm", nullable = false )
	private String user_nm;
	
	@Column( name = "password", nullable = false )
	private String password;
	
	@Column( name = "email", nullable = false )
	private String email;
	
	@Column( name = "auth_level", nullable = false )
	private int auth_level;	// ���ѵ�� :: (0: ������, 1: �Ǹ���, 2: ��)
	
	@Column( name = "phone_num", nullable = false )
	private String phone_num;
	
	@Column( name = "zip_code", nullable = false )
	private String zip_code;
	
	@Column( name = "address", nullable = false )
	private String address;
	
	@Column( name = "detail_address", nullable = false )
	private String detail_address;
	
	@Column( name = "regist_dt", nullable = false )
	private Timestamp regist_dt;
	
	@Builder 
	public UserEntity(String user_id, String user_nm, String password, String email, int auth_level, String phone_num,
			String zip_code, String address, String detail_address) {
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.password = password;
		this.email = email;
		this.auth_level = auth_level;
		this.phone_num = phone_num;
		this.zip_code = zip_code;
		this.address = address;
		this.detail_address = detail_address;
	}

	@Builder 
	public UserEntity(String user_id, String user_nm, String password, String email, int auth_level, String phone_num,
			String zip_code, String address, String detail_address, Timestamp regist_dt) {
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.password = password;
		this.email = email;
		this.auth_level = auth_level;
		this.phone_num = phone_num;
		this.zip_code = zip_code;
		this.address = address;
		this.detail_address = detail_address;
		this.regist_dt = regist_dt;
	}
}
