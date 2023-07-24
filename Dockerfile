FROM ubuntu:jammy as base

RUN apt-get update -y

RUN apt-get install -y nano wget python3 python3-venv unzip curl

ENV chrome_deb=google-chrome-stable_current_amd64.deb

RUN wget https://dl.google.com/linux/direct/${chrome_deb} && apt-get install ./${chrome_deb} -y && rm -f ${chrome_deb}

ENV DRIVER_BIN=/usr/bin/chromedriver

FROM base as chrome_driver

RUN google-chrome --version

RUN apt-get install jq -y

RUN google-chrome --version | sed -r 's/^.+Chrome //g' | tr -d '\n' | tr -d ' ' | cut -d'.' -f1-3 > chrome_version.txt

RUN curl https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq '.' | tee chrome_versions.json

RUN export chrome_version=$( cat chrome_version.txt ); cat chrome_versions.json | jq -r --arg jq_chrome_version "${chrome_version}" '.channels[] | select(.version | startswith($jq_chrome_version)) |.downloads.chromedriver[] | select(.platform=="linux64").url' > chrome_download.url

RUN echo $( cat chrome_download.url )
RUN wget $( cat chrome_download.url )

RUN unzip chromedriver-linux64.zip
RUN mv chromedriver-linux64/LICENSE.chromedriver ${DRIVER_BIN}.LICENSE
RUN mv chromedriver-linux64/chromedriver ${DRIVER_BIN}
RUN chown root:root ${DRIVER_BIN}
RUN chmod +x ${DRIVER_BIN}


FROM base AS app

COPY --from=chrome_driver ${DRIVER_BIN} ${DRIVER_BIN}

RUN chmod 777 /tmp

# RUN chmod -R o+rX /sys/devices
RUN mkdir -p /tmp/chrome && chmod 777 /tmp/chrome


WORKDIR /tmp/chrome
