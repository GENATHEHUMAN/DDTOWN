package kr.or.ddit.config;

import java.io.File;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.thymeleaf.spring6.SpringTemplateEngine;
import org.thymeleaf.spring6.view.ThymeleafViewResolver;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableAsync
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Value("${kr.or.ddit.upload.path.mac}")
	private String macUploadBasePath;
	
	@Value("${kr.or.ddit.upload.path}")
	private String windowUploadBasePath;
	
	@Override
    public void addCorsMappings(@NonNull CorsRegistry registry) {
        registry.addMapping("/**")
            .allowedOrigins("http://localhost:8080", "http://192.168.35.22:8080")
            .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
            .allowCredentials(true);
    }

	@Bean
	protected ThymeleafViewResolver thymeleafViewResolver(SpringTemplateEngine templateEngine) {
		ThymeleafViewResolver resolver = new ThymeleafViewResolver();
		resolver.setTemplateEngine(templateEngine);
		resolver.setCharacterEncoding("UTF-8");
		resolver.setOrder(1);
		return resolver;
	}
	
	@Bean
	protected ViewResolver JSPViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
		resolver.setOrder(0);
		return resolver;
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		String os = System.getProperty("os.name").toLowerCase();
		System.out.println("Detected OS : " + os);
		String currentUploadPath = "";
		
		if(os.contains("mac") || os.contains("darwin")) {
			currentUploadPath = macUploadBasePath;
		} else if(os.contains("win")) {
			currentUploadPath = windowUploadBasePath;
		}
		
		if(!currentUploadPath.endsWith(File.separator)) {
			currentUploadPath += File.separator;
		}
		
		registry.addResourceHandler("/upload/**")
				.addResourceLocations("file:///" + currentUploadPath);
		log.info("currentUploadPath  : {}", currentUploadPath);
		WebMvcConfigurer.super.addResourceHandlers(registry);
	}
}
