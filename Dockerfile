FROM alpine:latest

# Instala dependências mínimas
RUN apk add --no-cache ca-certificates wget unzip

# Baixa o PocketBase (versão mais recente em 2026 - ajuste o número se houver nova versão)
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -O /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/pocketbase \
    && rm /tmp/pb.zip

# Copia seu frontend para a pasta pública
COPY index.html /pb_public/index.html

# Cria pasta para dados persistentes
RUN mkdir -p /pb_data

# Expõe a porta que o Fly.io usa
EXPOSE 8080

# Comando de inicialização
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:$PORT", "--dir=/pb_data", "--publicDir=/pb_public"]
