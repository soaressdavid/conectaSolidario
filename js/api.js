/**
 * Conecta Solidário – API Service Layer
 * Todas as chamadas ao backend JSP passam por aqui.
 * Troque BASE_URL para o endereço real do servidor.
 */

const API = (() => {
  const BASE_URL = '/api'; // Altere para a URL do backend JSP

  async function request(method, endpoint, body = null) {
    const opts = {
      method,
      headers: { 'Content-Type': 'application/json' },
      credentials: 'include', // envia cookies de sessão
    };
    if (body) opts.body = JSON.stringify(body);
    try {
      const res = await fetch(BASE_URL + endpoint, opts);
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw { status: res.status, message: data.mensagem || 'Erro desconhecido' };
      return data;
    } catch (err) {
      throw err;
    }
  }

  return {
    // ── Campanhas ──────────────────────────────────────────
    getCampanhas:    ()      => request('GET',    '/campanhas'),
    getCampanha:     id      => request('GET',    `/campanhas/${id}`),
    postCampanha:    dados   => request('POST',   '/campanhas', dados),
    putCampanha:     (id,d)  => request('PUT',    `/campanhas/${id}`, d),
    deleteCampanha:  id      => request('DELETE', `/campanhas/${id}`),

    // ── Voluntários ────────────────────────────────────────
    getVoluntarios:  ()      => request('GET',    '/voluntarios'),
    postVoluntario:  dados   => request('POST',   '/voluntarios', dados),

    // ── Auth ───────────────────────────────────────────────
    login:           creds   => request('POST',   '/login', creds),
    logout:          ()      => request('POST',   '/logout'),
  };
})();

// ─── Toast ──────────────────────────────────────────────────
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

// ─── Date helpers ────────────────────────────────────────────
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

// ─── Scroll & Nav utils ──────────────────────────────────────
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

// ─── Confirm dialog ──────────────────────────────────────────
function confirm(msg) {
  return window.confirm(msg);
}

// ─── Session check (admin pages) ────────────────────────────
function requireAuth() {
  const logged = sessionStorage.getItem('cs_admin');
  if (!logged) { window.location.href = '../pages/login.html'; return false; }
  return JSON.parse(logged);
}

// ─── Form validation ─────────────────────────────────────────
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
