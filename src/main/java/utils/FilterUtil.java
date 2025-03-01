package utils;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class FilterUtil implements Filter {
	
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList(
            ".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".ico", ".html"
        );
	
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
    	
        HttpServletRequest request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");
		
		request.getSession().setMaxInactiveInterval(1800);
		
        if (request.getSession().getAttribute("csrfToken") == null) {
            String token = UUID.randomUUID().toString();
            request.getSession().setAttribute("csrfToken", token);
        }
        //Allow
        if (request.getRequestURI().equals("/") || request.getRequestURI().startsWith("/game/")) {
            chain.doFilter(request, response);
            return;
        }
        if (isStaticResource(request.getRequestURI())) {
            chain.doFilter(request, response);
            return;
        }
        //Deny
        if (!request.getRequestURI().endsWith(".do")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "허용되지 않은 요청입니다.");
            return;
        }
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String contentType = request.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("multipart/form-data")) {
                String sessionToken = (String) request.getSession().getAttribute("csrfToken");
                String requestToken = request.getParameter("csrfToken");
                
                if (sessionToken == null || !sessionToken.equals(requestToken)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "잘못된 토큰 요청입니다.");
                    return;
                }
            }
        }
        chain.doFilter(request, response);
    }
    private boolean isStaticResource(String uri) {
        return ALLOWED_EXTENSIONS.stream().anyMatch(uri::endsWith);
    }

    @Override
    public void destroy() {
    }
}