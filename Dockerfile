# Imagem base com R e tidyverse
FROM rocker/r-ver:4.3.1

# Instalar pacotes do sistema
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar pacotes R
COPY install.R /install.R
RUN Rscript /install.R

# Copia seus arquivos
COPY plumber.R /plumber.R
COPY .Rprofile /.Rprofile

# Porta que o Plumber escuta
EXPOSE 8000

# Comando para rodar sua API
CMD ["Rscript", "plumber.R"]
