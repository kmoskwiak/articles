FROM node:12.16-alpine
WORKDIR /app
COPY ./config.js ./
COPY ./cRS.js ./
COPY ./cRS_generator ./
COPY ./readFile.js ./
COPY ./read.js ./
COPY ./read-no-shared.js ./
COPY ./file ./

ENTRYPOINT [ "node" ] 