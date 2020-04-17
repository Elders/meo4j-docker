FROM alpine:3.11 as downloader

RUN apk add curl && \
    curl -L 'https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.4.0.8/apoc-3.4.0.8-all.jar' -o /apoc-3.4.0.8-all.jar

FROM neo4j:3.4.0 as runtime

MAINTAINER Elders

COPY --from=downloader /apoc-3.4.0.8-all.jar /var/lib/neo4j/plugins/

RUN echo "dbms.security.procedures.whitelist=apoc.* >> /var/lib/neo4j/conf/neo4j.conf" && \
    echo "dbms.security.procedures.unrestricted=apoc.* >> /var/lib/neo4j/conf/neo4j.conf"
