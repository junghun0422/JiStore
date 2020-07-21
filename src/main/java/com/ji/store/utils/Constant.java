package com.ji.store.utils;

public class Constant 
{
	/* 
	 * ===============================
	 *    http
	 * =============================== 
	 */
	// 성공코드
	public static final String RESULT_SUCCESS_CODE = "00";
	
	
	// 실패 코드
	
	/**
	 * 서버로 전송해야하는 필수 파라미터가 없는 경우 field not found..
	 */
	public static final String RESULT_FAIL_CODE_01 = "01";
	
	/**
	 * 조회된 결과가 없는 경우 data not found....
	 */
	public static final String RESULT_FAIL_CODE_02 = "02";
	
	/**
	 * 사용 불가
	 */
	public static final String RESULT_FAIL_CODE_03 = "03";


	/**
	 * 'Exception'이 발생한 실패코드
	 */
	public static final String RESULT_FILE_CODE_90 = "90";
}
