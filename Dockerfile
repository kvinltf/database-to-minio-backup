FROM alpine

WORKDIR ~

ENV PG_HOST=localhost
ENV PG_USERNAME=postgres
ENV PG_PASSWORD=password
ENV PG_PORT=5432
ENV PG_DB=postgres

ENV MINIO_HOST=localhost
ENV MINIO_KEY=a
ENV MINIO_SECRET=b
ENV MINIO_BUCKET=backup


COPY ./run.sh .
RUN apk add postgresql-client
RUN apk add minio-client

CMD ["sh", "run.sh"]

















