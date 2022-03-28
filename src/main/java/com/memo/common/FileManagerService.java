package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	// 실제 이미지가 저장되는 경로
	public final static String FILE_UPLOAD_PATH = "D:\\이은상\\6_Spring project\\ex_memo\\workspace\\images/";
	
	// input : file
	// output : image path
	public String saveFile(String loginId, MultipartFile file) throws IOException {
		// 파일 디렉토리 경로 ex) 로그인아이디_현재시간/sun.jpg
		// 파일명이 겹치지 않게 하기 위해 현재시간과 아이디를 경로에 붙여준다.
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		
		// D:\\이은상\\6_Spring project\\ex_memo\\workspace\\images/"
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;	// 디렉토리 생성 실패시 path null 리턴
		}
		
		// 파일 업로드:byte 단위로 업로드한다.
		byte[] bytes = file.getBytes();
		Path path = Paths.get(filePath + file.getOriginalFilename());
		Files.write(path, bytes);
		
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	// 파일 삭제
	// input: imagePath
	// output: x
	public void deleteFile(String imagePath) throws IOException {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		// 이미지 삭제
		if (Files.exists(path)) {
			Files.delete(path);
		}
		
		// 디렉토리(폴더) 삭제
 		path = path.getParent();
 		if (Files.exists(path)) {
 			Files.delete(path);
 		}
	}
}
