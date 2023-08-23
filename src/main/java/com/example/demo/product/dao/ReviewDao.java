package com.example.demo.product.dao;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.product.dto.*;
import com.example.demo.product.entity.*;

@Mapper
public interface ReviewDao {
	@Insert("insert into review values(review_seq.nextval, #{content}, #{writer}, #{writeTime}, #{star}, #{pno})")
	public void save(Review review);

	@Select("select rno, content, writer, TO_CHAR(write_time, 'YYYY-MM-DD HH24:MI:SS') as writeTime, star from review where pno=#{pno} order by rno desc")
	public List<ReviewDto.Read> findByPno(Long pno);

	@Delete("delete from review where rno=#{rno} and writer=#{writer}")
	public Integer deleteByIdAndWriter(Long rno, String writer);

	@Delete("delete from review where pno=#{pno}")
	public Integer deleteByPno(Long pno);
}
