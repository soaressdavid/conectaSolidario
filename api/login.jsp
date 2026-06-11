<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/conexao.jsp" %>
<%
String method = request.getMethod();

if ("POST".equals(method)) {
    try {
        StringBuilder body = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            body.append(line);
        }
        String b = body.toString();
        out.print("BODY RECEBIDO: [" + b + "]"); 

        String emailAdmin = extrairValor(b, "email");
        String senhaAdmin = extrairValor(b, "senha");

        String sql = "SELECT a.id_admin, a.nome, a.email, o.nome AS nome_ong " +
                     "FROM admin a " +
                     "JOIN ong o ON a.id_ong = o.id_ong " +
                    "WHERE a.email = ? AND a.senha = ?";

        PreparedStatement ps = conexao.prepareStatement(sql);
        ps.setString(1, emailAdmin);
        ps.setString(2, senhaAdmin);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("admin_id", rs.getInt("id_admin"));
            session.setAttribute("admin_nome", rs.getString("nome"));

            out.print("{" +
                "\"id\":" + rs.getInt("id_admin") + "," +
                "\"nome\":\"" + rs.getString("nome") + "\"," +
                "\"email\":\"" + rs.getString("email") + "\"," +
                "\"ong\":\"" + rs.getString("nome_ong") + "\"" +
            "}");
        } else {
            response.setStatus(401);
            out.print("{\"mensagem\": \"E-mail ou senha incorretos\"}");
        }

        rs.close();
        ps.close();
        conexao.close();

    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"erro\":\"" +  e.getMessage() + "\"}");

    }
}
%>

<%!
String extrairValor(String json, String chave) {
    String busca = "\"" + chave + "\"";
    int idx = json.indexOf(busca);
    if (idx< 0) return "";
    int colon = json.indexOf(":", idx) + 1;
    while (colon < json.length() && json.charAt(colon) == ' ') colon++;
    int inicio = colon + 1;
    int fim = json.indexOf("\"", inicio);
    return json.substring(inicio, fim);
}


%>

