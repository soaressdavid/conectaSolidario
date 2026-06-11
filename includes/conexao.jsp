
<%@ page import="java.sql.*" %>

<%

String url = "jdbc:mysql://localhost:3306/projeto_ong?useSSL=false&serverTimezone=America/Sao_Paulo";
String usuario = "root";
String senha = "admin";

Connection conexao = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conexao = DriverManager.getConnection(url, usuario, senha);
} catch (Exception e) {
    out.println("Erro ao conectar: " + e.getMessage());
}
%>