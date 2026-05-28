/**
 * Conecta Solidário – Fake API Service Layer
 * Dados simulados para apresentação e desenvolvimento.
 * Mantém a mesma interface que o api.js real.
 */

const FakeAPI = (() => {
  // ── Dados Fakes ─────────────────────────────────────────────
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
    ],

    auth: {
      login: {
        success: true,
        message: "Login realizado com sucesso",
        user: {
          id: 1,
          nome: "Administrador",
          email: "admin@conectasolidario.com.br",
          role: "admin"
        }
      },
      error: {
        success: false,
        message: "E-mail ou senha inválidos"
      }
    }
  };

  // ── Simulação de Delay de Rede ─────────────────────────────
  const fakeDelay = (ms = 500) => new Promise(resolve => setTimeout(resolve, ms));

  // ── Função de Resposta Simulada ────────────────────────────
  async function fakeRequest(method, endpoint, body = null) {
    await fakeDelay(300); // Simula latência de rede
    
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
        if (email === 'admin@conectasolidario.com.br' && senha === 'admin123') {
          sessionStorage.setItem('cs_admin', JSON.stringify(fakeData.auth.login.user));
          return fakeData.auth.login;
        } else {
          return fakeData.auth.error;
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

  return {
    // ── Campanhas ─────────────────────────────────────────────
    getCampanhas:    ()      => fakeRequest('GET',    '/campanhas'),
    getCampanha:     id      => fakeRequest('GET',    `/campanhas/${id}`),
    postCampanha:    dados   => fakeRequest('POST',   '/campanhas', dados),
    putCampanha:     (id,d)  => fakeRequest('PUT',    `/campanhas/${id}`, d),
    deleteCampanha:  id      => fakeRequest('DELETE', `/campanhas/${id}`),

    // ── Voluntários ───────────────────────────────────────────
    getVoluntarios:  ()      => fakeRequest('GET',    '/voluntarios'),
    postVoluntario:  dados   => fakeRequest('POST',   '/voluntarios', dados),

    // ── Auth ───────────────────────────────────────────────────
    login:           creds   => fakeRequest('POST',   '/login', creds),
    logout:          ()      => fakeRequest('POST',   '/logout'),
  };
})();

// ─── Exportar para uso opcional ───────────────────────────────
// Para usar o fake API, substitua "API" por "FakeAPI" nos arquivos HTML
// ou use: <script src="fake-api.js"></script> em vez de api.js