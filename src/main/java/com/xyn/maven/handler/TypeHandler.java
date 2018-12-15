package com.xyn.maven.handler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyn.maven.entities.Type;
import com.xyn.maven.service.TypeService;
import com.xyn.maven.until.Msg;

@Controller
public class TypeHandler {
	@Autowired
	private TypeService typeService;
	@ResponseBody
	@GetMapping("/getTypes")
	public Msg getAllType(){
		List<Type> types=typeService.getAllType();
		return Msg.success().add("types", types);
	}
}
