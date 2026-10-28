# FLUENT IMMERSION — Complete English Lesson Kit

Landing page inicial e aula demonstrativa A2 para o repositório `teachermarcelo/recursos-prof`.

## Conteúdo
- `index.html`: landing page responsiva, aula demo interativa e botões de contato.
- `supabase/migrations/20261028_create_fluent_immersion_storefront.sql`: schema dedicado e tabelas iniciais.

## Publicar via GitHub Pages
1. Abra Settings → Pages.
2. Em Build and deployment, escolha Deploy from a branch.
3. Selecione `main` e `/ (root)`, depois Save.
4. URL esperada: https://teachermarcelo.github.io/recursos-prof/

## WhatsApp
Os botões encaminham para o número fornecido. Compra e pagamento ainda não são automatizados.

## Supabase
O schema `fluent_immersion` é privado e não é exposto diretamente ao cliente. A landing page não contém chaves Supabase. Para registrar leads, login, catálogo e liberação de compras, implementar Edge Functions ou backend confiável, mantendo a service_role apenas no servidor.

## Próximas etapas
- Ativar GitHub Pages.
- Criar fluxo seguro para registrar leads com consentimento.
- Adicionar autenticação e biblioteca privada.
- Armazenar arquivos em buckets privados com políticas adequadas.
- Implementar confirmação de compra antes de conceder acesso.
