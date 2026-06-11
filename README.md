# Conecta Solidário – Sistema Web Java/JSP
 
## 🎯 Visão Geral
 
Sistema web para gestão de uma ONG, desenvolvido com **Java JSP** no backend e **HTML/CSS/JavaScript** no frontend, rodando no servidor **Apache Tomcat 8.5**.
 
O sistema suporta dois modos de operação:
- **Modo de Apresentação** (`MODO_APRESENTACAO: true`): usa dados fake para demonstrações, sem precisar do banco
- **Modo Real** (`MODO_APRESENTACAO: false`): conecta ao banco MySQL real
---
 
## 🗂️ Estrutura do Projeto
 
```
conectaSolidario/
├── api/                        ← Backend JSP (rotas da API)
│   ├── campanhas.jsp           ← GET (listar) e POST (criar) campanhas
│   ├── campanha.jsp            ← PUT (editar) e DELETE (remover) por id
│   ├── voluntarios.jsp         ← GET (listar) e POST (cadastrar) voluntários
│   ├── login.jsp               ← POST autenticação do admin
│   └── logout.jsp              ← POST encerra sessão
├── includes/
│   └── conexao.jsp             ← Conexão com o banco MySQL (sem contentType)
├── pages/
│   ├── admin.jsp               ← Dashboard do administrador
│   ├── campanhas.jsp           ← Página pública de campanhas
│   ├── voluntario.jsp          ← Formulário de cadastro de voluntário
│   └── login.jsp               ← Página de login do admin
├── js/
│   ├── config.js               ← Configuração central (modo, URL da API)
│   ├── api-unified.js          ← Camada de API (real ou fake, automático)
│   ├── api.js                  ← API original (referência)
│   └── fake-api.js             ← Dados fake para apresentação
├── css/                        ← Estilos do sistema
├── WEB-INF/
│   └── lib/
│       └── mysql-connector-j-9.7.0.jar  ← Driver JDBC do MySQL
└── index.jsp                   ← Página inicial pública
```
 
---
 
## ⚙️ Requisitos
 
- **Java JDK 11+** (testado com JDK 21)
- **Apache Tomcat 8.5** (incluído no XAMPP)
- **MySQL 8.0** (via MySQL Workbench ou XAMPP)
- Banco de dados: `projeto_ong`
---
 
## 🚀 Como Rodar
 
### 1. Configure o banco de dados
 
Execute o script SQL para criar o banco:
 
```sql
CREATE DATABASE projeto_ong;
USE projeto_ong;
-- (execute o schema completo do arquivo schema.sql)
```
 
Credenciais padrão já cadastradas:
- **Email:** `admin@ong.com`
- **Senha:** `123456`
### 2. Configure a conexão
 
Abra `includes/conexao.jsp` e ajuste se necessário:
 
```java
String url = "jdbc:mysql://localhost:3306/projeto_ong?useSSL=false&serverTimezone=America/Sao_Paulo";
String usuario = "root";
String senha = "admin";
```
 
> ⚠️ O `conexao.jsp` **não deve ter** a diretiva `contentType` no topo — apenas `<%@ page import="java.sql.*" %>`. Isso evita conflito com os arquivos de API que definem seu próprio `contentType=application/json`.
 
### 3. Copie o projeto para o Tomcat
 
```
C:\xampp\tomcat\webapps\conectaSolidario\
```
 
### 4. Inicie o Tomcat
 
```bash
cd C:\xampp\tomcat\bin
startup.bat
```
 
Aguarde a mensagem:
```
Server startup in X ms
```
 
### 5. Acesse no navegador
 
```
http://localhost:8080/conectaSolidario/index.jsp
```
 
---
 
## 🔧 Configuração de Modo
 
### `js/config.js`
 
```javascript
const CONFIG = {
  MODO_APRESENTACAO: false,              // false = banco real, true = dados fake
  API_BASE_URL: '/conectaSolidario/api', // prefixo de todas as chamadas de API
  DEMO: {
    CREDENTIALS: {
      email: 'admin@conectasolidario.com.br',
      senha: 'admin123'
    },
    NETWORK_DELAY: 300,
    SHOW_DEBUG: true
  }
};
```
 
> ⚠️ `API_BASE_URL` deve incluir o nome do projeto (`/conectaSolidario/api`) para que as chamadas cheguem ao Tomcat corretamente.
 
