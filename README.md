# FLUENT IMMERSION — Complete English Lesson Kit

Plataforma de recursos para professores de inglês, com landing page, aula gratuita, catálogo CEFR, página individual por aula e experiência **Ready-to-Teach**.

## Páginas principais
- `index.html`: landing page pública.
- `free-lesson.html`: demonstração interativa gratuita A2 — Travel: At the Airport.
- `ready-to-teach.html`: página de apresentação do Ready-to-Teach, produto principal para professores.
- `levels.html`: catálogo A0–C2 com links para páginas de aula.
- `lesson.html?lesson=A2-UNIT01-LESSON001`: Lesson Studio com overview, Vocabulary, Speaking, Reading, Listening, Grammar, Assessment, Homework, Ready-to-Teach, Materials, Progress Tracker e edição individual.
- `dashboard.html`: Teacher Command Center com atalhos para a biblioteca, níveis, Ready-to-Teach e cópias editáveis.
- `login.html`: tela de autenticação Supabase.
- `app-config.js`: configuração pública do Supabase. Nunca colocar service_role/secret key no navegador.
- `supabase/migrations/20261028_teacher_lesson_edits.sql`: tabela e políticas RLS para cópias pessoais de aulas por professor.

## Páginas individuais por aula
Use um ID curricular único como query string, por exemplo:
- `lesson.html?lesson=A0-UNIT01-LESSON001`
- `lesson.html?lesson=A1-UNIT01-LESSON001`
- `lesson.html?lesson=A2-UNIT01-LESSON001`
- `lesson.html?lesson=B1-UNIT01-LESSON001`
- `lesson.html?lesson=B2-UNIT01-LESSON001`
- `lesson.html?lesson=C1-UNIT01-LESSON001`
- `lesson.html?lesson=C2-UNIT01-LESSON001`

**Importante:** a página A2 é a demonstração mais desenvolvida atualmente. Os demais IDs servem como rotas-modelo e precisam receber conteúdo específico antes de serem considerados aulas completas.

## Edição individual do professor
O formulário de `lesson.html#edit` permite personalizar título, duração, objetivo, notas do professor, variação de worksheet e homework. O salvamento local funciona neste navegador. Para salvar na nuvem:
1. Aplicar a migração SQL em `supabase/migrations/20261028_teacher_lesson_edits.sql` no SQL Editor do projeto Supabase.
2. Confirmar que o schema `fluent_immersion` está habilitado para a Data API/Exposed schemas do projeto.
3. Testar login Supabase e as políticas RLS com duas contas de professor diferentes.
4. Confirmar que cada usuário só consegue ler, criar, atualizar e excluir sua própria linha em `teacher_lesson_edits`.

O conteúdo mestre do admin e as cópias pessoais dos professores ficam em registros separados. A migração cria apenas a tabela de cópias e não altera a tabela mestre `lessons`.

## Segurança e estado funcional
- O conteúdo público da demonstração é acessível sem login.
- Não publique gabaritos privados, dados de alunos, tokens ou chaves secretas.
- A cópia individual tem salvamento local e tentativa de salvamento em nuvem após autenticação e migração.
- Turmas, atribuições, checkout, verificação de compras, arquivos pagos privados e gerenciamento administrativo completo ainda exigem implementação e testes específicos.
- Não anunciar áudio gravado, speech recognition ou progresso em nuvem se o recurso não estiver realmente publicado e testado.

## GitHub Pages
Em Settings → Pages, escolha Deploy from a branch, branch `main` e pasta `/(root)`. Site: https://teachermarcelo.github.io/recursos-prof/
