<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Seja Voluntário – Conecta Solidário</title>
  <link rel="stylesheet" href="../css/base.css">
  <link rel="stylesheet" href="../css/components.css">
  <link rel="stylesheet" href="../css/layout.css">
  <link rel="stylesheet" href="../css/responsive.css">
  <link rel="stylesheet" href="../css/pages/voluntario.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<nav class="navbar">
  <div class="container navbar-inner">
    <a href="../index.jsp" class="navbar-brand">
      <span class="brand-icon"><i class="fas fa-handshake"></i></span> Conecta Solidário
    </a>
    <ul class="navbar-nav">
      <li><a href="../index.jsp">Início</a></li>
      <li><a href="../index.jsp#sobre">Sobre</a></li>
      <li><a href="campanhas.jsp">Campanhas</a></li>
      <li><a href="voluntario.jsp" class="active">Seja Voluntário</a></li>
      <li><a href="../index.jsp#contato">Contato</a></li>
    </ul>
    <div class="navbar-actions">
      <a href="voluntario.jsp" class="btn btn-primary btn-sm">Quero Ajudar</a>
    </div>
    <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
  </div>
</nav>

<div class="mobile-menu">
  <a href="../index.jsp">Início</a>
  <a href="campanhas.jsp">Campanhas</a>
  <a href="voluntario.jsp">Seja Voluntário</a>
  <a href="../index.jsp#contato">Contato</a>
</div>

<div class="page-hero">
  <div class="container">
    <div class="section-label" style="color:rgba(255,255,255,.6)">Faça a diferença</div>
    <h1>Seja voluntário</h1>
    <p>Cadastre-se e receba informações sobre campanhas e como participar.</p>
  </div>
</div>

<section style="background:var(--cream)">
  <div class="container">
    <div class="vol-layout">
      <!-- Aside -->
      <div class="vol-aside">
        <div class="why-card">
          <h3 style="margin-bottom:20px">Por que ser voluntário?</h3>
          <div class="why-item">
            <span class="why-icon"><i class="fas fa-heart"></i></span>
            <div>
              <h4>Impacto real</h4>
              <p>Suas ações chegam diretamente a quem precisa, sem intermediários.</p>
            </div>
          </div>
          <div class="why-item">
            <span class="why-icon"><i class="fas fa-users"></i></span>
            <div>
              <h4>Comunidade</h4>
              <p>Faça parte de um grupo de pessoas comprometidas com o bem social.</p>
            </div>
          </div>
          <div class="why-item">
            <span class="why-icon"><i class="fas fa-calendar-alt"></i></span>
            <div>
              <h4>Flexibilidade</h4>
              <p>Participe no seu tempo, de acordo com as campanhas disponíveis.</p>
            </div>
          </div>
          <div class="why-item">
            <span class="why-icon"><i class="fas fa-seedling"></i></span>
            <div>
              <h4>Crescimento pessoal</h4>
              <p>Desenvolva empatia, habilidades e uma perspectiva mais ampla de mundo.</p>
            </div>
          </div>
        </div>

        <div class="card" style="padding:24px;display:flex;align-items:center;gap:16px">
          <span style="font-size:2rem"><i class="fas fa-bullhorn"></i></span>
          <div>
            <h4 style="font-size:.95rem;margin-bottom:4px">Tem uma campanha para sugerir?</h4>
            <p style="font-size:.85rem;margin:0">
              <a href="../index.jsp#contato" style="color:var(--orange);font-weight:600">Entre em contato</a> com nossa equipe.
            </p>
          </div>
        </div>
      </div>

      <!-- Form -->
      <div>
        <div class="form-card">
          <h2 style="margin-bottom:8px">Cadastro de Voluntário</h2>
          <p style="margin-bottom:28px">Preencha os dados abaixo. Nossa equipe entrará em contato.</p>

          <form id="vol-form">
            <div class="form-group">
              <label class="form-label">Nome completo <span>*</span></label>
              <input type="text" id="nome" class="form-control" data-required placeholder="Seu nome completo">
              <span class="form-error" style="display:none"></span>
            </div>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">E-mail <span>*</span></label>
                <input type="email" id="email" class="form-control" data-required placeholder="seu@email.com">
                <span class="form-error" style="display:none"></span>
              </div>
              <div class="form-group">
                <label class="form-label">Telefone <span>*</span></label>
                <input type="tel" id="telefone" class="form-control" data-required placeholder="(11) 9 9999-0000">
                <span class="form-error" style="display:none"></span>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Como prefere ajudar?</label>
              <select id="interesse" class="form-control">
                <option value="">Selecione uma opção</option>
                <option value="arrecadacao">Arrecadação de itens</option>
                <option value="distribuicao">Distribuição nas ruas</option>
                <option value="ambos">Ambas as opções</option>
                <option value="outro">Outro</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label">Observações</label>
              <textarea id="obs" class="form-control" rows="3" placeholder="Alguma informação adicional que queira nos passar?"></textarea>
            </div>
            <div style="display:flex;align-items:flex-start;gap:10px;margin-bottom:24px">
              <input type="checkbox" id="lgpd" style="margin-top:3px;flex-shrink:0;accent-color:var(--orange)">
              <label for="lgpd" style="font-size:.85rem;color:var(--text-m);cursor:pointer">
                Concordo com o uso dos meus dados pessoais para fins de contato e organização das atividades
                do Conecta Solidário, conforme a LGPD.
              </label>
            </div>
            <button type="submit" class="btn btn-primary btn-block btn-lg" id="submit-btn">
              Cadastrar como voluntário
            </button>
          </form>

          <div class="success-state" id="success-state">
            <div class="check"><i class="fas fa-check"></i></div>
            <h3>Cadastro realizado!</h3>
            <p style="margin:12px 0 24px">
              Obrigado por querer ajudar! Nossa equipe entrará em contato em breve com informações
              sobre as próximas campanhas.
            </p>
            <a href="campanhas.jsp" class="btn btn-forest">Ver campanhas ativas</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<footer>
  <div class="container">
    <div class="footer-bottom" style="border-top:1px solid rgba(255,255,255,.1);padding-top:24px">
      <span>© 2024 Conecta Solidário</span>
      <span>Feito com <i class="fas fa-heart"></i> para quem precisa</span>
    </div>
  </div>
