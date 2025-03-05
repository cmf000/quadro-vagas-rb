## 🚀 Tecnologias e Ferramentas

- **Ruby**: Última versão suportada pelo GitHub Actions (3.4.2)
- **Rails 8**: Com suporte a Turbo, Stimulus, ImportMap e Tailwind
- **PostgreSQL**: 16
- **Docker & Docker Compose**: Para orquestrar o ambiente
- **Selenium / Cuprite**: Para testes de sistema
- **Chromium Headless**: Instalado no container para testes automatizados
- **GitHub Actions**: Rodando testes + RuboCop

## 📌 Instalação

### 1️⃣ Instalar Dependências

O projeto está configurado para rodar em um container docker, portanto certifique-se de ter o **Docker** e o **Docker Compose** instalados no seu sistema.

### 2️⃣ Construir e Rodar os Containers

Os arquivo relativos ao Docker estão no diretório quadro-vagas-rb/.dockerdev.

Execute o comando abaixo para iniciar a aplicação:

```sh
docker compose build
```
Isso irá: ✅ Construir a imagem do ambiente da aplicação

```sh
 sudo docker compose up -d postgres
```
Isso irá: ✅  Realizar o build da imagem do banco de dados

```sh
docker compose run --rm rails bin/setup
```
✅ Executar scripts iniciais da aplicação rails, incluindo a criação do banco de dados


O serviço rails permite acesso à linha de comando

```sh
docker compose run --rm rails rspec # executa testes
docker compose run --rm rails bash # acesso à linha de comando com privilégios de superusuário
docker compose run --rm rails console # terminal do rails
...
```

```sh
docker compose up web
```
✅ Subir a aplicação no `localhost:3000`


### 🧹 Verificando Estilo de Código com RuboCop

Para rodar o **RuboCop** e garantir um código limpo e bem formatado:

```sh
docker compose run --rm rails bin/rubocop
```

### ✨ Teste de Boas-Vindas com StimulusJS

Um teste de boas-vindas está incluído na aplicação para exibir um **"Hello, World!"** alguns instantes após carregar a página.

