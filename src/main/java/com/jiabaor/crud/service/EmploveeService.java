package com.jiabaor.crud.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabaor.crud.dao.EmploveeMapper;
import com.jiabaor.crud.pojo.Emplovee;
import com.jiabaor.crud.pojo.EmploveeExample;
import com.jiabaor.crud.pojo.EmploveeExample.Criteria;

@Service
public class EmploveeService {

	@Autowired
	EmploveeMapper emploveeMapper;

	public List<Emplovee> getAll() {
		return emploveeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * 
	 * @param emplovee
	 */
	public void saveEmp(Emplovee emplovee) {
		emploveeMapper.insertSelective(emplovee);
	}

	/**
	 * 校验用户名是否可用
	 * 
	 * @param empName
	 * @return true：代表当前姓名可用 false：不可用
	 */
	public boolean checkUser(String empName) {
		EmploveeExample example = new EmploveeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = emploveeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询
	 * 
	 * @param id
	 * @return
	 */
	public Emplovee getEmp(Integer id) {
		Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
		return emplovee;
	}

	/**
	 * 员工更新
	 * 
	 * @param emplovee
	 */
	public void updateEmp(Emplovee emplovee) {
		emploveeMapper.updateByPrimaryKeySelective(emplovee);
	}

	/**
	 * 员工删除
	 * 
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		emploveeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		EmploveeExample example = new EmploveeExample();
		Criteria criteria = example.createCriteria();
		// delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		emploveeMapper.deleteByExample(example);
	}
}
