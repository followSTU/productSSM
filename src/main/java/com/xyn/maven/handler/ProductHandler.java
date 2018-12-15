package com.xyn.maven.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xyn.maven.entities.Product;
import com.xyn.maven.entities.ProductSearParams;
import com.xyn.maven.entities.Type;
import com.xyn.maven.service.ProductService;
import com.xyn.maven.service.TypeService;
import com.xyn.maven.until.Msg;

@Controller
public class ProductHandler {
	@Autowired
	private ProductService productService;
	@Autowired
	private TypeService typeService;
	@RequestMapping("/products")
	@ResponseBody
	public Msg ListByJson( @RequestParam(value="page",defaultValue="1")Integer page){
		//传入page页，设置单页page的大小
		PageHelper.startPage(page,8);
		//往数据库里面取值
		List<Product> products=productService.getAllProduct();
		//将学生封装进pageinfor里面
		PageInfo<Product> pageInfo=new PageInfo<>(products,4);
		return Msg.success().add("products", pageInfo);
	}
	
	//根据参数查询所有学生
		@ResponseBody
		@RequestMapping(value="/searchProduct",method=RequestMethod.POST)
		public Msg searchStudentByParams(ProductSearParams Params,BindingResult result){
			PageHelper.startPage(1,8);
			if(Params.getTypeId()==0 || Params.getTypeId()==-1){
				Params.setTypeId(null);
			}
			if(Params.getName()=="404"){
				Params.setName(null);
			}
			List<Product> products=productService.searchProductByParams(Params);
			PageInfo<Product> pageInfo=new PageInfo<>(products,4);
			return Msg.success().add("products",pageInfo);
			
		}
	//返回单个要更新的学生信息
	@ResponseBody
	@RequestMapping(value="/proUpdate/{id}",method=RequestMethod.GET)
	public Msg getStudentByid(@PathVariable("id") Integer id){
		Product product=productService.getProductWithId(id);
		return Msg.success().add("product", product);
	}
	//同时删除多个学生信息
	@ResponseBody
	@RequestMapping(value="/prosDelete/{Ids}",method=RequestMethod.DELETE)
	public Msg deleteStudentByIds(@PathVariable("Ids") String Ids){
			if(Ids.contains(",")){
				String[] strIds=Ids.split(",");
				System.out.println(strIds);
				List<Integer> proIds=new ArrayList<Integer>();
				for(int i=0;i<strIds.length;i++){
					proIds.add(Integer.parseInt(strIds[i]));
				}
				System.out.println("数组："+proIds);
				try {
					productService.deleteProBatch(proIds);
					return Msg.success();
				} catch (Exception e) {
					return Msg.fail().add("info","删除学生信息出错，请重试！！！");
				}
			}else{
				if(Ids!=null||Ids!=""){
					System.out.println(Ids);
					try {
						productService.deleteProduct(Integer.parseInt(Ids));
						return Msg.success();
					} catch (Exception e) {
						return Msg.fail().add("info","删除学生信息出错，请重试！！！");
					}
				}else{
					System.out.println("学生信息为空");
					return Msg.fail().add("info","请选择要删除的学生哦！！！");
				}
			}
			
	}
	//根据学生id删除单个学生信息
	@ResponseBody
	@RequestMapping(value="/proDelete/{id}",method=RequestMethod.DELETE)
	public Msg deleteStudentById(@PathVariable("id") Integer id){
			productService.deleteProduct(id);
			return Msg.success();
	}
	//检测用户是否已被占用1
	@ResponseBody
	@RequestMapping(value="/checkProName")
	public Msg checkName(@RequestParam(value="proName") String proName){
		long num=productService.getProductWithName(proName);
		if(num>0){
			return  Msg.fail();
		}else{
			return Msg.success();
		}
	}
	//添加学生
	@ResponseBody
	@RequestMapping(value="/AddPro",method=RequestMethod.POST)
	public Msg addStudent(@Valid Product product,BindingResult result){
		if(result.getErrorCount()>0){
			Map<String,Object> errors=new HashMap<String,Object>();
			for(FieldError error:result.getFieldErrors()){
				System.out.println(error.getField()+":"+error.getDefaultMessage());
				errors.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("error",errors);
		}
		productService.saveProduct(product);
		return new Msg().success();
	}
	//更新学生信息
	
	@ResponseBody
	@RequestMapping(value="/updatePro/{id}",method=RequestMethod.PUT)
	public Msg updateStudent( @Valid Product product,BindingResult result){
		if(result.getErrorCount()>0){
			Map<String,Object> errors=new HashMap<String,Object>();
			for(FieldError error:result.getFieldErrors()){
				System.out.println(error.getField()+":"+error.getDefaultMessage());
				errors.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("error",errors);
		}
		try {
			System.out.println(product);
			productService.updateProduct(product);
			return new Msg().success();
		} catch (Exception e) {
			return new Msg().add("error",e.getMessage());
		}
	}
}
