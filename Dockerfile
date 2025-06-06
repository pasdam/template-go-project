# Build image
########################
FROM golang:1.22.3-alpine3.18 as builder

WORKDIR /var/tmp/app

RUN apk add git

# copy artifacts into the container
ADD ./main.go ./main.go
ADD ./go.mod ./go.mod
ADD ./go.sum ./go.sum
ADD ./pkg ./pkg

# Build the app
RUN go build -o .build/app .

# Final image
########################
FROM alpine:3.22.0

WORKDIR /opt/app

COPY --from=builder /var/tmp/app/.build/app .

CMD [ "./app" ]
