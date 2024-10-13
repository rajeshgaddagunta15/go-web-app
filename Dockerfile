#here we the go lang version mentioned in the go.mod file
FROM golang:1.22.5 as base
# here we took the /app directory
WORKDIR /app
#here we copied all the dependencies
COPY go.mod ./
#downloaded all the dependencies
RUN go mod download 
#finally copy all the source code
COPY . . 
#then run the build command of the go
RUN go build -o main .

#in the above step we built as image as we are using the multi stage build we are going to use distroless image
FROM gcr.io/distroless/base
#copy the build generated here 
COPY --from=base /app/main .
#as it is go lang application here we are copying the static content as well
COPY --from=base /app/static .

EXPOSE 8080
#and finally running the main binary
CMD ["./main"]


