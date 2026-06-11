/**
 * Conecta Solidário – Unified API Service
 * Automaticamente escolhe entre API real e fake baseado na configuração
 * 
 * Uso:
 * 1. Incluir config.js primeiro
 * 2. Incluir api-unified.js
 * 3. Usar API.getCampanhas(), API.postVoluntario(), etc.
 */

const API = (() => {
  // ── Importar configuração ─────────────────────────────────────
  const isDemoMode = window.CONFIG?.MODO_APRESENTACAO === true;
  const baseUrl = window.CONFIG?.API_BASE_URL || '/api';
  const networkDelay = window.CONFIG?.DEMO?.NETWORK_DELAY || 300;
  
  // Verificar se logDebug está disponível
  if (window.logDebug) {
    window.logDebug(`Modo API: ${isDemoMode ? 'APRESENTAÇÃO (Fake)' : 'REAL (Backend)'}`);
    window.logDebug(`API Base URL: ${baseUrl}`);
  }

  // ── Função de requisição unificada ──────────────────────────
  async function request(method, endpoint, body = null) {
    // Simular delay de rede em modo de apresentação
    if (isDemoMode) {
      await new Promise(resolve => setTimeout(resolve, networkDelay));
    }

    const opts = {
      method,
      headers: { 'Content-Type': 'application/json' },
      credentials: 'include', // envia cookies de sessão
    };
    if (body) opts.body = JSON.stringify(body);
    
    try {
      if (isDemoMode) {
        // Usar Fake API em modo de apresentação
        return await fakeRequest(method, endpoint, body);
      } else {
        // Usar API real em modo de produção
        const res = await fetch(baseUrl + endpoint, opts);
        const data = await res.json().catch(() => ({}));
        if (!res.ok) throw { status: res.status, message: data.mensagem || 'Erro desconhecido' };
        return data;
      }
    } catch (err) {
      logDebug(`Erro na requisição ${method} ${endpoint}:`, err);
      throw err;
    }
  }

  // ── Fake API (usado apenas em modo de apresentação) ───────────
  async function fakeRequest(method, endpoint, body = null) {
    const url = endpoint.toLowerCase();
    
    // ── Campanhas ─────────────────────────────────────────────
    if (url.includes('/campanhas')) {
      if (method === 'GET') {
        if (url.includes('/campanhas/')) {
          // Buscar campanha específica
          const id = parseInt(url.split('/').pop());
          const campanha = fakeData.campanhas.find(c => c.id === id);
          if (!campanha) throw { status: 404, message: 'Campanha não encontrada' };
          return campanha;
        } else {
          // Listar todas as campanhas
          return fakeData.campanhas;
        }
      } else if (method === 'POST') {
        // Criar nova campanha
        const novaCampanha = {
          id: fakeData.campanhas.length + 1,
          ...body,
          status: 'ativa',
          criadoEm: new Date().toISOString()
        };
        fakeData.campanhas.push(novaCampanha);
        return { success: true, message: 'Campanha criada com sucesso', data: novaCampanha };
      } else if (method === 'PUT') {
        // Atualizar campanha
        const id = parseInt(url.split('/').pop());
        const index = fakeData.campanhas.findIndex(c => c.id === id);
        if (index === -1) throw { status: 404, message: 'Campanha não encontrada' };
        
        fakeData.campanhas[index] = { ...fakeData.campanhas[index], ...body };
        return { success: true, message: 'Campanha atualizada com sucesso', data: fakeData.campanhas[index] };
      } else if (method === 'DELETE') {
        // Deletar campanha
        const id = parseInt(url.split('/').pop());
        const index = fakeData.campanhas.findIndex(c => c.id === id);
        if (index === -1) throw { status: 404, message: 'Campanha não encontrada' };
        
        fakeData.campanhas.splice(index, 1);
        return { success: true, message: 'Campanha excluída com sucesso' };
      }
    }
    
    // ── Voluntários ───────────────────────────────────────────
    if (url.includes('/voluntarios')) {
      if (method === 'GET') {
        return fakeData.voluntarios;
      } else if (method === 'POST') {
        // Criar novo voluntário
        const novoVoluntario = {
          id: fakeData.voluntarios.length + 1,
          ...body,
          criadoEm: new Date().toISOString()
        };
        fakeData.voluntarios.push(novoVoluntario);
        return { success: true, message: 'Voluntário cadastrado com sucesso', data: novoVoluntario };
      }
    }
    
    // ── Auth ───────────────────────────────────────────────────
    if (url.includes('/login')) {
      if (method === 'POST') {
        const { email, senha } = body;
        if (email === CONFIG.DEMO.CREDENTIALS.email && senha === CONFIG.DEMO.CREDENTIALS.senha) {
          sessionStorage.setItem('cs_admin', JSON.stringify({
            id: 1,
            nome: "Administrador",
            email: email,
            role: "admin"
          }));
          return { success: true, message: "Login realizado com sucesso" };
        } else {
          return { success: false, message: "E-mail ou senha inválidos" };
        }
      }
    }
    
    if (url.includes('/logout')) {
      if (method === 'POST') {
        sessionStorage.removeItem('cs_admin');
        return { success: true, message: 'Logout realizado com sucesso' };
      }
    }
    
    // ── Erro Genérico ──────────────────────────────────────────
    throw { status: 404, message: 'Endpoint não encontrado' };
  }

  // ── Dados Fake (apenas usado em modo de apresentação) ───────
  const fakeData = {
    campanhas: [
      {
        id: 1,
        titulo: "Arrecadação de Alimentos para Comunidade Carente",
        descricao: "Ajude-nos a arrecadar alimentos não perecíveis para famílias em situação de vulnerabilidade social na região do ABC Paulista.",
        imagem: "https://picsum.photos/seed/food1/400/300.jpg",
        dataInicio: "2024-06-01",
        dataFim: "2024-06-30",
        meta: 5000,
        arrecadado: 3200,
        status: "ativa",
        categoria: "alimentos",
        criadoEm: "2024-05-15T10:00:00"
      },
      {
        id: 2,
        titulo: "Campanha de Agasalhos para o Inverno",
        descricao: "Doe agasalhos em bom estado para pessoas em situação de rua durante os meses de inverno.",
        imagem: "https://picsum.photos/seed/clothes1/400/300.jpg",
        dataInicio: "2024-07-01",
        dataFim: "2024-08-15",
        meta: 2000,
        arrecadado: 850,
        status: "ativa",
        categoria: "roupas",
        criadoEm: "2024-06-01T14:30:00"
      },
      {
        id: 3,
        titulo: "Kit de Higiene Pessoal",
        descricao: "Arrecadação de itens de higiene pessoal (sabonete, pasta de dente, escova, etc.) para distribuição em comunidades carentes.",
        imagem: "https://picsum.photos/seed/hygiene1/400/300.jpg",
        dataInicio: "2024-05-10",
        dataFim: "2024-05-25",
        meta: 1500,
        arrecadado: 1650,
        status: "encerrada",
        categoria: "higiene",
        criadoEm: "2024-05-01T09:15:00"
      },
      {
        id: 4,
        titulo: "Livros para Biblioteca Comunitária",
        descricao: "Doe livros infantis e adultos para montar uma biblioteca comunitária na Vila Maria.",
        imagem: "https://picsum.photos/seed/books1/400/300.jpg",
        dataInicio: "2024-08-01",
        dataFim: "2024-09-30",
        meta: 300,
        arrecadado: 45,
        status: "ativa",
        categoria: "educacao",
        criadoEm: "2024-07-15T11:20:00"
      },
      {
        id: 5,
        titulo: "Brinquedos para o Dia das Crianças",
        descricao: "Arrecadação de brinquedos novos ou em excelente estado para distribuição no Dia das Crianças.",
        imagem: "https://picsum.photos/seed/toys1/400/300.jpg",
        dataInicio: "2024-09-01",
        dataFim: "2024-10-10",
        meta: 1000,
        arrecadado: 0,
        status: "em_breve",
        categoria: "diversos",
        criadoEm: "2024-08-01T16:45:00"
      }
    ],
    
    voluntarios: [
      {
        id: 1,
        nome: "Ana Silva",
        email: "ana.silva@email.com",
        telefone: "(11) 9 1234-5678",
        interesse: "ambos",
        obs: "Disponível para ajudar nos finais de semana.",
        criadoEm: "2024-05-10T09:30:00"
      },
      {
        id: 2,
        nome: "Carlos Mendes",
        email: "carlos.mendes@email.com",
        telefone: "(11) 9 2345-6789",
        interesse: "arrecadacao",
        obs: "Tenho experiência em logística e transporte.",
        criadoEm: "2024-05-12T14:20:00"
      },
      {
        id: 3,
        nome: "Maria Oliveira",
        email: "maria.oliveira@email.com",
        telefone: "(11) 9 3456-7890",
        interesse: "distribuicao",
        obs: "Gosto de trabalhar diretamente com as pessoas.",
        criadoEm: "2024-05-15T10:45:00"
      },
      {
        id: 4,
        nome: "Pedro Santos",
        email: "pedro.santos@email.com",
        telefone: "(11) 9 4567-8901",
        interesse: "arrecadacao",
        obs: "",
        criadoEm: "2024-05-18T16:30:00"
      },
      {
        id: 5,
        nome: "Juliana Costa",
        email: "juliana.costa@email.com",
        telefone: "(11) 9 5678-9012",
        interesse: "ambos",
        obs: "Estudante de serviço social, quero contribuir com minha formação.",
        criadoEm: "2024-05-20T08:15:00"
      }
    ]
  };

  // ── Interface Pública ────────────────────────────────────────
  return {
    // ── Campanhas ─────────────────────────────────────────────
    getCampanhas:   ()      => request('GET',     '/campanhas.jsp'),
    getCampanha:    id      => request('GET',     `/campanha.jsp:id=${id}`),
    postCampanha:   dados   => request('POST',    '/campanhas.jsp', dados),
    putCampanha:    (id,d)  => request('PUT',     `/campanha.jsp?id=${id}`, d),
    deleteCampanha: id      => request('DELETE',  `/campanha.jsp?id=${id}`),
    // ── Voluntários ───────────────────────────────────────────
    getVoluntarios:  ()      => request('GET',    '/voluntarios.jsp'),
    postVoluntario:  dados   => request('POST',   '/voluntarios.jsp', dados),

    // ── Auth ───────────────────────────────────────────────────
    login:           creds   => request('POST',   '/login.jsp', creds),
    logout:          ()      => request('POST',   '/logout.jsp'),
  };
})();

