FROM elastic/filebeat:8.4.3

# Copia a configuração do Filebeat
COPY filebeat.yml /usr/share/filebeat/filebeat.yml

# Copia os pipelines de ingestão
COPY pipeline_logs.json /usr/share/filebeat/pipeline_logs.json

# Ajusta permissões dos arquivos copiados
USER root
RUN chmod go-w /usr/share/filebeat/filebeat.yml \
    && chmod go-w /usr/share/filebeat/pipeline_logs.json \
    && chmod 644 /var/log/jcagent.log \
    && chown root:filebeat /var/log/jcagent.log

# Comando de inicialização
CMD ["filebeat", "-e", "--strict.perms=false"]
