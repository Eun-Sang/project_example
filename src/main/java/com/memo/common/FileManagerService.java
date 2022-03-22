package com.memo.common;

import java.io.File;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	// 실제 이미지가 저장되는 경로
	public final static String FILE_UPLOAD_PATH = "D:\\이은상\\6_Spring project\\ex_memo\\workspace\\images/";
	
	// input : file
	// output : image path
	public String saveFile(String loginId, MultipartFile file) {
		// 파일 디렉토리 경로 ex) 로그인아이디_현재시간/sun.jpg
		// 파일명이 겹치지 않게 하기 위해 현재시간과 아이디를 경로에 붙여준다.
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		
		// D:\\이은상\\6_Spring project\\ex_memo\\workspace\\images/"
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;	// 디렉토리 생성 실패시 path null 리턴
		}
		
		return null;
	}
}
