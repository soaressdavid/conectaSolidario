<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/conexao.jsp" %>
<%
String method = request.getMethod();

if ("GET".equals(method)) {
    try {
        String sql = "SELECT id_voluntario, nome, email, telefone, interesse, observacoes, data_cadastro " +
                     "FROM voluntario " +
                     "ORDER BY data_cadastro DESC";
    
        PreparedStatement ps = conexao.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        StringBuilder json = new StringBuilder("[");
        boolean primeiro = true;

        while (rs.next()) {
            if (!primeiro) json.append(",");
            json.append("{")
                .append("\"id\":").append(rs.getInt("id_voluntario")).append(",")
                .append("\"nome\":\"").append(rs.getString("nome")).append("\",")
                .append("\"email\":\"").append(rs.getString("email")).append("\",")
                .append("\"telefone\":\"").append(rs.getString("telefone")).append("\",")
                .append("\"interesse\":\"").append(rs.getString("interesse")).append("\",")
                .append("\"observacoes\":\"").append(rs.getString("observacoes")).append("\"")
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
        while ((line = request.getReader().readLine()) != null) {
            body.append(line);
        }
        String b = body.toString();

        String nome      =extrairValor(b, "nome");
        String email     =extrairValor(b, "email");
        String telefone  =extrairValor(b, "telefone");
        String interesse =extrairValor(b, "interesse");
        String obs       =extrairValor(b, "obs");

        String sql = "INSERT INTO voluntario (nome, email, telefone, interesse, observacoes, data_cadastro) " +
        "VALUES (?, ?, ?, ?, ?, CURDATE())";

        PreparedStatement ps = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, nome);
        ps.setString(2, email);
        ps.setString(3, telefone);
        ps.setString(4, interesse);
        ps.setString(5, obs);
        ps.executeUpdate();

        ResultSet keys = ps.getGeneratedKeys();
        int novoId = keys.next() ? keys.getInt(1) : 0;

        keys.close();
        ps.close();
        conexao.close();

        response.setStatus(201);
        out.print("{\"id\":" + novoId + ",\"mensagem\":\"Voluntário cadastrado com sucesso\"}");
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