---
 
## 🔗 Rotas da API
 
Todas as rotas ficam em `/conectaSolidario/api/`:
 
| Método | Rota                      | Ação                        |
|--------|---------------------------|-----------------------------|
| GET    | `/campanhas.jsp`          | Lista todas as campanhas    |
| POST   | `/campanhas.jsp`          | Cria nova campanha          |
| PUT    | `/campanha.jsp?id=X`      | Atualiza campanha por id    |
| DELETE | `/campanha.jsp?id=X`      | Remove campanha por id      |
| GET    | `/voluntarios.jsp`        | Lista todos os voluntários  |
| POST   | `/voluntarios.jsp`        | Cadastra novo voluntário    |
| POST   | `/login.jsp`              | Autentica admin             |
| POST   | `/logout.jsp`             | Encerra sessão              |
 
As rotas são chamadas automaticamente pelo `api-unified.js`:
 
```javascript
getCampanhas:   ()      => request('GET',    '/campanhas.jsp'),
getCampanha:    id      => request('GET',    `/campanha.jsp?id=${id}`),
postCampanha:   dados   => request('POST',   '/campanhas.jsp', dados),
putCampanha:    (id,d)  => request('PUT',    `/campanha.jsp?id=${id}`, d),
deleteCampanha: id      => request('DELETE', `/campanha.jsp?id=${id}`),
getVoluntarios: ()      => request('GET',    '/voluntarios.jsp'),
postVoluntario: dados   => request('POST',   '/voluntarios.jsp', dados),
login:          creds   => request('POST',   '/login.jsp', creds),
logout:         ()      => request('POST',   '/logout.jsp'),
```
 
---
 
## 📄 Páginas JSP — Regra Importante
 
Todos os arquivos `.jsp` que contêm JavaScript com template literals (`${}`) **devem** ter `isELIgnored="true"` na primeira linha, para evitar que o Tomcat interprete o `${}` do JavaScript como Expression Language Java:
 
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
```
 
Arquivos que precisam dessa configuração:
- `index.jsp` ✅
- `pages/admin.jsp` ✅
- `pages/campanhas.jsp` ✅
- `pages/voluntario.jsp` ✅
- `pages/login.jsp` — verificar se usa `${}`
---
 
## 🗃️ Banco de Dados
 
**Nome do banco:** `projeto_ong`
 
Tabelas principais:
 
| Tabela               | Descrição                              |
|----------------------|----------------------------------------|
| `ong`                | Dados da organização                   |
| `admin`              | Usuários administradores               |
| `campanha`           | Campanhas da ONG                       |
| `categoria_campanha` | Categorias das campanhas               |
| `voluntario`         | Voluntários cadastrados                |
| `participacao_campanha` | Relação voluntário ↔ campanha       |
| `doador`             | Doadores                               |
| `doacao`             | Doações realizadas                     |
| `beneficiario`       | Beneficiários atendidos                |
 
---
 
## 🛠️ Resolução de Problemas Comuns
 
**Erro 500 — `contentType` duplicado**
> O `conexao.jsp` não pode ter `contentType` definido. Remova a linha `<%@ page ... contentType=... %>` dele.
 
**Erro 500 — `Failed to parse expression ${...}`**
> Adicione `isELIgnored="true"` na diretiva `<%@ page %>` do arquivo JSP afetado.
 
**Erro 404 — arquivo JSP não encontrado**
> Verifique se o arquivo está em `C:\xampp\tomcat\webapps\conectaSolidario\`. Editar na pasta do projeto Git não reflete no Tomcat automaticamente.
 
**Erro de variável duplicada (`senha`, `url`)**
> O `conexao.jsp` já declara variáveis `senha`, `url` e `usuario`. Nos arquivos de API que fazem login, use nomes diferentes como `senhaAdmin` e `emailAdmin`.
 
**Tomcat não atualiza após edição**
> Pare o Tomcat, apague a pasta `C:\xampp\tomcat\work\Catalina\localhost\conectaSolidario` e reinicie.
 
**Campanhas aparecem como "Encerradas" mesmo sendo "Ativa" no banco**
> O frontend calcula o status pelas datas (`data_inicio` e `data_fim`). Se a `data_fim` já passou, aparece como encerrada independente do campo `status_campanha`.