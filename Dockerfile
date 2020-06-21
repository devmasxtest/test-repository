FROM docker:stable
RUN apk add libevent pcre libgcc git


CMD ["echo", "Hello world!!"]
