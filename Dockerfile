FROM alpine:3.6

WORKDIR /opt

RUN apk -Uuv add bash curl jq ca-certificates groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

ADD ./entrypoint.sh /entrypoint.sh

RUN mkdir /opt/src

ENTRYPOINT [ "/entrypoint.sh" ]