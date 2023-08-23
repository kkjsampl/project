package com.example.demo.product.dao;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.product.entity.*;

@Mapper
public interface ImageDao {
	@Insert("insert into image values(#{pno}, #{name})")
	public Integer save(Image image);
	
	@Select("select * from image where pno=#{pno}")
	public List<Image> findByPno(Long pno);

	@Delete("delete from image where pno=#{pno}")
	public Integer deleteByPno(Long pno);

}
