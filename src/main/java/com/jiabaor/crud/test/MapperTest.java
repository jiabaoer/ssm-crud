package com.jiabaor.crud.test;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jiabaor.crud.dao.DepartmentMapper;
import com.jiabaor.crud.dao.EmploveeMapper;
import com.jiabaor.crud.pojo.Department;
import com.jiabaor.crud.pojo.Emplovee;

/**
 * 测试dao层的工作
 * @author lenovo
 *推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmploveeMapper emploveeMapper;
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试Department
	 * @throws Exception
	 */
	@Test
	public void testCRUD() throws Exception {
//		//1.创建SpringIOC容器
//		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.从容器中获取mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//1.插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		//2.生成员工数据
//		emploveeMapper.insertSelective(new Emplovee(null, "Jerry", "M", "Jerry@jiabaor.com",1));
		//3.批量插入多个员工
		/*
		 * for (int i = 0; i < 1000; i++) { emploveeMapper.insertSelective(new
		 * Emplovee(null, "Jerry", "M", "Jerry@jiabaor.com",1)); }
		 */
		EmploveeMapper mapper = sqlSession.getMapper(EmploveeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Emplovee(null, uid, "M", uid+"@jiabaor.com", 1));
		}
		
	}
}