// ─── Mantendo as funções utilitárias do arquivo original ───────
function toast(msg, type = 'default', dur = 3500) {
  const container = document.getElementById('toast-container');
  if (!container) return;
  const icons = { success: '✓', error: '✕', default: 'ℹ' };
  const el = document.createElement('div');
  el.className = `toast ${type}`;
  el.innerHTML = `<span>${icons[type]}</span><span>${msg}</span>`;
  container.appendChild(el);
  setTimeout(() => el.remove(), dur);
}

function formatDate(str) {
  if (!str) return '—';
  const d = new Date(str + 'T00:00:00');
  return d.toLocaleDateString('pt-BR');
}

function campaignStatus(inicio, fim) {
  const now = new Date(); now.setHours(0,0,0,0);
  const s = new Date(inicio + 'T00:00:00');
  const e = new Date(fim + 'T00:00:00');
  if (now < s) return { label: 'Em breve', cls: 'badge-orange' };
  if (now > e) return { label: 'Encerrada', cls: 'badge-red' };
  return { label: 'Ativa', cls: 'badge-green' };
}

function initNavbar() {
  const nav = document.querySelector('.navbar');
  if (!nav) return;
  window.addEventListener('scroll', () =>
    nav.classList.toggle('scrolled', window.scrollY > 20));

  // hamburger
  const btn = document.querySelector('.hamburger');
  const menu = document.querySelector('.mobile-menu');
  if (btn && menu) {
    btn.addEventListener('click', () => {
      btn.classList.toggle('open');
      menu.classList.toggle('open');
    });
    menu.querySelectorAll('a').forEach(a =>
      a.addEventListener('click', () => { btn.classList.remove('open'); menu.classList.remove('open'); }));
  }
}

function confirm(msg) {
  return window.confirm(msg);
}

function requireAuth() {
  const logged = sessionStorage.getItem('cs_admin');
  if (!logged) { window.location.href = '../pages/login.jsp'; return false; }
  return JSON.parse(logged);
}

function validateForm(formEl) {
  let valid = true;
  formEl.querySelectorAll('[data-required]').forEach(inp => {
    const err = inp.parentElement.querySelector('.form-error');
    if (!inp.value.trim()) {
      if (err) { err.textContent = 'Campo obrigatório.'; err.style.display = 'block'; }
      inp.style.borderColor = '#C0392B';
      valid = false;
    } else {
      if (err) err.style.display = 'none';
      inp.style.borderColor = '';
    }
  });
  // email
  formEl.querySelectorAll('[type=email]').forEach(inp => {
    const err = inp.parentElement.querySelector('.form-error');
    if (inp.value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(inp.value)) {
      if (err) { err.textContent = 'E-mail inválido.'; err.style.display = 'block'; }
      inp.style.borderColor = '#C0392B';
      valid = false;
    }
  });
  return valid;
}

document.addEventListener('DOMContentLoaded', initNavbar);