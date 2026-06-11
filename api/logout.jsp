<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%
session.invalidate();
out.print("{\"mensagem\":\"Logout realizado com sucesso\"}");
%>