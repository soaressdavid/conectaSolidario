<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/conexao.jsp" %>
<%
String method = request.getMethod();
int id = Integer.parseInt(request.getParameter("id"));

// PUT — atualiza campanha
if ("PUT".equals(method)) {
    try {
        StringBuilder body = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) body.append(line);
        String b = body.toString();

        String titulo    = extrairValor(b, "titulo");
        String descricao = extrairValor(b, "descricao");
        String status    = extrairValor(b, "status_campanha");

        String sql = "UPDATE campanha SET titulo=?, descricao=?, status_campanha=? WHERE id_campanha=?";
        PreparedStatement ps = conexao.prepareStatement(sql);
        ps.setString(1, titulo);
        ps.setString(2, descricao);
        ps.setString(3, status);
        ps.setInt(4, id);
        ps.executeUpdate();
        ps.close(); conexao.close();

        out.print("{\"mensagem\":\"Campanha atualizada com sucesso\"}");
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"erro\":\"" + e.getMessage() + "\"}");
    }
}

// DELETE — remove campanha
if ("DELETE".equals(method)) {
    try {
        PreparedStatement ps = conexao.prepareStatement("DELETE FROM campanha WHERE id_campanha=?");
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close(); conexao.close();

        out.print("{\"mensagem\":\"Campanha removida com sucesso\"}");
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"erro\":\"" + e.getMessage() + "\"}");
    }
}
%>
<%!
String extrairValor(String json, String chave) {
    String busca = "\"" + chave + "\"";
    int idx = json.indexOf(busca);
    if (idx < 0) return "";
    int colon = json.indexOf(":", idx) + 1;
    while (colon < json.length() && json.charAt(colon) == ' ') colon++;
    int inicio = colon + 1;
    int fim = json.indexOf("\"", inicio);
    return json.substring(inicio, fim);
}
%>