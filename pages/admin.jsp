<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Painel Admin – Conecta Solidário</title>
  <link rel="stylesheet" href="../css/base.css">
  <link rel="stylesheet" href="../css/components.css">
  <link rel="stylesheet" href="../css/layout.css">
  <link rel="stylesheet" href="../css/responsive.css">
  <link rel="stylesheet" href="../css/pages/admin.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-layout">

<!-- ── Sidebar ─────────────────────────────────────────────── -->
<aside class="sidebar" id="sidebar">
  <div class="sidebar-brand">
    <span class="brand-icon" style="width:32px;height:32px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:.9rem"><i class="fas fa-handshake"></i></span>
    Conecta Solidário
  </div>
  <nav class="sidebar-nav">
    <a href="#" class="active" data-page="dashboard">
      <span class="nav-icon"><i class="fas fa-chart-bar"></i></span> Dashboard
    </a>
    <a href="#" data-page="campanhas">
      <span class="nav-icon"><i class="fas fa-bullhorn"></i></span> Campanhas
    </a>
    <a href="#" data-page="voluntarios">
      <span class="nav-icon"><i class="fas fa-users"></i></span> Voluntários
    </a>
    <a href="../index.jsp" style="margin-top:auto">
      <span class="nav-icon"><i class="fas fa-globe"></i></span> Ver site
    </a>
  </nav>
  <div class="sidebar-footer">
    <button class="btn btn-ghost btn-sm btn-block" id="logout-btn" style="color:rgba(255,255,255,.7);border-color:rgba(255,255,255,.2)">
      Sair
    </button>
  </div>
</aside>

<!-- ── Main ────────────────────────────────────────────────── -->
<main class="admin-main">
  <header class="admin-topbar">
    <div style="display:flex;align-items:center;gap:12px">
      <button class="hamburger" id="sidebar-toggle" style="display:flex">
        <span></span><span></span><span></span>
      </button>
      <h2 id="page-title">Dashboard</h2>
    </div>
    <div class="admin-user">
      <span id="user-name">Admin</span>
      <div class="admin-avatar" id="user-avatar">A</div>
    </div>
  </header>

  <div class="admin-content">

    <!-- ── Dashboard ─────────────────────────────────────── -->
    <div class="admin-page active" id="page-dashboard">
      <div class="stat-grid">
        <div class="stat-card">
          <span class="stat-icon"><i class="fas fa-bullhorn"></i></span>
          <div class="stat-label">Total de Campanhas</div>
          <div class="stat-value" id="stat-total-camp">–</div>
        </div>
        <div class="stat-card">
          <span class="stat-icon"><i class="fas fa-check-circle"></i></span>
          <div class="stat-label">Campanhas Ativas</div>
          <div class="stat-value" id="stat-ativas">–</div>
        </div>
        <div class="stat-card">
          <span class="stat-icon"><i class="fas fa-users"></i></span>
          <div class="stat-label">Voluntários</div>
          <div class="stat-value" id="stat-vols">–</div>
        </div>
      </div>

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px">
        <div class="card" style="padding:24px">
          <h3 style="font-size:1rem;margin-bottom:16px">Campanhas recentes</h3>
          <div id="recent-campaigns" class="recent-list">
            <div class="loader-wrap" style="padding:24px"><div class="spinner"></div></div>
          </div>
        </div>
        <div class="card" style="padding:24px">
          <h3 style="font-size:1rem;margin-bottom:16px">Ações rápidas</h3>
          <div style="display:flex;flex-direction:column;gap:10px;margin-top:8px">
            <button class="btn btn-primary" onclick="gotoPage('campanhas');setTimeout(()=>openCampModal(),100)">
              + Nova campanha
            </button>
            <button class="btn btn-forest" onclick="gotoPage('voluntarios')">
              Ver voluntários
            </button>
            <a href="../index.jsp" class="btn btn-ghost" target="_blank">
              <i class="fas fa-globe"></i> Ver site público
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Campanhas ─────────────────────────────────────── -->
    <div class="admin-page" id="page-campanhas">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px">
        <div></div>
        <button class="btn btn-primary" onclick="openCampModal()">+ Nova campanha</button>
      </div>
      <div class="card" style="overflow:hidden;border-radius:var(--radius-l)">
        <div id="camp-table-wrap">
          <div class="loader-wrap"><div class="spinner"></div><p>Carregando…</p></div>
        </div>
      </div>
    </div>

    <!-- ── Voluntários ────────────────────────────────────── -->
    <div class="admin-page" id="page-voluntarios">
      <div class="search-bar">
        <div class="search-input-wrap">
          <span class="search-icon"><i class="fas fa-search"></i></span>
          <input type="text" class="form-control" id="vol-search" placeholder="Buscar por nome ou e-mail…">
        </div>
        <button class="btn btn-ghost btn-sm" onclick="exportCSV()"><i class="fas fa-download"></i> Exportar CSV</button>
      </div>
      <div class="card" style="overflow:hidden;border-radius:var(--radius-l)">
        <div id="vol-table-wrap">
          <div class="loader-wrap"><div class="spinner"></div><p>Carregando…</p></div>
        </div>
      </div>
    </div>

  </div><!-- /admin-content -->
