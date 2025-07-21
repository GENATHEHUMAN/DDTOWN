package kr.or.ddit.ddtown.controller.emp.audition;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EmpAuditionDownloadView extends AbstractView{

	private String uploadBasePath = "C:/upload";
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> auditionFileMap = (Map<String, Object>) model.get("auditionFileMap");
		
		String fileSavePath = auditionFileMap.get("fileSavepath").toString();
		String fileOriginalName = auditionFileMap.get("fileOriginalName").toString();
		String fileSaveName = auditionFileMap.get("fileSaveName").toString();
		
		File saveFile = new File(uploadBasePath + File.separator + fileSavePath + File.separator + fileSaveName);
		
		String agent = request.getHeader("User-Agent");
		if(StringUtils.containsIgnoreCase(agent, "mise") ||
			StringUtils.containsIgnoreCase(agent, "trident")){
			fileOriginalName = URLEncoder.encode(fileOriginalName, "UTF-8");
		}else {
			fileOriginalName = new String(fileOriginalName.getBytes(), "ISO-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+ fileOriginalName + "\"");
		response.setHeader("Content-Lingth", auditionFileMap.get("fileSize").toString());
		
		//try(){} : try with resource
		// ()안에 명시한 객체는 finally로 최종 열린 객체에 대한 cloes()를 처리하지 않아도 자동 close()가 이루아진다.
		
		try(
			OutputStream os = response.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);
		}
	}
	
	

}