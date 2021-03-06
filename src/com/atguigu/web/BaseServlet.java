package com.atguigu.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public abstract class BaseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        //解决响应的中文乱码
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");

        try {
            //反射:获取action业务鉴别字符串,获取相应的业务 方法反射对象
            //UserServlet.class.getDeclaredMethod(action);
            Method method = this.getClass().getDeclaredMethod(action,HttpServletRequest.class,HttpServletResponse.class);

            //调用目标方法业务
            method.invoke(this,req,resp);
        } catch (Exception e) {
            e.printStackTrace();
            //把异常抛给Filter过滤器
            throw new RuntimeException(e);
        }
    }

}
