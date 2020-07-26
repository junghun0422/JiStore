package com.ji.store.dto;

public class ReportsDto 
{
	private String name;
	private String zipCode;
	private String location;
	private String phone;
	private String address;
	private String latitude;
	private String longitude;
	private String summary;
	private String stroller;
	private String pet;
	private String creditCard;
	private String info;
	private String image;
	private int reportsId;
	   
	private int page_index;
   	private int total_cnt;
   
   	public ReportsDto() { }

	public ReportsDto(String name, String zipCode, String location, String phone, String address, String latitude,
			String longitude, String summary, String stroller, String pet, String creditCard, String info, String image,
			int reportsId, int page_index, int total_cnt) {
	
		this.name = name;
		this.zipCode = zipCode;
		this.location = location;
		this.phone = phone;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.summary = summary;
		this.stroller = stroller;
		this.pet = pet;
		this.creditCard = creditCard;
		this.info = info;
		this.image = image;
		this.reportsId = reportsId;
		this.page_index = page_index;
		this.total_cnt = total_cnt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getStroller() {
		return stroller;
	}

	public void setStroller(String stroller) {
		this.stroller = stroller;
	}

	public String getPet() {
		return pet;
	}

	public void setPet(String pet) {
		this.pet = pet;
	}

	public String getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(String creditCard) {
		this.creditCard = creditCard;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getReportsId() {
		return reportsId;
	}

	public void setReportsId(int reportsId) {
		this.reportsId = reportsId;
	}

	public int getPage_index() {
		return page_index;
	}

	public void setPage_index(int page_index) {
		this.page_index = page_index;
	}

	public int getTotal_cnt() {
		return total_cnt;
	}

	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}
	
	
   
   
	   
}
