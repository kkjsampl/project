package com.example.demo.product.dao;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.product.dto.*;
import com.example.demo.product.entity.*;

@Mapper
public interface ProductDao {
	
	public Integer save(Product product);
	
	@Select("select count(*) from product")
	public Long count();
	
	public List<ProductDto.ForList> findAll(Long startRownum, Long endRownum);

	@Select("select * from product where pno=#{pno} and rownum=1")
	public Product findById(Long pno);
	
	@Delete("delete from product where pno=#{pno}")
	public Integer deleteById(Long pno);
}
