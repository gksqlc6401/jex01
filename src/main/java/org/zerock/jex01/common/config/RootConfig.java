package org.zerock.jex01.common.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.*;
import org.apache.ibatis.transaction.Transaction;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.*;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.zerock.jex01.board.config.BoardRootConfig;

import javax.sql.DataSource;
import java.sql.Connection;
import java.util.ArrayList;


@Configuration
@Import(BoardRootConfig.class)
//@EnableAspectJAutoProxy 얘는 없어도 트렌젝션 가능
@EnableTransactionManagement//얘가 있어야 트렌젝션 할수있음
public class RootConfig {


    @Bean
    public SqlSessionFactory sqlSessionFactory()throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource());

        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public DataSource dataSource(){
        HikariConfig config = new HikariConfig();
        //config.setDriverClassName("com.mysql.cj.jdbc.Driver");

        config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

        //config.setJdbcUrl("jdbc:mysql://localhost:3306/springdb");
        config.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/springdb");
        config.setUsername("springuser");
        config.setPassword("springuser");
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;
    }

    @Bean
    public TransactionManager transactionManager(){
        return  new DataSourceTransactionManager(dataSource());//트렌젝션 하는 거
    }

    @Bean( name = "names")
    public ArrayList<String> names(){
        ArrayList<String> list = new ArrayList<>();
        list.add("AAA");
        list.add("BBB");
        list.add("CCC");
        return list;
    }
}