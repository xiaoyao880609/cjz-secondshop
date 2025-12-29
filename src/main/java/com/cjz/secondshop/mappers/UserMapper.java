package com.cjz.secondshop.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.cjz.secondshop.models.User;

/**
 * @author cuijingzhi
 */
@Mapper
public interface UserMapper {

    @Select("select * from user_table;")
    List<User> getAllUser();

    @Select("select * from user_table where id = #{id}")
    User getUserById(int id);

    @Select("select * from user_table where email = #{email}")
    User getUserByEmail(String email);

    @Select("select * from user_table where address = #{address}")
    User getUserByAddress(String address);

    @Select("select * from user_table where mobile = #{mobile}")
    User getUserByMobile(String mobile);

    @Insert("insert into user_table (name, mobile, email, password, address, code, photo_url, role_id, gender, register_date, status_id) " +
            "values (#{name}, #{mobile}, #{email}, #{password}, #{address}, #{code}, '/statics/image/photos/default/default.png', 102, #{gender}, now(), 4);")
    int insertUser(User user);

    @Update("UPDATE user_table SET name = #{name}, mobile = #{mobile}, email = #{email}, address = #{address}, gender = #{gender}, photo_url = #{photoUrl} where id = #{id};")
    int updateUser(User user);

    @Delete("delete from user_table where id = #{userId};")
    int deleteUser(Integer userId);

    @Update("update user_table set status_id = #{0} where id = #{1};")
    int updateUserStatus(Integer statusId, Integer userId);

    @Update("update user_table set password = #{0}, code = #{1} where id = #{2};")
    int updatePassword(String newPassword, String code, Integer userId);

}
