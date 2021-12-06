package com.green.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.green.vo.ImageVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
public class ImageUploadController {

	
	
	
	@PostMapping(value = "/uploadImage",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ImageVO>> uploadAjaxPost( MultipartFile[] upload) {
		List<ImageVO> list = new ArrayList<>();//추가 
		String uploadFolder = "c:\\upload";
		String uploadFolderPath = getFolder(); //변경 
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		log.info("파일 업로드된 경로 :" +  uploadPath);
		if(!uploadPath.exists()) uploadPath.mkdirs();//파일의 경로가 존재하지 않으면 폴더 새로 생성 
		for(MultipartFile i : upload) {
			ImageVO imageVO = new ImageVO();
			String uploadFileName = i.getOriginalFilename();
			log.info("업로드 파일명: " +  uploadFileName);
			log.info("업로드 파일 크기: " +  i.getSize());
			imageVO.setFileName(uploadFileName); //추가 
			UUID uuid = UUID.randomUUID();//고유한 키를 생성해주는 자바 util 
			uploadFileName= uuid.toString()+"_" + uploadFileName;//고유키 + "_" + 원래 파일명 
			try {
				File saveFile = new File(uploadPath,uploadFileName);
				i.transferTo(saveFile); 
				imageVO.setUuid(uuid.toString()); //추가
				imageVO.setUploadPath(uploadFolderPath); //추가 
				FileOutputStream thumbnail = new FileOutputStream(
				new File(uploadPath,"s_" + uploadFileName));
				Thumbnailator.createThumbnail(i.getInputStream(), thumbnail,200,200);//섬네일 이미지 생성 
				thumbnail.close();
				list.add(imageVO);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} //end for  
		return  new ResponseEntity<>(list, HttpStatus.OK);
	}
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) throws IOException{ //화면에 출력하는기능을 여기 컨트롤러에서 담당 
		log.info("컨트롤러의 display에서의 fileName:" + fileName);
		File file = new File("c:\\upload\\" + fileName);
		log.info("file:" + file);
		ResponseEntity<byte[]> result = null;
		HttpHeaders header = new HttpHeaders();
		header.add("Content-type", Files.probeContentType(file.toPath()));
		result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,
				HttpStatus.OK);
		return result;
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deletFile: " + fileName);
		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName,"UTF-8"));
			file.delete();//thumbnail 파일 삭제
			String largeFileName = file.getAbsolutePath().replace("s_", "");
			//thumbnail 파일을 의미하는  s_를 제거하여 원래 파일명 구함 
			log.info("원래 파일 이름 :" +  largeFileName);
			file = new File(largeFileName);
			file.delete();//원래 크기의 파일 삭제 
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private String getFolder() { //오늘날짜를 이용하여 폴더 구조의 문자열을 반환하는 함수 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str =  sdf.format(date);
		return str.replace("-", File.separator);//문자열중 "-"를 파일의 구분자(separator)로 교체함 
	}
}
