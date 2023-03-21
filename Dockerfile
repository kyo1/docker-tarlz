FROM gcc:12.2.0-bullseye AS builder

# Install requirements
RUN apt-get -y update \
 && apt-get -y install wget lzip gpg \
 && apt-get -y autoremove \
 && apt-get -y clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install lzlib
RUN wget https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.lz \
 && wget https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.lz.sig \
 && gpg --keyserver keyserver.ubuntu.com --recv-key 8FE99503132D7742 \
 && gpg --verify lzlib-1.13.tar.lz.sig \
 && tar --lzip -xvf lzlib-1.13.tar.lz \
 && cd lzlib-1.13 \
 && ./configure CFLAGS='-O2 -Wall -W' \
 && make \
 && make check \
 && make install

# Install tarlz
RUN wget https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.22.tar.lz \
 && tar --lzip -xvf tarlz-0.22.tar.lz \
 && cd tarlz-0.22 \
 && ./configure CXXFLAGS='-O2 -Wall -W -static-libgcc -static-libstdc++' \
 && make \
 && make check \
 && make install

FROM gcr.io/distroless/base-debian11

COPY --from=builder /usr/local/bin/tarlz /usr/local/bin/tarlz

WORKDIR /usr/src

ENTRYPOINT ["tarlz"]
