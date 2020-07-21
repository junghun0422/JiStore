package com.ji.store.dto;

public class UserDto 
{
	private String userId;
	
	private String userNm;
	
	private String pwd;
	
	private int auth_level;	// 1. 관리자, 2. 판매자, 3. 고객

	public UserDto() { }

	public UserDto(String userId, String userNm, String pwd, int auth_level) 
	{
		this.userId = userId;
		this.userNm = userNm;
		this.pwd = pwd;
		this.auth_level = auth_level;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getAuth_level() {
		return auth_level;
	}

	public void setAuth_level(int auth_level) {
		this.auth_level = auth_level;
	}
}
