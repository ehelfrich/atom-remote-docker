FROM continuumio/miniconda3

# Install Jupyter
RUN conda install --quiet --yes \
  'notebook' \
  'jupyterhub' \
  'jupyterlab'

# ffmpeg for matplotlib anim
RUN apt-get update && \
  apt-get install -y --no-install-recommends ffmpeg && \
  rm -rf /var/lib/apt/lists/*

# Python Packages
RUN conda install --quiet --yes \
  'numpy' \
  'pandas' \
  'seaborn' \
  'scikit-learn' \
  # Required
  'ipython' \
  'ipykernel' \
  'python-language-server'

# R Packages
RUN conda install --quiet --yes \
  'r-essentials' \
  'r-igraph'

# install R language server
RUN Rscript -e 'install.packages("languageserver", repos="http://archive.linux.duke.edu/cran/")'

# Install Kernels
RUN python3 -m ipykernel install --user
RUN Rscript -e 'IRkernel::installspec()'

# Install Tini
RUN conda install --quiet --yes 'tini'

# Expose Port for notebook
EXPOSE 22222

# Generate Config
RUN jupyter notebook --generate-config

# Container Startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["/usr/local/bin/start-notebook.sh"]
#CMD ["jupyter notebook --ip=127.0.0.1 --no-browser --port:22222"]

# Add Local Files
COPY start-notebook.sh /usr/local/bin
COPY jupyter_notebook_config.py /root/.jupyter
RUN chmod 777 /usr/local/bin/start-notebook.sh
