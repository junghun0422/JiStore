package com.ji.store.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ji.store.dto.ReportsDto;

@Repository( "reportsMapper" )
public interface ReportsMapper 
{
	List<ReportsDto> reportsList();
	
	int reportSize();
	
	List<ReportsDto> selectReportsPaging( ReportsDto reportsDto );
}
