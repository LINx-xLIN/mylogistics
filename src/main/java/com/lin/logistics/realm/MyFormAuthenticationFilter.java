package com.lin.logistics.realm;

import com.lin.logistics.pojo.User;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class MyFormAuthenticationFilter extends FormAuthenticationFilter {

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {

        Subject subject = getSubject(request, response);

        Session session = subject.getSession();

        if(!subject.isAuthenticated()&&subject.isRemembered()){
            User principal = (User)subject.getPrincipal();
            session.setAttribute("principal",principal);

        }


        return subject.isAuthenticated()||subject.isRemembered();
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        HttpServletRequest req = (HttpServletRequest) request;
        String verifyCode = req.getParameter("verifyCode");

        String rand = (String) req.getSession().getAttribute("rand");

        if(StringUtils.isNotBlank((verifyCode))&&StringUtils.isNotBlank((rand))){

            /*verifyCode = verifyCode.toLowerCase();
            rand = rand.toLowerCase();*/

            if(!verifyCode.equalsIgnoreCase(rand)){
                req.setAttribute("errorMsg","亲，验证码错误");

                req.getRequestDispatcher("/login.jsp").forward(req,response);

                return false;
            }

        }

        return super.onAccessDenied(request, response, mappedValue);
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {


        WebUtils.getAndClearSavedRequest(request);

        return super.onLoginSuccess(token, subject, request, response);
    }
}
