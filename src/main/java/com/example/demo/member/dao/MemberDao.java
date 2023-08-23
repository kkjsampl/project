package com.example.demo.member.dao;

import org.apache.ibatis.annotations.*;

import com.example.demo.member.entity.*;

@Mapper
public interface MemberDao {
  @Insert("insert into member values(#{username},#{password},#{email},#{birthday},#{joinday},#{profile},#{role})")	
  public Integer save(Member member);

  @Select("select * from member where username=#{username} and rownum=1")
  public Member findById(String username);

  @Select("select * from member where email=#{email} and rownum=1")
  public Member findByEmail(String email);

  @Update("update member set email=#{email} where username=#{username}")
  public Integer changeEmail(String email, String username);

  @Delete("delete from member where username=#{username}")
  public Integer deleteById(String username);
}
