package com.jiabaor.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabaor.crud.dao.EmploveeMapper;
import com.jiabaor.crud.pojo.Emplovee;
import com.jiabaor.crud.pojo.Msg;
import com.jiabaor.crud.service.EmploveeService;

/**
 * 处理员工CRUD请求
 * 
 * @author lenovo
 *
 */
@Controller
public class EmploveeController {

	@Autowired
	EmploveeService emploveeService;

	/**
	 * 员工删除
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids) {
		//批量删除
		if (ids.contains("-")) {
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			emploveeService.deleteBatch(del_ids);
		}else {
			//单个删除
			Integer id=Integer.parseInt(ids);
			emploveeService.deleteEmp(id);	
		}
		return Msg.success();
	}
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * 
	 * 
	 * 员工更新方法
	 * @param emplovee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Emplovee emplovee) {
		System.out.println(emplovee);
		emploveeService.updateEmp(emplovee);
		return Msg.success();
	}
	
	/**
	 * 根据员工id查询
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id) {
		Emplovee emplovee=emploveeService.getEmp(id);
		return Msg.success().add("emp", emplovee);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(String empName) {
		//先判断用户名是否是合法的表达式
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
		}
		//数据库用户名重复校验
		boolean b=emploveeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页插件
		// 在查询之前只需要调用,传入页码 ，以及每页的大小
		PageHelper.startPage(pn, 8);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Emplovee> emps = emploveeService.getAll();

		// 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}

	/**
	 * 员工保存
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Emplovee emplovee,BindingResult result) {
		if (result.hasErrors()) {
			//校验失败，返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFirlds", map);
		}else {
			emploveeService.saveEmp(emplovee);
			return Msg.success();
		}
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * 导入jackson包
	 * @return
	 */
//	@RequestMapping("/emps")
//	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//		// 引入PageHelper分页插件
//		// 在查询之前只需要调用,传入页码 ，以及每页的大小
//		PageHelper.startPage(pn, 8);
//		// startPage后面紧跟的这个查询就是一个分页查询
//		List<Emplovee> emps = emploveeService.getAll();
//
//		// 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
//		PageInfo page = new PageInfo(emps, 5);
//		model.addAttribute("pageInfo", page);
//		return "list";
//	}
}
