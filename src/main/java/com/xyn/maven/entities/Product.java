package com.xyn.maven.entities;

import java.util.Date;

import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

public class Product {
    private Integer productId;

    private String name;

    private Double price;

    private Integer xiaoLiang;

    private Integer hot;

    private Integer kuCun;
    @DateTimeFormat(pattern="yyyy/MM/dd")
    private Date timeSale;
    @DateTimeFormat(pattern="yyyy/MM/dd")
    private Date timeShengChan;

    private Integer typeId;

    private Type type;
    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getXiaoLiang() {
        return xiaoLiang;
    }

    public void setXiaoLiang(Integer xiaoLiang) {
        this.xiaoLiang = xiaoLiang;
    }

    public Integer getHot() {
        return hot;
    }

    public void setHot(Integer hot) {
        this.hot = hot;
    }

    public Integer getKuCun() {
        return kuCun;
    }

    public void setKuCun(Integer kuCun) {
        this.kuCun = kuCun;
    }

    public Date getTimeSale() {
        return timeSale;
    }

    public void setTimeSale(Date timeSale) {
        this.timeSale = timeSale;
    }

    public Date getTimeShengChan() {
        return timeShengChan;
    }

    public void setTimeShengChan(Date timeShengChan) {
        this.timeShengChan = timeShengChan;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", name=" + name + ", price=" + price + ", xiaoLiang=" + xiaoLiang
				+ ", hot=" + hot + ", kuCun=" + kuCun + ", timeSale=" + timeSale + ", timeShengChan=" + timeShengChan
				+ ", typeId=" + typeId + ", type=" + type + "]";
	}
	
    
}