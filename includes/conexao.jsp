<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ITF-8" %>
<%@ page import="java.sql.*"

<%
String url = "jdbc:mysql//localhost:3306/nome_do_seu_banco";
String usuario = "root";
String senha = "admin";

Connection conexao = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conewxao = DriverManager.getConnection(url, usuario, senha);
} catch (Exception e) {
    out.println("Erro ao onectar: " + e.getMessage());
}
%>