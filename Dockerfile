FROM ubuntu:jammy as base

RUN apt-get update -y

RUN apt-get install -y nano wget python3 python3-venv unzip curl

ENV chrome_deb=google-chrome-stable_current_amd64.deb

RUN wget https://dl.google.com/linux/direct/${chrome_deb} && apt-get install ./${chrome_deb} -y && rm -f ${chrome_deb}

ENV DRIVER_BIN=/usr/bin/chromedriver

RUN export chrome_version=$(google-chrome --version | sed -r 's/^.+Chrome //g' | tr -d '\n' | tr -d ' ' | cut -d'.' -f1-3 ); export driver_version=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${chrome_version}); wget https://chromedriver.storage.googleapis.com/${driver_version}/chromedriver_linux64.zip; unzip chromedriver_linux64.zip; mv chromedriver ${DRIVER_BIN}; chown root:root ${DRIVER_BIN}; chmod +x ${DRIVER_BIN}


FROM base AS app

RUN chmod 777 /tmp

# RUN chmod -R o+rX /sys/devices
RUN mkdir -p /tmp/chrome && chmod 777 /tmp/chrome


WORKDIR /tmp/chrome
