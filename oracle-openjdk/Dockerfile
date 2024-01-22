FROM oraclelinux:8 

LABEL maintainer="Aurelio Garcia-Ribeyro <aurelio.garciaribeyro@oracle.com>"

ENV JAVA_URL=https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL \
	JAVA_HOME=/usr/java/jdk-21 \
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
	rm -rf /var/cache/dnf; \
	ARCH="$(uname -m)" && \
	# Java uses just x64 in the name of the tarball
    if [ "$ARCH" = "x86_64" ]; \
        then ARCH="x64"; \
    fi && \
    JAVA_PKG="$JAVA_URL"/openjdk-21.0.2_linux-"${ARCH}"_bin.tar.gz ; \
	JAVA_SHA256="$(curl -k "$JAVA_PKG".sha256)" ; \ 
	curl -k --output /tmp/jdk.tgz "$JAVA_PKG" && \
	echo "$JAVA_SHA256" */tmp/jdk.tgz | sha256sum -c -; \
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

CMD ["jshell"]
