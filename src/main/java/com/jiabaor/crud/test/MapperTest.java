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
 * ����dao��Ĺ���
 * @author lenovo
 *�Ƽ�Spring����Ŀ�Ϳ���ʹ��Spring�ĵ�Ԫ���ԣ������Զ�ע��������Ҫ�����
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
	 * ����Department
	 * @throws Exception
	 */
	@Test
	public void testCRUD() throws Exception {
//		//1.����SpringIOC����
//		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.�������л�ȡmapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//1.���뼸������
//		departmentMapper.insertSelective(new Department(null, "������"));
//		departmentMapper.insertSelective(new Department(null, "���Բ�"));
		//2.����Ա������
//		emploveeMapper.insertSelective(new Emplovee(null, "Jerry", "M", "Jerry@jiabaor.com",1));
		//3.����������Ա��
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
