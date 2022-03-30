package com.memo.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.memo.post.model.Post;

public interface PostDAO {

	public List<Post> selectPostListByUserId(int userId);
	
	public int insertPost(
			@Param("userId") int userId, 
			@Param("subject") String subject, 
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
	
	public Post selectPostById(int postId);
	
	public int updatePost(
			@Param("userId") int userId, 
			@Param("postId") int postId,
			@Param("subject") String subject, 
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
	
	public int deletePost(
			@Param("postId") int postId,
			@Param("userId") int userId);
}
