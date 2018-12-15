package com.xyn.maven.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyn.maven.dao.ProductMapper;
import com.xyn.maven.entities.Product;
import com.xyn.maven.entities.Product;
import com.xyn.maven.entities.ProductExample;
import com.xyn.maven.entities.ProductExample.Criteria;
import com.xyn.maven.entities.ProductSearParams;

@Service
public class ProductService {
	@Autowired
	private ProductMapper ProductMapper;
	public List<Product> getAllProduct(){
		ProductExample ProductExample=new ProductExample();
		ProductExample.setOrderByClause("Product_Id");
		return ProductMapper.selectAllProduct(ProductExample);
	}
	public Product getProductWithId(Integer id){
		return ProductMapper.selectByPrimaryKey(id);
	}
	
	public Long getProductWithName(String name){
		ProductExample ProductExample=new ProductExample();
		Criteria criteria=ProductExample.createCriteria();
		criteria.andNameEqualTo(name);
		long count=ProductMapper.countByExample(ProductExample);
		return count;
	}
	
	public void deleteProduct(Integer id){
		ProductMapper.deleteByPrimaryKey(id);
	}
	
	public void saveProduct(Product Product){
		ProductMapper.insertSelective(Product);
	}
	public void updateProduct(Product Product){
		ProductMapper.updateByPrimaryKey(Product);
	}

	public void deleteProBatch(List<Integer> idList){
		ProductExample ProductExample=new ProductExample();
		Criteria criteria=ProductExample.createCriteria();
		criteria.andProductIdIn(idList);
		ProductMapper.deleteByExample(ProductExample);
	}
	public List<Product> searchProductByParams(ProductSearParams ProductParams){
		String name=ProductParams.getName();
		Integer typeId=ProductParams.getTypeId();
		 ProductExample example=new ProductExample();
		 Criteria criteria=example.createCriteria();
		 if(name!=null && name!=""){
			 name="%"+name+"%";
			 criteria.andNameLikeMe(name);
		 }
		 if(typeId!=null){
			 criteria.andTypeIdEqualToMe(typeId);
		 } 
		 return ProductMapper.selectAllProduct(example);
//		 return ProductMapper.selectProductByParams(name, phone, gender, majorId);
	}
}
