package kr.or.ddit.security;

import java.util.Collections;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
// "/.well-known/appspecific/com.chrome.devtools.json" 로 리다이렉팅 하는것을 막기위한 컨트롤러
@Controller
public class WellKnownController {

	@ResponseBody
	@GetMapping("/.well-known/appspecific/com.chrome.devtools.json")
	public ResponseEntity<Map<String, Object>> chromeDevToolsJson(){
		return ResponseEntity.ok(Collections.emptyMap());
	}
}
