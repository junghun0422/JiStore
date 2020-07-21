package com.ji.store;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootApplication
@MapperScan( basePackages = "com.ji.store.mapper" )
//@EnableAutoConfiguration( exclude = { DataSourceAutoConfiguration.class } )
public class JiStoreApplication 
{
	public static void main( String[] args ) 
	{
		SpringApplication.run(JiStoreApplication.class, args);
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception
	{
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource( dataSource );
		sessionFactory.setTypeAliasesPackage( "com.ji.store.mapper" );
		sessionFactory.setMapperLocations( new PathMatchingResourcePatternResolver().getResources( "classpath:mybatis/*.xml" ) );
		return sessionFactory.getObject();
	}
	
	@Bean
	public SqlSessionTemplate sqlSession( SqlSessionFactory sqlSessionFactory )
	{
		return new SqlSessionTemplate( sqlSessionFactory );
	}
}