</main>

<!-- ── Campaign Modal ───────────────────────────────────────── -->
<div class="modal-overlay" id="camp-modal">
  <div class="modal">
    <div class="modal-header">
      <h3 class="modal-title" id="modal-title">Nova Campanha</h3>
      <button class="modal-close" onclick="closeCampModal()"><i class="fas fa-times"></i></button>
    </div>
    <form id="camp-form">
      <input type="hidden" id="camp-id">
      <div class="form-group">
        <label class="form-label">Título <span>*</span></label>
        <input type="text" id="camp-titulo" class="form-control" data-required placeholder="Nome da campanha">
        <span class="form-error" style="display:none"></span>
      </div>
      <div class="form-group">
        <label class="form-label">Descrição <span>*</span></label>
        <textarea id="camp-desc" class="form-control" data-required rows="4" placeholder="Descreva o objetivo da campanha…"></textarea>
        <span class="form-error" style="display:none"></span>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Data de início <span>*</span></label>
          <input type="date" id="camp-inicio" class="form-control" data-required>
          <span class="form-error" style="display:none"></span>
        </div>
        <div class="form-group">
          <label class="form-label">Data de término <span>*</span></label>
          <input type="date" id="camp-fim" class="form-control" data-required>
          <span class="form-error" style="display:none"></span>
        </div>
      </div>
      <div style="display:flex;gap:12px;margin-top:8px">
        <button type="button" class="btn btn-ghost" style="flex:1" onclick="closeCampModal()">Cancelar</button>
        <button type="submit" class="btn btn-primary" style="flex:2" id="camp-submit-btn">Salvar campanha</button>
      </div>
    </form>
  </div>
</div>

<!-- ── Delete confirm modal ────────────────────────────────── -->
<div class="modal-overlay" id="del-modal">
  <div class="modal" style="max-width:400px;text-align:center">
    <div style="font-size:2.5rem;margin-bottom:16px"><i class="fas fa-trash"></i></div>
    <h3>Excluir campanha?</h3>
    <p style="margin:12px 0 28px">Esta ação não pode ser desfeita. A campanha será removida permanentemente.</p>
    <div style="display:flex;gap:12px">
      <button class="btn btn-ghost" style="flex:1" onclick="closeDelModal()">Cancelar</button>
      <button class="btn btn-danger" style="flex:1" id="confirm-del-btn">Excluir</button>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="../js/config.js"></script>
