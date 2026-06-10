<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Conecta Solidário – Campanhas sociais para quem mais precisa</title>
  <link rel="stylesheet" href="css/base.css">
  <link rel="stylesheet" href="css/components.css">
  <link rel="stylesheet" href="css/layout.css">
  <link rel="stylesheet" href="css/responsive.css">
  <link rel="stylesheet" href="css/pages/index.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<!-- ── Navbar ──────────────────────────────────────────────── -->
<nav class="navbar">
  <div class="container navbar-inner">
    <a href="index.jsp" class="navbar-brand">
      <span class="brand-icon">
        <i class="fas fa-handshake"></i>
      </span>
      Conecta Solidário
    </a>
    <ul class="navbar-nav">
      <li><a href="index.jsp" class="active">Início</a></li>
      <li><a href="#sobre">Sobre</a></li>
      <li><a href="#campanhas">Campanhas</a></li>
      <li><a href="pages/voluntario.jsp">Seja Voluntário</a></li>
      <li><a href="#contato">Contato</a></li>
    </ul>
    <div class="navbar-actions">
      <a href="pages/voluntario.jsp" class="btn btn-primary btn-sm">Quero Ajudar</a>
    </div>
    <button class="hamburger" aria-label="Menu">
      <span></span><span></span><span></span>
    </button>
  </div>
</nav>

<!-- Mobile menu -->
<div class="mobile-menu">
  <a href="index.jsp">Início</a>
  <a href="#sobre">Sobre</a>
  <a href="#campanhas">Campanhas</a>
  <a href="pages/voluntario.jsp">Seja Voluntário</a>
  <a href="#contato">Contato</a>
  <a href="pages/login.jsp">Área Admin</a>
  <a href="pages/voluntario.jsp" class="btn btn-primary" style="margin-top:8px">Quero Ajudar</a>
</div>

<!-- ── Hero ────────────────────────────────────────────────── -->
<section class="hero" id="inicio">
  <div class="container" style="position:relative;z-index:2">
    <div class="hero-content">
      <div class="hero-eyebrow">São Paulo</div>
      <h1>Ajudar quem precisa nunca foi tão simples</h1>
      <p class="hero-desc">
        Encontre campanhas de arrecadação e ações voluntárias na sua cidade. Cadastre-se e
        receba informações sobre como participar.
      </p>
      <div class="hero-cta">
        <a href="#campanhas" class="btn btn-primary btn-lg">Ver Campanhas</a>
        <a href="pages/voluntario.jsp" class="btn btn-outline btn-lg" style="border-color:rgba(255,255,255,.5);color:#fff">Quero Ajudar</a>
      </div>
      <div class="hero-stats">
        <div class="hero-stat" id="stat-campanhas">
          <strong>–</strong><span>Campanhas</span>
        </div>
        <div class="hero-stat" id="stat-voluntarios">
          <strong>–</strong><span>Voluntários</span>
        </div>
        <div class="hero-stat">
          <strong>SP</strong><span>São Paulo</span>
        </div>
      </div>
    </div>
  </div>
  <div class="hero-illustration">
    <div class="hero-icon-center">
      <div class="big-icon">
        <i class="fas fa-handshake"></i>
      </div>
    </div>
  </div>
</section>

<!-- ── Sobre ────────────────────────────────────────────────── -->
<section class="about-strip" id="sobre">
  <div class="container">
    <div class="about-strip-inner">
      <div>
        <div class="section-label" style="color:rgba(255,255,255,.7)">Quem somos</div>
        <h2>Inspirados pela SP Invisível, movidos pela empatia</h2>
        <p style="margin-top:16px">
          O Conecta Solidário nasceu da vontade de dar mais visibilidade a ações sociais voltadas
          para pessoas em situação de rua. Em São Paulo, milhares de pessoas precisam de apoio —
          e centenas de voluntários querem ajudar, mas não sabem como.
        </p>
        <p style="margin-top:12px">
          Nossa plataforma centraliza campanhas de arrecadação, eventos voluntários e cadastros em
          um único lugar, simples e acessível.
        </p>
        <a href="pages/voluntario.jsp" class="btn btn-lg" style="margin-top:28px;background:var(--white);color:var(--orange)">
          Faça parte desta história
        </a>
      </div>
      <div class="about-img-grid">
        <div class="about-img-block aib-1">
          <span class="icon">
            <i class="fas fa-bread-slice"></i>
          </span>
          Arrecadação de alimentos
        </div>
        <div class="about-img-block aib-2">
          <span class="icon">
            <i class="fas fa-hands-helping"></i>
          </span>
          Ações com impacto real
        </div>
        <div class="about-img-block aib-3">
          <span class="icon">
            <i class="fas fa-tshirt"></i>
          </span>
          Roupas e cobertores
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ── Campanhas ────────────────────────────────────────────── -->
<section class="section campaigns-section" id="campanhas">
  <div class="container">
    <div class="section-header">
      <div class="section-label">Ação agora</div>
      <h2>Campanhas em andamento</h2>
      <p>Veja como você pode contribuir com as iniciativas ativas no momento.</p>
    </div>
    <div id="campaigns-grid" class="campaigns-grid">
      <div class="loader-wrap"><div class="spinner"></div><p>Carregando campanhas…</p></div>
    </div>
    <div style="text-align:center;margin-top:36px">
      <a href="pages/campanhas.jsp" class="btn btn-outline">Ver todas as campanhas →</a>
    </div>
  </div>
