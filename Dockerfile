FROM alpine:latest

# Instala dependências
RUN apk add --no-cache ca-certificates wget unzip

# Baixa PocketBase (versão mais recente - ajuste se houver nova)
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -O /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/pocketbase \
    && rm /tmp/pb.zip

# Copia seu frontend (index.html deve estar na raiz do repo)
COPY index.html /pb_public/index.html

# Cria pasta para dados
RUN mkdir -p /pb_data

# Expõe a porta
EXPOSE 8090

# Comando com aspas duplas para garantir expansão da variável $PORT
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:\"$PORT\"", "--dir=/pb_data", "--publicDir=/pb_public"]FROM alpine:latest

# Instala dependências
RUN apk add --no-cache ca-certificates wget unzip

# Baixa PocketBase (versão mais recente - ajuste se houver nova)
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -O /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/pocketbase \
    && rm /tmp/pb.zip

# Copia seu frontend (index.html deve estar na raiz do repo)
COPY index.html /pb_public/index.html

# Cria pasta para dados
RUN mkdir -p /pb_data

# Expõe a porta
EXPOSE 8090

# Comando com aspas duplas para garantir expansão da variável $PORT
CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:\"$PORT\"", "--dir=/pb_data", "--publicDir=/pb_public"]
