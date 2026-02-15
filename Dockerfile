FROM alpine:latest

# Instala ferramentas básicas
RUN apk add --no-cache ca-certificates wget unzip

# Baixa PocketBase (versão mais recente em 2026 - ajuste o número se houver nova versão)
# Link direto da release: https://github.com/pocketbase/pocketbase/releases
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -O /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/pocketbase \
    && rm /tmp/pb.zip

# Copia seu frontend para a pasta pública do PocketBase
COPY index.html /pb_public/index.html

# Cria pasta para dados persistentes (volume montado aqui)
RUN mkdir -p /pb_data

# Expõe a porta que você escolheu (8080)
EXPOSE 8080

# Comando de inicialização - usa a porta 8080 fixa
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb_data", "--publicDir=/pb_public"]
