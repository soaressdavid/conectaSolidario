/**
 * Conecta Solidário – Configuration
 * Define o modo de operação do sistema
 */

const CONFIG = {
  // MODO DE OPERAÇÃO
  // true: Usa dados fake para apresentação
  // false: Usa API real do backend
  MODO_APRESENTACAO: true,
  
  // URL DA API REAL (usado quando MODO_APRESENTACAO = false)
  API_BASE_URL: '/api',
  
  // CONFIGURAÇÕES DE APRESENTAÇÃO
  DEMO: {
    // Dados de teste para login
    CREDENTIALS: {
      email: 'admin@conectasolidario.com.br',
      senha: 'admin123'
    },
    
    // Delay artificial para simular rede lenta
    NETWORK_DELAY: 300,
    
    // Mostrar mensagens de debug
    SHOW_DEBUG: true
  }
};

// ─── Funções utilitárias ───────────────────────────────────────
function logDebug(message) {
  if (CONFIG.DEMO.SHOW_DEBUG) {
    console.log(`[DEBUG] ${message}`);
  }
}

function isModoApresentacao() {
  return CONFIG.MODO_APRESENTACAO;
}

function getApiBaseUrl() {
  return CONFIG.API_BASE_URL;
}

// ─── Exportar configuração ───────────────────────────────────
window.CONFIG = CONFIG;
window.isModoApresentacao = isModoApresentacao;
window.getApiBaseUrl = getApiBaseUrl;
window.logDebug = logDebug;