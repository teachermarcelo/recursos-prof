# FLUENT IMMERSION — Complete English Lesson Kit

Landing page pública, aula demonstrativa gratuita A2 e estrutura inicial para a plataforma FLUENT IMMERSION.

## Páginas
- `index.html`: landing page, apresentação do kit e aula interativa gratuita sem exigir login.
- `levels.html`: catálogo introdutório dos níveis A0–C2.
- `login.html`: tela de login, criação de conta e recuperação de senha preparada para Supabase Auth.
- `dashboard.html`: estrutura inicial Teacher, Student e Admin; pré-visualize com `dashboard.html?role=teacher&demo=1`, `?role=student&demo=1` ou `?role=admin&demo=1`.
- `app-config.js`: configuração pública placeholder para ativar o cliente Supabase.
- `app-config.example.js`: exemplo de configuração.
- `supabase/migrations/`: migrações SQL do projeto.

## Publicação no GitHub Pages
Em Settings → Pages, escolha Deploy from a branch, branch `main` e pasta `/(root)`. Site esperado: https://teachermarcelo.github.io/recursos-prof/

## Configurar autenticação Supabase
1. Abra `app-config.js` e substitua os placeholders pela URL e chave publicável/anon do projeto correto.
2. Configure no Supabase Auth as URLs permitidas de redirecionamento para o domínio GitHub Pages.
3. Configure e teste as políticas RLS para cada tabela com usuários de diferentes papéis.

**Nunca coloque a chave `service_role` no navegador.** Uma chave publicável não substitui políticas RLS, validação de permissões, armazenamento privado ou verificação de pagamentos.

## Estado atual e limites
- A aula gratuita e o quiz funcionam no navegador; os resultados ainda não são salvos no banco.
- Login/criação de conta/recuperação estão preparados para Supabase Auth após configuração.
- Os dashboards são estruturas iniciais de interface, não painéis completos conectados a dados reais.
- O catálogo de níveis é uma apresentação inicial, ainda não conectado aos registros publicados do banco.
- Os botões comerciais encaminham para o WhatsApp. Não existe checkout nem confirmação automática de pagamento.

## Próximas integrações
- Reconciliar as migrações e tabelas existentes com o esquema real do Supabase.
- Publicar aulas e assets no catálogo com relações consistentes.
- Implementar turmas, atribuições, atividades, respostas, feedback e relatórios.
- Conectar leads por backend/Edge Function seguro e registrar consentimento.
- Implementar pagamentos e liberar acesso apenas após confirmação do provedor.
- Testar segurança e permissões antes de disponibilizar materiais privados.
