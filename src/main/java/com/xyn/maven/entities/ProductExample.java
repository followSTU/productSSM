package com.xyn.maven.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ProductExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andProductIdIsNull() {
            addCriterion("Product_Id is null");
            return (Criteria) this;
        }

        public Criteria andProductIdIsNotNull() {
            addCriterion("Product_Id is not null");
            return (Criteria) this;
        }

        public Criteria andProductIdEqualTo(Integer value) {
            addCriterion("Product_Id =", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotEqualTo(Integer value) {
            addCriterion("Product_Id <>", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdGreaterThan(Integer value) {
            addCriterion("Product_Id >", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("Product_Id >=", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdLessThan(Integer value) {
            addCriterion("Product_Id <", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdLessThanOrEqualTo(Integer value) {
            addCriterion("Product_Id <=", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdIn(List<Integer> values) {
            addCriterion("Product_Id in", values, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotIn(List<Integer> values) {
            addCriterion("Product_Id not in", values, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdBetween(Integer value1, Integer value2) {
            addCriterion("Product_Id between", value1, value2, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotBetween(Integer value1, Integer value2) {
            addCriterion("Product_Id not between", value1, value2, "productId");
            return (Criteria) this;
        }

        public Criteria andNameIsNull() {
            addCriterion("Name is null");
            return (Criteria) this;
        }

        public Criteria andNameIsNotNull() {
            addCriterion("Name is not null");
            return (Criteria) this;
        }

        public Criteria andNameEqualTo(String value) {
            addCriterion("Name =", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotEqualTo(String value) {
            addCriterion("Name <>", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThan(String value) {
            addCriterion("Name >", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThanOrEqualTo(String value) {
            addCriterion("Name >=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThan(String value) {
            addCriterion("Name <", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThanOrEqualTo(String value) {
            addCriterion("Name <=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLike(String value) {
            addCriterion("Name like", value, "name");
            return (Criteria) this;
        }
        //gdsg
        public Criteria andNameLikeMe(String value) {
            addCriterion("a.Name like", value, "name");
            return (Criteria) this;
        }
        public Criteria andNameNotLike(String value) {
            addCriterion("Name not like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameIn(List<String> values) {
            addCriterion("Name in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotIn(List<String> values) {
            addCriterion("Name not in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameBetween(String value1, String value2) {
            addCriterion("Name between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotBetween(String value1, String value2) {
            addCriterion("Name not between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andPriceIsNull() {
            addCriterion("Price is null");
            return (Criteria) this;
        }

        public Criteria andPriceIsNotNull() {
            addCriterion("Price is not null");
            return (Criteria) this;
        }

        public Criteria andPriceEqualTo(Double value) {
            addCriterion("Price =", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotEqualTo(Double value) {
            addCriterion("Price <>", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThan(Double value) {
            addCriterion("Price >", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThanOrEqualTo(Double value) {
            addCriterion("Price >=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThan(Double value) {
            addCriterion("Price <", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThanOrEqualTo(Double value) {
            addCriterion("Price <=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceIn(List<Double> values) {
            addCriterion("Price in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotIn(List<Double> values) {
            addCriterion("Price not in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceBetween(Double value1, Double value2) {
            addCriterion("Price between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotBetween(Double value1, Double value2) {
            addCriterion("Price not between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangIsNull() {
            addCriterion("Xiao_Liang is null");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangIsNotNull() {
            addCriterion("Xiao_Liang is not null");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangEqualTo(Integer value) {
            addCriterion("Xiao_Liang =", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangNotEqualTo(Integer value) {
            addCriterion("Xiao_Liang <>", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangGreaterThan(Integer value) {
            addCriterion("Xiao_Liang >", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangGreaterThanOrEqualTo(Integer value) {
            addCriterion("Xiao_Liang >=", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangLessThan(Integer value) {
            addCriterion("Xiao_Liang <", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangLessThanOrEqualTo(Integer value) {
            addCriterion("Xiao_Liang <=", value, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangIn(List<Integer> values) {
            addCriterion("Xiao_Liang in", values, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangNotIn(List<Integer> values) {
            addCriterion("Xiao_Liang not in", values, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangBetween(Integer value1, Integer value2) {
            addCriterion("Xiao_Liang between", value1, value2, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andXiaoLiangNotBetween(Integer value1, Integer value2) {
            addCriterion("Xiao_Liang not between", value1, value2, "xiaoLiang");
            return (Criteria) this;
        }

        public Criteria andHotIsNull() {
            addCriterion("Hot is null");
            return (Criteria) this;
        }

        public Criteria andHotIsNotNull() {
            addCriterion("Hot is not null");
            return (Criteria) this;
        }

        public Criteria andHotEqualTo(Integer value) {
            addCriterion("Hot =", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotNotEqualTo(Integer value) {
            addCriterion("Hot <>", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotGreaterThan(Integer value) {
            addCriterion("Hot >", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotGreaterThanOrEqualTo(Integer value) {
            addCriterion("Hot >=", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotLessThan(Integer value) {
            addCriterion("Hot <", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotLessThanOrEqualTo(Integer value) {
            addCriterion("Hot <=", value, "hot");
            return (Criteria) this;
        }

        public Criteria andHotIn(List<Integer> values) {
            addCriterion("Hot in", values, "hot");
            return (Criteria) this;
        }

        public Criteria andHotNotIn(List<Integer> values) {
            addCriterion("Hot not in", values, "hot");
            return (Criteria) this;
        }

        public Criteria andHotBetween(Integer value1, Integer value2) {
            addCriterion("Hot between", value1, value2, "hot");
            return (Criteria) this;
        }

        public Criteria andHotNotBetween(Integer value1, Integer value2) {
            addCriterion("Hot not between", value1, value2, "hot");
            return (Criteria) this;
        }

        public Criteria andKuCunIsNull() {
            addCriterion("Ku_Cun is null");
            return (Criteria) this;
        }

        public Criteria andKuCunIsNotNull() {
            addCriterion("Ku_Cun is not null");
            return (Criteria) this;
        }

        public Criteria andKuCunEqualTo(Integer value) {
            addCriterion("Ku_Cun =", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunNotEqualTo(Integer value) {
            addCriterion("Ku_Cun <>", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunGreaterThan(Integer value) {
            addCriterion("Ku_Cun >", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunGreaterThanOrEqualTo(Integer value) {
            addCriterion("Ku_Cun >=", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunLessThan(Integer value) {
            addCriterion("Ku_Cun <", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunLessThanOrEqualTo(Integer value) {
            addCriterion("Ku_Cun <=", value, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunIn(List<Integer> values) {
            addCriterion("Ku_Cun in", values, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunNotIn(List<Integer> values) {
            addCriterion("Ku_Cun not in", values, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunBetween(Integer value1, Integer value2) {
            addCriterion("Ku_Cun between", value1, value2, "kuCun");
            return (Criteria) this;
        }

        public Criteria andKuCunNotBetween(Integer value1, Integer value2) {
            addCriterion("Ku_Cun not between", value1, value2, "kuCun");
            return (Criteria) this;
        }

        public Criteria andTimeSaleIsNull() {
            addCriterion("Time_Sale is null");
            return (Criteria) this;
        }

        public Criteria andTimeSaleIsNotNull() {
            addCriterion("Time_Sale is not null");
            return (Criteria) this;
        }

        public Criteria andTimeSaleEqualTo(Date value) {
            addCriterion("Time_Sale =", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleNotEqualTo(Date value) {
            addCriterion("Time_Sale <>", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleGreaterThan(Date value) {
            addCriterion("Time_Sale >", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleGreaterThanOrEqualTo(Date value) {
            addCriterion("Time_Sale >=", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleLessThan(Date value) {
            addCriterion("Time_Sale <", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleLessThanOrEqualTo(Date value) {
            addCriterion("Time_Sale <=", value, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleIn(List<Date> values) {
            addCriterion("Time_Sale in", values, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleNotIn(List<Date> values) {
            addCriterion("Time_Sale not in", values, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleBetween(Date value1, Date value2) {
            addCriterion("Time_Sale between", value1, value2, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeSaleNotBetween(Date value1, Date value2) {
            addCriterion("Time_Sale not between", value1, value2, "timeSale");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanIsNull() {
            addCriterion("Time_Sheng_Chan is null");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanIsNotNull() {
            addCriterion("Time_Sheng_Chan is not null");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanEqualTo(Date value) {
            addCriterion("Time_Sheng_Chan =", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanNotEqualTo(Date value) {
            addCriterion("Time_Sheng_Chan <>", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanGreaterThan(Date value) {
            addCriterion("Time_Sheng_Chan >", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanGreaterThanOrEqualTo(Date value) {
            addCriterion("Time_Sheng_Chan >=", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanLessThan(Date value) {
            addCriterion("Time_Sheng_Chan <", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanLessThanOrEqualTo(Date value) {
            addCriterion("Time_Sheng_Chan <=", value, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanIn(List<Date> values) {
            addCriterion("Time_Sheng_Chan in", values, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanNotIn(List<Date> values) {
            addCriterion("Time_Sheng_Chan not in", values, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanBetween(Date value1, Date value2) {
            addCriterion("Time_Sheng_Chan between", value1, value2, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTimeShengChanNotBetween(Date value1, Date value2) {
            addCriterion("Time_Sheng_Chan not between", value1, value2, "timeShengChan");
            return (Criteria) this;
        }

        public Criteria andTypeIdIsNull() {
            addCriterion("Type_Id is null");
            return (Criteria) this;
        }

        public Criteria andTypeIdIsNotNull() {
            addCriterion("Type_Id is not null");
            return (Criteria) this;
        }

        public Criteria andTypeIdEqualTo(Integer value) {
            addCriterion("Type_Id =", value, "typeId");
            return (Criteria) this;
        }
        //fds
        public Criteria andTypeIdEqualToMe(Integer value) {
            addCriterion("a.Type_Id =", value, "typeId");
            return (Criteria) this;
        }
        public Criteria andTypeIdNotEqualTo(Integer value) {
            addCriterion("Type_Id <>", value, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdGreaterThan(Integer value) {
            addCriterion("Type_Id >", value, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("Type_Id >=", value, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdLessThan(Integer value) {
            addCriterion("Type_Id <", value, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdLessThanOrEqualTo(Integer value) {
            addCriterion("Type_Id <=", value, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdIn(List<Integer> values) {
            addCriterion("Type_Id in", values, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdNotIn(List<Integer> values) {
            addCriterion("Type_Id not in", values, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdBetween(Integer value1, Integer value2) {
            addCriterion("Type_Id between", value1, value2, "typeId");
            return (Criteria) this;
        }

        public Criteria andTypeIdNotBetween(Integer value1, Integer value2) {
            addCriterion("Type_Id not between", value1, value2, "typeId");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}