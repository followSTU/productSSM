package com.xyn.maven.test;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.xyn.maven.dao.ProductMapper;
import com.xyn.maven.entities.Product;
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {
	@Autowired
	private ProductMapper productMapper;
	@Test
	public void test() throws ParseException {
//		SimpleDateFormat dater=new SimpleDateFormat("yyyy-MM-dd");
////		studentMapper.insertSelective(student);
//		List<Student> list=studentService.getAllStudent();
//		Student student2=studentService.getStudentWithId(4);
//		List<Major> list2=majorService.getAllMajor();
//		System.out.println(student2.toString());
		
	}
	@Test
	public void test2() throws Exception{
		List<Product> list=productMapper.selectAllProduct(null);
		System.out.println(list);
	}

}
