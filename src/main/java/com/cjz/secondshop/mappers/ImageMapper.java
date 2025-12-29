package com.cjz.secondshop.mappers;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.cjz.secondshop.models.Image;

import java.util.List;
@Mapper
public interface ImageMapper {
	@Select("select * from image_table where good_id = #{goodId};")
	List<Image> getImageByGoodId(Integer goodId);

	@Insert("insert into image_table(good_id, name, url) values(#{goodId}, #{name}, #{url});")
	int insertImage(Image image);

	@Delete("delete from image_table where good_id = #{goodId};")
	int deleteImage(Integer goodId);
}