<script src="../js/api-unified.js"></script>
<script>
  // ── Auth check ───────────────────────────────────────────
  const admin = requireAuth();
  if (admin) {
    document.getElementById('user-name').textContent = admin.nome || admin.email || 'Admin';
    document.getElementById('user-avatar').textContent = (admin.nome || admin.email || 'A')[0].toUpperCase();
  }

  // ── Sidebar toggle (mobile) ──────────────────────────────
  document.getElementById('sidebar-toggle').addEventListener('click', () =>
    document.getElementById('sidebar').classList.toggle('open'));

  // ── Logout ───────────────────────────────────────────────
  document.getElementById('logout-btn').addEventListener('click', async () => {
    try { await API.logout(); } catch {}
    sessionStorage.removeItem('cs_admin');
    window.location.href = 'login.jsp';
  });

  // ── Page navigation ──────────────────────────────────────
  const titles = { dashboard:'Dashboard', campanhas:'Campanhas', voluntarios:'Voluntários' };

  function gotoPage(name) {
    document.querySelectorAll('.admin-page').forEach(p => p.classList.remove('active'));
    document.getElementById('page-' + name).classList.add('active');
    document.querySelectorAll('.sidebar-nav a').forEach(a => {
      a.classList.toggle('active', a.dataset.page === name);
    });
    document.getElementById('page-title').textContent = titles[name] || name;
    if (name === 'campanhas') loadCampanhas();
    if (name === 'voluntarios') loadVoluntarios();
  }

  document.querySelectorAll('.sidebar-nav a[data-page]').forEach(a => {
    a.addEventListener('click', e => { e.preventDefault(); gotoPage(a.dataset.page); });
  });

  // ─────────────────────────────────────────────────────────
  // ── CAMPANHAS ────────────────────────────────────────────
  // ─────────────────────────────────────────────────────────
  let campanhasData = [];

  async function loadCampanhas() {
    const wrap = document.getElementById('camp-table-wrap');
    wrap.innerHTML = '<div class="loader-wrap"><div class="spinner"></div><p>Carregando…</p></div>';
    try {
      const data = await API.getCampanhas();
      campanhasData = data || [];
    } catch { campanhasData = []; }
    renderCampTable(campanhasData);
    updateDashStats();
  }

  function renderCampTable(data) {
    const wrap = document.getElementById('camp-table-wrap');
    if (!data.length) {
      wrap.innerHTML = '<div class="empty-state"><div class="icon"><i class="fas fa-bullhorn"></i></div><h3>Nenhuma campanha cadastrada</h3><p>Crie a primeira campanha clicando em "+ Nova campanha".</p></div>';
      return;
    }
    wrap.innerHTML = `<div class="table-wrap"><table>
      <thead><tr>
        <th>Título</th><th>Início</th><th>Término</th><th>Status</th><th>Ações</th>
      </tr></thead>
      <tbody>${data.map(c => {
        const st = campaignStatus(c.data_inicio, c.data_fim);
        return `<tr>
          <td><strong>${c.titulo}</strong><br><small style="color:var(--text-s)">${c.descricao.substring(0,60)}…</small></td>
          <td>${formatDate(c.data_inicio)}</td>
          <td>${formatDate(c.data_fim)}</td>
          <td><span class="badge ${st.cls}">${st.label}</span></td>
          <td><div class="table-actions">
            <button class="btn btn-ghost btn-sm" onclick="editCamp(${c.id})"><i class="fas fa-edit"></i> Editar</button>
            <button class="btn btn-danger btn-sm" onclick="askDelete(${c.id})"><i class="fas fa-trash"></i></button>
          </div></td>
        </tr>`;
      }).join('')}</tbody>
    </table></div>`;
  }

  // Modal open/close
  function openCampModal(camp = null) {
    document.getElementById('modal-title').textContent = camp ? 'Editar Campanha' : 'Nova Campanha';
    document.getElementById('camp-submit-btn').textContent = camp ? 'Salvar alterações' : 'Salvar campanha';
    document.getElementById('camp-id').value    = camp ? camp.id : '';
    document.getElementById('camp-titulo').value = camp ? camp.titulo : '';
    document.getElementById('camp-desc').value   = camp ? camp.descricao : '';
    document.getElementById('camp-inicio').value  = camp ? camp.data_inicio : '';
    document.getElementById('camp-fim').value     = camp ? camp.data_fim : '';
    document.getElementById('camp-modal').classList.add('open');
  }
  function closeCampModal() { document.getElementById('camp-modal').classList.remove('open'); }

  function editCamp(id) {
    const c = campanhasData.find(x => x.id == id);
    if (c) openCampModal(c);
  }

  // Camp form submit
  document.getElementById('camp-form').addEventListener('submit', async e => {
    e.preventDefault();
    if (!validateForm(e.target)) return;

    const btn = document.getElementById('camp-submit-btn');
    btn.textContent = 'Salvando…'; btn.disabled = true;

    const id = document.getElementById('camp-id').value;
    const payload = {
      titulo:      document.getElementById('camp-titulo').value.trim(),
      descricao:   document.getElementById('camp-desc').value.trim(),
      data_inicio: document.getElementById('camp-inicio').value,
      data_fim:    document.getElementById('camp-fim').value,
    };

    // Validate dates
    if (payload.data_fim < payload.data_inicio) {
      toast('A data de término deve ser após o início.', 'error');
      btn.textContent = id ? 'Salvar alterações' : 'Salvar campanha'; btn.disabled = false;
      return;
    }

    try {
      if (id) {
        await API.putCampanha(id, payload);
        // update local
        const idx = campanhasData.findIndex(c => c.id == id);
        if (idx > -1) campanhasData[idx] = { ...campanhasData[idx], ...payload };
      } else {
        const res = await API.postCampanha(payload);
        campanhasData.push({ id: res.id || Date.now(), ...payload });
      }
    } catch {
      // Demo: atualiza localmente
      if (id) {
        const idx = campanhasData.findIndex(c => c.id == id);
        if (idx > -1) campanhasData[idx] = { ...campanhasData[idx], ...payload };
      } else {
        campanhasData.push({ id: Date.now(), ...payload });
      }
    }

    renderCampTable(campanhasData);
    updateDashStats();
    closeCampModal();
    toast(id ? 'Campanha atualizada!' : 'Campanha criada com sucesso!', 'success');
    btn.textContent = id ? 'Salvar alterações' : 'Salvar campanha'; btn.disabled = false;
  });

  // Delete
  let pendingDeleteId = null;
  function askDelete(id) { pendingDeleteId = id; document.getElementById('del-modal').classList.add('open'); }
  function closeDelModal() { pendingDeleteId = null; document.getElementById('del-modal').classList.remove('open'); }

  document.getElementById('confirm-del-btn').addEventListener('click', async () => {
    if (!pendingDeleteId) return;
    try { await API.deleteCampanha(pendingDeleteId); } catch {}
    campanhasData = campanhasData.filter(c => c.id != pendingDeleteId);
    renderCampTable(campanhasData);
    updateDashStats();
    closeDelModal();
    toast('Campanha removida.', 'success');
  });

  // Close modals on overlay click
  document.querySelectorAll('.modal-overlay').forEach(o =>
    o.addEventListener('click', e => { if (e.target === o) { closeCampModal(); closeDelModal(); } }));

  // ─────────────────────────────────────────────────────────
  // ── VOLUNTÁRIOS ──────────────────────────────────────────
  // ─────────────────────────────────────────────────────────
  let voluntariosData = [];

  async function loadVoluntarios() {
    const wrap = document.getElementById('vol-table-wrap');
    wrap.innerHTML = '<div class="loader-wrap"><div class="spinner"></div><p>Carregando…</p></div>';
    try {
      const data = await API.getVoluntarios();
      voluntariosData = data || [];
    } catch { voluntariosData = []; }
    renderVolTable(voluntariosData);
    updateDashStats();
  }

  function renderVolTable(data) {
    const wrap = document.getElementById('vol-table-wrap');
    if (!data.length) {
      wrap.innerHTML = '<div class="empty-state"><div class="icon"><i class="fas fa-users"></i></div><h3>Nenhum voluntário cadastrado</h3><p>Aguarde cadastros pelo site público.</p></div>';
      return;
    }
    wrap.innerHTML = `<div class="table-wrap"><table>
      <thead><tr><th>#</th><th>Nome</th><th>E-mail</th><th>Telefone</th></tr></thead>
      <tbody>${data.map((v,i) => `<tr>
        <td style="color:var(--text-s);font-size:.85rem">${i+1}</td>
        <td class="vol-name">${v.nome}</td>
        <td>${v.email}</td>
        <td>${v.telefone || '—'}</td>
      </tr>`).join('')}</tbody>
    </table></div>`;
  }

  // Search
  document.getElementById('vol-search').addEventListener('input', function() {
    const q = this.value.toLowerCase();
    const filtered = voluntariosData.filter(v =>
      v.nome.toLowerCase().includes(q) || v.email.toLowerCase().includes(q));
    renderVolTable(filtered);
  });

  // Export CSV
  function exportCSV() {
    if (!voluntariosData.length) { toast('Nenhum voluntário para exportar.', 'error'); return; }
    const rows = [['ID','Nome','E-mail','Telefone']];
    voluntariosData.forEach(v => rows.push([v.id, v.nome, v.email, v.telefone || '']));
    const csv = rows.map(r => r.map(c => `"${c}"`).join(',')).join('\n');
    const a = document.createElement('a');
    a.href = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
    a.download = 'voluntarios.csv';
    a.click();
  }

  // ── Dashboard stats ──────────────────────────────────────
  function updateDashStats() {
    const ativas = campanhasData.filter(c => campaignStatus(c.data_inicio, c.data_fim).label === 'Ativa').length;
    document.getElementById('stat-total-camp').textContent = campanhasData.length;
    document.getElementById('stat-ativas').textContent     = ativas;
    document.getElementById('stat-vols').textContent       = voluntariosData.length;

    // Recent
    const recent = [...campanhasData].slice(-4).reverse();
    const wrap = document.getElementById('recent-campaigns');
    if (!recent.length) { wrap.innerHTML = '<p style="color:var(--text-s);font-size:.88rem">Nenhuma campanha ainda.</p>'; return; }
    wrap.innerHTML = recent.map(c => {
      const st = campaignStatus(c.data_inicio, c.data_fim);
      return `<div class="recent-item">
        <div class="recent-icon"><i class="fas fa-bullhorn"></i></div>
        <div class="recent-info">
          <strong>${c.titulo}</strong>
          <span>${formatDate(c.data_inicio)} → ${formatDate(c.data_fim)}</span>
        </div>
        <span class="badge ${st.cls}" style="font-size:.72rem">${st.label}</span>
      </div>`;
    }).join('');
  }

  // ── Init ─────────────────────────────────────────────────
  async function init() {
    await Promise.all([loadCampanhas(), loadVoluntarios()]);
  }
  init();
</script>
</body>
</html>