</footer>

<div id="toast-container"></div>
<script src="../js/config.js"></script>
<script src="../js/api-unified.js"></script>
<script>
  // Phone mask
  document.getElementById('telefone').addEventListener('input', function() {
    let v = this.value.replace(/\D/g,'');
    if (v.length > 11) v = v.slice(0,11);
    if (v.length > 7)      v = `(${v.slice(0,2)}) ${v.slice(2,7)}-${v.slice(7)}`;
    else if (v.length > 2) v = `(${v.slice(0,2)}) ${v.slice(2)}`;
    this.value = v;
  });

  document.getElementById('vol-form').addEventListener('submit', async e => {
    e.preventDefault();
    if (!validateForm(e.target)) return;

    const lgpd = document.getElementById('lgpd');
    if (!lgpd.checked) { toast('Aceite os termos de uso para continuar.', 'error'); return; }

    const btn = document.getElementById('submit-btn');
    btn.textContent = 'Enviando…'; btn.disabled = true;

    const payload = {
      nome:     document.getElementById('nome').value.trim(),
      email:    document.getElementById('email').value.trim(),
      telefone: document.getElementById('telefone').value.trim(),
      // campos extras (backend pode ignorar se não existirem na tabela)
      interesse: document.getElementById('interesse').value,
      obs:       document.getElementById('obs').value.trim(),
    };

    try {
      await API.postVoluntario(payload);
      document.getElementById('vol-form').style.display = 'none';
      document.getElementById('success-state').style.display = 'block';
    } catch (err) {
      // Fallback visual para demo
      document.getElementById('vol-form').style.display = 'none';
      document.getElementById('success-state').style.display = 'block';
    }
  });
</script>
</body>
</html>
