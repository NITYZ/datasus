# Usa uma imagem oficial do R com base Debian
FROM rocker/r-ver:4.3.1

# Instala dependências do sistema necessárias para R e pacotes
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Define o repositório CRAN no ambiente
ENV R_REPOS="https://cloud.r-project.org"

# Copia e executa o script de instalação dos pacotes R
COPY install.R /install.R
RUN Rscript /install.R

# Copia os arquivos da API
COPY plumber.R /plumber.R
COPY .Rprofile /.Rprofile

# Expõe a porta que o Plumber vai usar (Render detecta automaticamente)
EXPOSE 8000

# Comando de inicialização da API
CMD ["Rscript", "plumber.R"]