</section>

<!-- ── Como funciona ────────────────────────────────────────── -->
<section class="section how-section">
  <div class="container">
    <div class="section-header text-center">
      <div class="section-label">Simples assim</div>
      <h2>Como participar</h2>
      <p style="margin: 0 auto;">Ajudar nunca foi tão fácil. Veja o processo em poucos passos.</p>
    </div>
    <div class="steps-grid">
      <div class="card step-card">
        <div class="step-num">1</div>
        <h3>Explore as campanhas</h3>
        <p>Veja todas as campanhas ativas e encontre uma que esteja alinhada com o que você quer fazer.</p>
      </div>
      <div class="card step-card">
        <div class="step-num">2</div>
        <h3>Cadastre-se como voluntário</h3>
        <p>Preencha o formulário rápido com seu nome, e-mail e telefone. Leva menos de um minuto.</p>
      </div>
      <div class="card step-card">
        <div class="step-num">3</div>
        <h3>Receba o contato</h3>
        <p>A equipe do Conecta Solidário entrará em contato para orientá-lo sobre como e quando contribuir.</p>
      </div>
      <div class="card step-card">
        <div class="step-num">4</div>
        <h3>Faça a diferença</h3>
        <p>Participe da ação e ajude a transformar a vida de pessoas em situação de rua em São Paulo.</p>
      </div>
    </div>
  </div>
</section>

<!-- ── CTA Banner ───────────────────────────────────────────── -->
<section class="cta-banner">
  <div class="container">
    <h2>Pronto para fazer parte?</h2>
    <p>Cadastre-se como voluntário agora e receba informações sobre as próximas campanhas.</p>
    <div class="cta-btns">
      <a href="pages/voluntario.jsp" class="btn btn-primary btn-lg">Quero ser voluntário</a>
      <a href="#contato" class="btn btn-ghost btn-lg" style="color:#fff;border-color:rgba(255,255,255,.3)">Fale conosco</a>
    </div>
  </div>
</section>

<!-- ── Contato ──────────────────────────────────────────────── -->
<section class="section" id="contato" style="background:var(--warm)">
  <div class="container">
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:64px;align-items:start">
      <div>
        <div class="section-label">Fale conosco</div>
        <h2>Entre em contato</h2>
        <p style="margin-top:16px">
          Tem alguma dúvida, sugestão ou quer saber mais sobre como ajudar?
          Mande uma mensagem — nossa equipe responde em até 48 horas.
        </p>
        <div style="margin-top:32px;display:flex;flex-direction:column;gap:16px">
          <div style="display:flex;align-items:center;gap:12px;color:var(--text-m)">
            <i class="fas fa-envelope"></i>
            <span>contato@conectasolidario.org.br</span>
          </div>
          <div style="display:flex;align-items:center;gap:12px;color:var(--text-m)">
            <i class="fas fa-phone"></i>
            <span>(11) 9 9999-0000</span>
          </div>
          <div style="display:flex;align-items:center;gap:12px;color:var(--text-m)">
            <i class="fas fa-map-marker-alt"></i>
            <span>São Paulo, SP</span>
          </div>
        </div>
      </div>
      <form class="card" style="padding:32px" id="contact-form">
        <div class="form-group">
          <label class="form-label">Nome <span>*</span></label>
          <input type="text" class="form-control" data-required placeholder="Seu nome completo">
          <span class="form-error" style="display:none"></span>
        </div>
        <div class="form-group">
          <label class="form-label">E-mail <span>*</span></label>
          <input type="email" class="form-control" data-required placeholder="seu@email.com">
          <span class="form-error" style="display:none"></span>
        </div>
        <div class="form-group">
          <label class="form-label">Mensagem <span>*</span></label>
          <textarea class="form-control" data-required placeholder="Escreva sua mensagem…"></textarea>
          <span class="form-error" style="display:none"></span>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Enviar mensagem</button>
      </form>
    </div>
  </div>
</section>

