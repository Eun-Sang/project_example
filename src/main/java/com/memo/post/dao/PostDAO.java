package com.memo.post.dao;

import java.util.List;

import com.memo.post.model.Post;

public interface PostDAO {

	public List<Post> selectPostList();
}
