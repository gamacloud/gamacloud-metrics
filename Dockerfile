FROM docker.io/golang:1.11.0-stretch as bbbuilder
ADD main.go /go/src/github.com/gamacloud/gamacloud-metrics/
ADD go.mod /go/src/github.com/gamacloud/gamacloud-metrics/
ADD go.sum /go/src/github.com/gamacloud/gamacloud-metrics/
WORKDIR /go/src/github.com/gamacloud/gamacloud-metrics
ENV GO111MODULE on
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /example .

FROM scratch
COPY --from=bbbuilder /example /example
ENTRYPOINT ["/example"]
