.PHONY: build up down

build:
	@echo "Copiando .env.example para .env..."
	cp -n .env.example .env || true
	@echo "Criando arquivos de log..."
	mkdir -p nginx
	touch nginx/access.log nginx/error.log
	@echo "Subindo containers Docker..."
	docker compose up -d --build
	@echo "Instalando dependências no container..."
	docker exec -it lara_docker_env_app bash -c "composer install && php artisan migrate && php artisan key:generate"

up:
	@echo "Subindo containers Docker..."
	docker compose up -d --build

down:
	@echo "Derrubando containers Docker..."
	docker compose down

clean:
	@echo "Removendo containers relacionados a esse projeto..."
	docker compose down --volumes --rmi all --remove-orphans