FROM rocker/r-ver:4.3.1

# Instala bibliotecas de sistema necessárias
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libv8-dev \
    libfontconfig1-dev \
    pandoc \
    make \
    curl \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Define o repositório do R
ENV R_REPOS="https://cloud.r-project.org"

# Copia e executa o script de instalação dos pacotes
COPY install.R /install.R
RUN Rscript /install.R || (cat /install.R && echo '❌ Falha ao instalar pacotes!' && exit 1)

# Copia o código da API
COPY plumber.R /plumber.R
COPY run_api.R /run_api.R

# Define a porta (Render injeta automaticamente)
EXPOSE 8000

# Comando para rodar a API
CMD ["Rscript", "run_api.R"]
