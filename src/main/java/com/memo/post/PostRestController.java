package com.memo.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	/**
	 * 글쓰기
	 * @param subject
	 * @param contnet
	 * @param file
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("subject") String subject,
			@RequestParam("content") String contnet,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		// BO create
		int row = postBO.addPost(userLoginId, userId, subject, userLoginId, file);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		if (row < 1) {
			result.put("result", "error");
			result.put("error", "error_message");
		}
		return result;
	}
	
	// 글 수정
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("postId")int postId,
			@RequestParam("subject")String subject,
			@RequestParam("content")String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		int userId = (int) session.getAttribute("userId"); 
		String userLoginId = (String) session.getAttribute("userLoginId"); 
		
		// DB update
		int row =  postBO.updatePost(userLoginId, userId, postId, subject, content, file);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("result", "success");
		
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "수정에 실패 했습니다. 관리자에게 문의 해 주세요.");
		}
		
		return result;
		
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId,
			HttpSession session) {
		
		int userId = (int)session.getAttribute("userId");
		
		int row = postBO.deletePost(postId, userId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "삭제하는데 실패 했습니다. 관리자에게 문의 해주세요");
		}
		
		return result;
		
	}
}
