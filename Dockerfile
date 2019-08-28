FROM beradev/dbt:0.14.0

ENV DBT_MSSQL_VER 1.0.6

USER root

RUN apt-get update && apt-get install -y \
    curl gnupg2 apt-transport-https ca-certificates libssl1.1 gcc g++ unixodbc-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y -q msodbcsql17=17.3.1.1-1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV PATH "${PATH}:/opt/mssql-tools/bin"

RUN pip install dbt-mssql==${DBT_MSSQL_VER}

USER dbt 