<!-- ── Footer ───────────────────────────────────────────────── -->
<footer>
  <div class="container">
    <div class="footer-grid">
      <div>
        <div class="footer-brand">
          <i class="fas fa-handshake"></i>
          Conecta Solidário
        </div>
        <p class="footer-desc">
          Plataforma web para divulgação de campanhas sociais e cadastro de voluntários,
          auxiliando pessoas em situação de rua em São Paulo.
        </p>
      </div>
      <div class="footer-col">
        <h4>Links</h4>
        <ul>
          <li><a href="index.jsp">Início</a></li>
          <li><a href="#campanhas">Campanhas</a></li>
          <li><a href="pages/voluntario.jsp">Seja Voluntário</a></li>
          <li><a href="#contato">Contato</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Admin</h4>
        <ul>
          <li><a href="pages/login.jsp">Login</a></li>
          <li><a href="pages/admin.jsp">Painel</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2024 Conecta Solidário. Todos os direitos reservados.</span>
      <span>Feito com <i class="fas fa-heart"></i> para quem precisa</span>
    </div>
  </div>
</footer>

<div id="toast-container"></div>

<script src="js/config.js"></script>
<script src="js/api-unified.js"></script>
<script>
  const ICONS = ['bread','coat','bottle','pill','books','home','bath','salad'];

  async function loadCampanhas() {
    const grid = document.getElementById('campaigns-grid');
    try {
      const data = await API.getCampanhas();
      const ativas = (data || []).filter(c => {
        const st = campaignStatus(c.data_inicio, c.data_fim);
        return st.label === 'Ativa';
      }).slice(0, 3);

      document.getElementById('stat-campanhas').querySelector('strong').textContent =
        (data || []).filter(c => campaignStatus(c.data_inicio, c.data_fim).label === 'Ativa').length;

      if (!ativas.length) {
        grid.innerHTML = `<div class="empty-state" style="grid-column:1/-1">
          <div class="icon">
            <i class="fas fa-calendar-alt"></i>
          </div>
          <h3>Nenhuma campanha ativa no momento</h3>
          <p>Volte em breve para ver as próximas ações.</p>
        </div>`;
        return;
      }
      grid.innerHTML = ativas.map((c,i) => {
        const st = campaignStatus(c.data_inicio, c.data_fim);
        return `
        <div class="card campaign-card">
          <div class="campaign-card-top">
            <div class="campaign-icon">${getIconSVG(ICONS[i % ICONS.length])}</div>
            <span class="badge ${st.cls}">${st.label}</span>
          </div>
          <div class="campaign-card-body">
            <h3>${c.titulo}</h3>
            <p>${c.descricao}</p>
            <div class="campaign-dates">
              <i class="fas fa-calendar-alt"></i>
              <span>${formatDate(c.data_inicio)}</span> até <span>${formatDate(c.data_fim)}</span>
            </div>
            <a href="pages/voluntario.jsp" class="btn btn-forest btn-sm">Quero ajudar</a>
          </div>
        </div>`;
      }).join('');
    } catch (e) {
      grid.innerHTML = `<div class="empty-state" style="grid-column:1/-1">
        <div class="icon">
          <i class="fas fa-exclamation-circle"></i>
        </div>
        <h3>Erro ao carregar campanhas</h3>
        <p>Tente novamente mais tarde.</p>
      </div>`;
      document.getElementById('stat-campanhas').querySelector('strong').textContent = '0';
    }
  }

  async function loadStats() {
    try {
      const vols = await API.getVoluntarios();
      document.getElementById('stat-voluntarios').querySelector('strong').textContent = (vols || []).length;
    } catch {
      document.getElementById('stat-voluntarios').querySelector('strong').textContent = '0';
    }
  }

  function getIconSVG(name) {
    const icons = {
      bread: '<i class="fas fa-bread-slice"></i>',
      coat: '<i class="fas fa-tshirt"></i>',
      bottle: '<i class="fas fa-pump-soap"></i>',
      pill: '<i class="fas fa-pills"></i>',
      books: '<i class="fas fa-book"></i>',
      home: '<i class="fas fa-home"></i>',
      bath: '<i class="fas fa-bath"></i>',
      salad: '<i class="fas fa-salad"></i>'
    };
    return icons[name] || '';
  }

  // Contact form
  document.getElementById('contact-form').addEventListener('submit', async e => {
    e.preventDefault();
    if (!validateForm(e.target)) return;
    const btn = e.target.querySelector('button[type=submit]');
    btn.textContent = 'Enviando…'; btn.disabled = true;
    await new Promise(r => setTimeout(r, 1000));
    toast('Mensagem enviada com sucesso! Retornaremos em breve.', 'success');
    e.target.reset();
    btn.textContent = 'Enviar mensagem'; btn.disabled = false;
  });

  loadCampanhas();
  loadStats();
</script>
</body>
</html>


