package com.zero.waste;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.descriptor.JspConfigDescriptor;
import javax.servlet.descriptor.JspPropertyGroupDescriptor;
import javax.servlet.descriptor.TaglibDescriptor;

import org.apache.catalina.Context;
import org.apache.tomcat.util.descriptor.web.JspConfigDescriptorImpl;
import org.apache.tomcat.util.descriptor.web.JspPropertyGroup;
import org.apache.tomcat.util.descriptor.web.JspPropertyGroupDescriptorImpl;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class JspConfig extends SpringBootServletInitializer {
	@Bean
	public ConfigurableServletWebServerFactory configurableServletWebServerFactory() {
		return new TomcatServletWebServerFactory() {
			@Override
			protected void postProcessContext(Context context) {
				super.postProcessContext(context);

				JspPropertyGroup jspPropertyGroup = new JspPropertyGroup();
				
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/index.jsp");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/admin/*");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/activity/*");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/map/*");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/tree/tree.jsp");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/board/*");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/user/editForm.jsp");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/user/mypage.jsp");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/user/joinForm.jsp");
				jspPropertyGroup.addUrlPattern("/WEB-INF/views/user/editForm.jsp");
				jspPropertyGroup.setPageEncoding("UTF-8");
				jspPropertyGroup.setScriptingInvalid("false");
				jspPropertyGroup.addIncludePrelude("/WEB-INF/views/inc/header.jspf");
				//jspPropertyGroup.addIncludeCoda("/WEB-INF/views/inc/footer.jspf");
				jspPropertyGroup.setTrimWhitespace("true");
				jspPropertyGroup.setDefaultContentType("text/html");
				JspPropertyGroupDescriptorImpl jspPropertyGroupDescriptor = new JspPropertyGroupDescriptorImpl(
						jspPropertyGroup);
			
;

				context.setJspConfigDescriptor(new JspConfigDescriptorImpl(Collections.singletonList(jspPropertyGroupDescriptor), Collections.emptyList()));


			}
		};
	}
}
