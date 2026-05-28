# Conecta Solidário - Sistema de Modos

## 🎯 Visão Geral

O sistema agora suporta dois modos de operação:
- **Modo de Apresentação**: Usa dados fake para demonstrações
- **Modo Real**: Conecta ao backend real

## 📁 Arquivos Criados

### 1. `config.js` - Configuração Central
```javascript
const CONFIG = {
  // true: Usa dados fake para apresentação
  // false: Usa API real do backend
  MODO_APRESENTACAO: true,
  
  // URL da API real (usado quando MODO_APRESENTACAO = false)
  API_BASE_URL: '/api',
  
  // Configurações de apresentação
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

### 2. `api-unified.js` - API Unificada
- Automaticamente escolhe entre API real e fake baseado na configuração
- Mantém a mesma interface que o api.js original
- Inclui todos os dados fake necessários para apresentação

### 3. `fake-api.js` - API Fake (Backup)
- Versão independente da API fake
- Pode ser usada diretamente se necessário

## 🚀 Como Usar

### Para Apresentações
1. **Ativar modo de apresentação**:
   ```javascript
   // No config.js, defina:
   MODO_APRESENTACAO: true
   ```

2. **Carregar os scripts na ordem correta**:
   ```html
   <script src="js/config.js"></script>
   <script src="js/api-unified.js"></script>
   ```

3. **Dados de teste para login**:
   - Email: `admin@conectasolidario.com.br`
   - Senha: `admin123`

### Para Produção
1. **Ativar modo real**:
   ```javascript
   // No config.js, defina:
   MODO_APRESENTACAO: false
   ```

2. **Configurar URL da API real**:
   ```javascript
   API_BASE_URL: 'https://seu-backend.com/api'
   ```

3. **Mesmo carregamento de scripts**:
   ```html
   <script src="js/config.js"></script>
   <script src="js/api-unified.js"></script>
   ```

## 📊 Dados Disponíveis no Modo de Apresentação

### Campanhas (5 exemplos)
- Arrecadação de Alimentos
- Campanha de Agasalhos
- Kit de Higiene Pessoal
- Livros para Biblioteca
- Brinquedos para Dia das Crianças

### Voluntários (5 exemplos)
- Ana Silva
- Carlos Mendes
- Maria Oliveira
- Pedro Santos
- Juliana Costa

## 🔧 Funcionalidades

### Recursos do Modo de Apresentação
- ✅ Dados realistas em português
- ✅ Simulação de latência de rede (300ms)
- ✅ Mensagens de debug no console
- ✅ CRUD completo para campanhas e voluntários
- ✅ Sistema de autenticação funcional

### Recursos do Modo Real
- ✅ Conexão real com backend
- ✅ Envio de dados reais
- ✅ Recebimento de dados reais
- ✅ Mesma interface que o modo de apresentação

## 📝 Arquivos Atualizados

Todos os arquivos HTML foram atualizados para usar o novo sistema:
- `index.html`
- `voluntario.html`
- `campanhas.html`
- `admin.html`
- `login.html`

## 🎮 Como Testar

1. **Modo Apresentação** (padrão):
   - Abra qualquer página
   - Use as credenciais de teste
   - Veja os dados fake carregados
   - Console mostra mensagens de debug

2. **Modo Real**:
   - Altere `MODO_APRESENTACAO: false` em config.js
   - Configure `API_BASE_URL` corretamente
   - Teste com backend real

## 💡 Dicas

- O sistema é 100% compatível com o código existente
- Não é necessário alterar nenhuma chamada de API nos arquivos HTML
- O modo de apresentação é perfeito para demos e desenvolvimento offline
- O modo real é ideal para produção e testes com backend real

## 🚨 Importante

- Sempre mantenha o `config.js` como primeiro script
- O `api-unified.js` depende do `config.js`
- Não remova o arquivo `api.js` original (ainda pode ser útil como referência)