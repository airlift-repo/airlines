# local build
# FROM airbase:18.11.01

# docker hub build:
FROM airlift/airbase

MAINTAINER King Shaw "kings@amazon.com"

# TODO: VERSION should come from 'tag' in Makefile?

ENV SDKROOT="/sandbox" VERSION="18.11.01"

ENV PYTHONPATH=".:./release/airtime:./release/mcAir:../release/airtime:../release/mcAir:../../release/airtime:../../release/mcAir:$SDKROOT/release/airtime:$SDKROOT/release/mcAir"

ENV CLASSPATH=".:./release/mainLog:../release/mainLog:../../release/mainLog:$SDKROOT/release/mainLog:$SDKROOT/tools/antlrlib/antlr-4.7.1-complete.jar"

ENV PATH=".:./tools:../tools:../../tools:$SDKROOT/tools:./release/mcAir:../release/mcAir:../../release/mcAir:$SDKROOT/release/mcAir:$PATH"

# TODO: base.version?

LABEL base.name="airlines" base.version='0.1'

WORKDIR "$SDKROOT/workspace"

USER root

RUN     \
    chown -R $NB_USER:users $SDKROOT    && \
    chmod -R a+rw $SDKROOT

COPY start-airtime.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/start-airtime.sh

# Expose ports

EXPOSE 8888

ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-airtime.sh"]





# 
# $ docker build -t airlines .
# 

## Run in a container, and 
## mount the volume 'vol_workspace' on /sandbox/workspace,
## mount the volume 'vol_releases' on /sandbox/releases of the image
## 
## The data in volumes will be persistent, indepedent of the life cycle of this container.

# OK:
# 
# $	docker volume create --name vol_workspace
# $	docker volume create --name vol_releases
# $	docker run --rm -p 80:8888 -e NB_USER=ubuntu \
#		-v vol_releases:/sandbox/releases 	\
#		-v vol_workspace:/sandbox/workspace \
#		airlines


# To back up the volume (any time and via any container):
# $ docker run --rm -v vol_workspace:/volume -v `pwd`/backup:/backup  alpine sh -c 'cp -r /volume /backup'

# Launch with a different user
# $ docker run ..... -e NB_USER=ubuntu ...
