package com.xyn.maven.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyn.maven.dao.TypeMapper;
import com.xyn.maven.entities.Type;

@Service
public class TypeService {
	@Autowired
	private TypeMapper typeMapper;
	public List<Type> getAllType(){
		return typeMapper.selectByExample(null);
	}
}
