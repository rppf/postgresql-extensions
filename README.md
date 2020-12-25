# postgresql-extensions
A Docker image containing pg_cron, postgis, and timescaledb extensions for Postgresql.

# Installed extensions

1. Postgis
2. pg_cron (1.3.0)
3. TimescaleDB (1.7.2)

# How to run

1. ```docker pull rppf/postgresql-extension:v1.0```
2. ```docker run --rm -it  -e POSTGRES_PASSWORD=yourpassword -p  5432:5432/tcp postgresql-extensions:v1.0```
