FROM oraclelinux:8 

LABEL maintainer="Aurelio Garcia-Ribeyro <aurelio.garciaribeyro@oracle.com>"

ENV	JAVA_HOME=/usr/java/jdk-17 \
	LANG=en_US.UTF-8
	

# If you need the Java Version you can read it from the release file with 
#JAVA_VERSION=$(sed -n '/^JAVA_VERSION="/{s///;s/"//;p;}' "$JAVA_HOME"/release);
	
ENV	PATH $JAVA_HOME/bin:$PATH
	
# Since the files are compressed as tar.gz first dnf install tar. gzip is already in oraclelinux:8
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN set -eux; \
        yum-config-manager --setopt=sslverify=false --save; \
	dnf -y update; \
	dnf install -y \
		tar \
		# JDK assumes freetype is available		
		freetype fontconfig \
	; \
	rm -rf /var/cache/dnf;

RUN set -eux; \
    ARCH="$(uname -m)" && \
	# Java uses just x64 in the name of the tarball
    if [ "$ARCH" = "x86_64" ]; \
        then ARCH="x64"; \
    fi && \
    API_URL=https://api.adoptium.net/v3/binary/latest/17/ga/linux/$ARCH/jdk/hotspot/normal/eclipse ; \
    #FETCH_URL=$(curl -k -s -w %{redirect_url} "${API_URL}") ; \
    #echo "Fetching JDK from ${FETCH_URL}" ; \
    curl -k -Ls --output /tmp/jdk.tgz "${API_URL}" ; \
    # JAVA_SHA256=$(curl -Ls "${FETCH_URL}.sha256.txt") ; \ 
    # echo "$JAVA_SHA256" */tmp/jdk.tgz | sha256sum -c -; \
	mkdir -p "$JAVA_HOME"; \
	tar --extract --file /tmp/jdk.tgz --directory "$JAVA_HOME" --strip-components 1; \
	rm /tmp/jdk.tgz

RUN ln -sfT "$JAVA_HOME" /usr/java/default; \
	ln -sfT "$JAVA_HOME" /usr/java/latest; \
	for bin in "$JAVA_HOME"/bin/*; do \
		base="$(basename "$bin")"; \
		[ ! -e "/usr/bin/$base" ]; \
		alternatives --install "/usr/bin/$base" "$base" "$bin" 20000; \
	done; 

COPY src /opt

#RUN yum localinstall -y /tmp/src/*.rpm
RUN yum install -y libXext libXrender libXtst file

RUN echo SetJavaHome /usr/java/default >> /opt/sqldeveloper/sqldeveloper/bin/sqldeveloper.conf

CMD ["/opt/sqldeveloper/sqldeveloper.sh"]

