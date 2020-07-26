package com.ji.store.utils;


public class PagingBean 
{
	/**
	 * 총 데이터(게시물)의 개수
	 */
	private int totalItems;//총 게시물 수 
	/**
	 * 현재 페이지
	 */
	private int page;//
	/**
	 * 한 페이지에 보여질 데이터(게시물)개수
	 */
	private int itemsPerPage = 6;
	/**
	 * Page Group 내 Page 수.  페이지 그룹에 들어갈 페이지 개수
	 */
	private int pagesPerPagegroup = 6;
	
	/**
	 * 총 데이터 개수, 현재 페이지를 받아 member variable에 할당
	 * @param totalItems 총 데이터 수
	 * @param page 보려는 페이지.
	 */
	public PagingBean(int totalItems, int page) {//
		super();
		this.totalItems = totalItems;
		this.page = page;
	}
	/**
	 * 현재 페이지 return
	 * @return
	 */
	public int getPage(){
		return page;
	}
	
	/**
	 * 총 페이지 수를 return한다.<br>
	 * 1. 전체 데이터(게시물) % 한 페이지에 보여줄 데이터 개수 => 0 이면 둘을 /  값이 총 페이지 수<br>
	 * 2. 전체 데이터(게시물) % 한 페이지에 보여줄 데이터 개수 => 0보다 크면 둘을 /  값에 +1을 한 값이 총 페이지 수
	 * @return
	 */
	private int getTotalPage(){
		int totalPage = 0;
		if(totalItems%itemsPerPage != 0){
			totalPage = totalItems/itemsPerPage +1;
		}else{
			totalPage = totalItems/itemsPerPage;
		}		
		return totalPage;
	}
	/**
	 * 총 페이지 그룹의 수를 return한다.<br>
	 * 1. 총 페이지수 %  Page Group 내 Page 수.  => 0 이면 둘을 /  값이 총 페이지 수<br>
	 * 2. 총 페이지수 %  Page Group 내 Page 수.  => 0보다 크면 둘을 /  값에 +1을 한 값이 총 페이지 수
	 * @return
	 */
	private int getTotalPageGroup(){
		
		int totalPageGoup = 0;
		int totalPage = getTotalPage();//전체 페이지 수
		if(totalPage%pagesPerPagegroup != 0){
			totalPageGoup = totalPage/pagesPerPagegroup + 1;
		}else{
			totalPageGoup = totalPage/pagesPerPagegroup;
		}		
		return totalPageGoup;
	}
	/**
	 * 현재 페이지가 속한 페이지 그룹 번호(몇 번째 페이지 그룹인지) 을 return 하는 메소드
	 * 1. 현재 페이지 %  Page Group 내 Page 수 => 0 이면 둘을 / 값이 현재 페이지 그룹. 
	 * 2. 현재 페이지 %  Page Group 내 Page 수 => 0 크면 둘을 /  값에 +1을 한 값이 현재 페이지 그룹
	 * @return
	 */
	private int getCurrentPageGroup(){
		
		int currentPageGroup = 0;
		if(page%pagesPerPagegroup != 0){
			currentPageGroup = page / pagesPerPagegroup +1;
		}else{
			currentPageGroup = page / pagesPerPagegroup;
		}
		return currentPageGroup;
	}
	/**
	 * 현재 페이지가 속한 페이지 그룹의 시작 페이지 번호를 return 한다.<br>
	 * 1. Page Group 내 Page 수*(현재 페이지 그룹 -1) + 1을 한 값이 첫 페이지이다.(페이지 그룹*페이지 그룹 개수 이 그 그룹의 마지막 번호이므로)
	 * 2. 위의 계산 결과가 0인 경우는 첫페이지 이므로 1을 return 한다. 
	 * @return
	 */
	public int getBeginPage(){
		int startPageNo = (getCurrentPageGroup()-1)*pagesPerPagegroup+1;//(1-1)*5=0에+1하면 시작페이지번호가 나옴 ,(2-1)*5=5  에+1하면 +1하면 시작페이지번호가 나옴             
		return startPageNo;
	}
	/**
	 * 현재 페이지가 속한 페이지 그룹의 마지막 페이지 번호를 return 한다.<br>
	 * 1. 현재 페이지 그룹 * 페이지 그룹내 페이지 수 가 마지막 번호이다.
	 * 2. 그 그룹의 마지막 페이지 번호가 전체 페이지의 마지막 페이지 번호보다 큰 경우는 전체 페이지의 마지막 번호를 return 한다. 
	 * @return
	 */
	public int getEndPage(){
		int endPageNo =getCurrentPageGroup()*pagesPerPagegroup;
		if(endPageNo>getTotalPage()){//마지막page가 총 page수 보다 크다면~
			endPageNo = getTotalPage();
		}		
		return endPageNo;
	}
	/**
	 * 이전 페이지 그룹이 있는지 체크
	 * 현재 페이지가 속한 페이지 그룹이 1보다 크면 true
	 * @return
	 */
	public boolean isPreviousPageGroup(){		
		boolean flag = false;
		if(getCurrentPageGroup()!=1){//현재 pagegroup이 1이 아니면 -> 이전페이지가 있어서 true;
			flag = true;
		}		
		return flag;
	}
	/**
	 * 다음 페이지 그룹이 있는지 체크
	 * 현재 페이지 그룹이 마지막 페이지 그룹(마지막 페이지 그룹 == 총 페이지 그룹 수) 보다 작으면 true
	 * @return
	 */
	public boolean isNextPageGroup(){		
		boolean flag = false;
		if(getCurrentPageGroup() < getTotalPageGroup()){//다음페이지있으면 true 없으면 false
			flag = true;
		}		
		return flag;
	}
}
