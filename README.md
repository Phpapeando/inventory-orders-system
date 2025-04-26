# Sistema de gerenciamento de pedidos e estoque

Sistema ainda em desenvolvimento.

Este projeto utiliza Docker para configurar um ambiente de desenvolvimento para uma aplicação Laravel, incluindo um banco de dados MySQL e um servidor web Nginx.

## Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

- **Docker**: Ferramenta para criar, implantar e rodar containers.
- **Docker Compose**: Ferramenta para definir e executar aplicativos Docker com múltiplos containers.

## Executando o Projeto

### Passo 1: Clonar o Repositório

Clone este repositório para sua máquina local:

```bash
git clone https://github.com/Phpapeando/inventory-orders-system.git
cd inventory-orders-system
```

### Passo 2: Rodar os Containers Docker

Execute o comando make build para configurar e iniciar os containers (Primeira Execução):

```bash
make build
```
Utilize o `make build` somente na primeira vez que executar o projeto. 
Nas execuções subsequentes você poderá utilizar o `make up` para iniciar os containers de forma mais rápida.

```bash
make up
```

Caso você não tenha o make instalado na sua máquina siga as etapas abaixo:

1. Copie o arquivo .env.example para .env.

2. Crie os arquivos de log `access.log` e `error.log` dentro do diretório `nginx` na raiz do projeto.

    ```bash
    touch nginx/access.log nginx/error.log
    ```

3. Execute o comando `docker-compose up -d --build` para construir e iniciar os containers do Docker.

4. Execute `docker exec -it lara_docker_env_app bash` para acessar o container do app e em seguida rode os seguintes comandos dentro do container:

    - composer install: Instala as dependências do Laravel.
    ```bash
    composer install
    ```
    - php artisan migrate: Executa as migrações do banco de dados.
    ```bash
    php artisan migrate
    ```
    - php artisan key:generate: Gera a chave de aplicação do Laravel.
    ```bash
    php artisan key:generate
    ```

### Passo 3: Acessar a Aplicação

Após os containers estarem em funcionamento, a aplicação estará acessível no seu navegador no endereço:

```
http://localhost:8088
```

---

## Comandos Disponíveis no `Makefile`

- **`make build`**: Constrói os containers Docker e configura a aplicação.
- **`make up`**: Sobe os containers Docker depois de configurados (usado após make build).
- **`make down`**: Derruba os containers, redes e volumes definidos no `docker-compose.yml`.
- **`make clean`**: Limpa containers, imagens e volumes associados ao projeto. Cuidado, esse comando afeta todo o Docker!

---

## Problemas Comuns

### 1. **Erro ao acessar o Nginx**
Se você não conseguir acessar o servidor Nginx na porta `8088`, tente verificar se o container está rodando corretamente com:

```bash
docker ps
```

Verifique também os logs do Nginx para detectar possíveis problemas:

```bash
docker logs lara_docker_env_nginx
```

### 2. **Erro ao gerar a chave da aplicação (APP_KEY)**
Caso o comando `php artisan key:generate` não funcione dentro do container, execute-o fora do container, diretamente no seu terminal local:

É necessário ter o PHP e o Composer instalado para que o comando funcione.

```bash
docker exec -it lara_docker_env_app bash
php artisan key:generate
```
