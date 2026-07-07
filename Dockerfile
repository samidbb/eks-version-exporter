FROM golang:1.26.4-bookworm AS builder
WORKDIR /src

COPY src/go.mod src/go.sum ./
RUN go mod download

COPY src/*.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags='-s -w' -o /out/eks-version-exporter .

FROM debian:bookworm-slim
ARG APP=/usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates tzdata curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

ENV TZ=Etc/UTC
ENV APP_USER=test

RUN groupadd "$APP_USER" \
    && useradd -g "$APP_USER" "$APP_USER" \
    && mkdir -p "$APP"

WORKDIR $APP
COPY --from=builder /out/eks-version-exporter ./eks-version-exporter

RUN chown -R "$APP_USER:$APP_USER" "$APP"

USER $APP_USER

EXPOSE 8080
CMD ["./eks-version-exporter"]
