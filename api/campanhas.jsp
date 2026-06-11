<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>

<%@ page import="java.sql.*" %>
<%@ include file="../includes/conexao.jsp" %>

<%
String method = request.getMethod();

if ("GET".equals(method)) {
    try {
        String sql = "SELECT c.id_campanha, c.titulo, c.descricao, " +
                     "c.data_inicio, c.data_fim, c.status_campanha, " +
                     "cat.nome_categoria " +
                     "FROM campanha c " +
                     "JOIN categoria_campanha cat ON c.id_categoria = cat.id_categoria " +
                     "ORDER BY c.data_inicio  DESC";
        
        PreparedStatement ps = conexao.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        StringBuilder json = new StringBuilder("[");
        boolean primeiro = true;

        while (rs.next()) {
            if (!primeiro) json.append(",");
            json.append("{")
                .append("\"id\":").append(rs.getInt("id_campanha")).append(",")
                .append("\"titulo\":\"").append(rs.getString("titulo")).append("\",")
                .append("\"descricao\":\"").append(rs.getString("descricao")).append("\",")
                .append("\"data_inicio\":\"").append(rs.getString("data_inicio")).append("\",")
                .append("\"data_fim\":\"").append(rs.getString("data_fim")).append("\",")
                .append("\"status_campanha\":\"").append(rs.getString("status_campanha")).append("\",")
                .append("\"categoria\":\"").append(rs.getString("nome_categoria")).append("\"")
                .append("}");
            primeiro = false;
        }
        json.append("]");

        rs.close();
        ps.close();
        conexao.close();
        out.print(json.toString());
    
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"erro\":\"" + e.getMessage() + "\"}");
    }
}



if ("POST".equals(method)) {
    try {
        StringBuilder body = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) body.append(line);
        String b = body.toString();

        String titulo      = extrairValor(b, "titulo");
        String descricao   = extrairValor(b, "descricao");
        String data_inicio = extrairValor(b, "data_inicio");
        String data_fim    = extrairValor(b, "data_fim");
        String idCategoria = extrairValor(b, "id_categoria");

        String sql = "INSERT INTO campanha (id_ong, id_categoria, titulo, descricao, data_inicio, data_fim, valor_arrecadado, status_campanha) " +
                     "VALUES (1, ?, ?, ?, ?, ?, 0, 'Ativa')";

        PreparedStatement ps = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, Integer.parseInt(idCategoria.isEmpty() ? "1" : idCategoria));
        ps.setString(2, titulo);
        ps.setString(3, descricao);
        ps.setString(4, data_inicio);
        ps.setString(5, data_fim.isEmpty() ? null : data_fim);
        ps.executeUpdate();

        ResultSet keys = ps.getGeneratedKeys();
        int novoId = keys.next() ? keys.getInt(1) : 0;
        keys.close(); ps.close(); conexao.close();

        response.setStatus(201);
        out.print("{\"id\":" + novoId + ",\"mensagem\":\"Campanha criada com sucesso\"}");

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