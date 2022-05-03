FROM alpine:3.15 as downloader

RUN apk add curl && \
    curl -L 'https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.4.0.3/apoc-4.4.0.3-all.jar' -o /apoc-4.4.0.3-all.jar

FROM neo4j:4.4.6-community as runtime

MAINTAINER Elders

COPY --from=downloader /apoc-4.4.0.3-all.jar /var/lib/neo4j/plugins/

RUN echo "dbms.directories.plugins=/var/lib/neo4j/plugins >> /var/lib/neo4j/conf/neo4j.conf" && \
    echo "dbms.security.procedures.unrestricted=apoc.trigger.*,apoc.meta.*,apoc.* >> /var/lib/neo4j/conf/neo4j.conf" && \
    echo "dbms.security.procedures.whitelist=apoc.coll.*,apoc.load.*, apoc.* >> /var/lib/neo4j/conf/neo4j.conf"
