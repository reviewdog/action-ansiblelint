FROM python:3.9-alpine

ENV REVIEWDOG_VERSION=v0.10.2

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}
RUN apk --no-cache add git \
                       gcc \
					   musl-dev \
					   libffi-dev \
					   openssl-dev

RUN pip3 install --upgrade pip && \
    pip3 install ansible-lint && \
    rm -r /root/.cache

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
