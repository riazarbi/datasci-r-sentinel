FROM riazarbi/datasci-r-8020:latest

LABEL authors="Riaz Arbi,Gordon Inggs"

USER root

# DEPENDENCIES ===================================================================

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get clean && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    gdal-bin \
    aria2 \
    libpython2-dev \
    libprotobuf-dev \
# Clean out cache
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# NOT IN CRAN ================

RUN R -e "remotes::install_github('ranghetti/sen2r', ref = 'master', dependencies = TRUE)"

# Configure sen2r
RUN mkdir /sen2cor_280 \
 && Rscript -e 'sen2r:::install_sen2cor("/sen2cor_280", version = "2.8.0")' \
 && chmod -R 0755 /sen2cor_280 

# BACK TO NB_USER ========================================================
USER $NB_USER
