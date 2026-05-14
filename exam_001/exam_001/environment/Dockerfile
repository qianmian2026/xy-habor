FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    coreutils \
    gawk \
    grep \
    sed \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create data directory and sample log file
RUN mkdir -p /data /output

# Generate sample access log
RUN echo '192.168.1.100 - - [01/Jan/2024:10:00:00 +0000] "GET /api/users HTTP/1.1" 200 1234' > /data/access.log && \
    echo '192.168.1.101 - - [01/Jan/2024:10:00:01 +0000] "POST /api/login HTTP/1.1" 401 56' >> /data/access.log && \
    echo '192.168.1.100 - - [01/Jan/2024:10:00:02 +0000] "GET /api/products HTTP/1.1" 200 5678' >> /data/access.log && \
    echo '192.168.1.102 - - [01/Jan/2024:10:00:03 +0000] "GET /api/users HTTP/1.1" 200 1234' >> /data/access.log && \
    echo '192.168.1.100 - - [01/Jan/2024:10:00:04 +0000] "DELETE /api/users/1 HTTP/1.1" 404 100' >> /data/access.log && \
    echo '192.168.1.101 - - [01/Jan/2024:10:00:05 +0000] "POST /api/login HTTP/1.1" 200 789' >> /data/access.log && \
    echo '192.168.1.100 - - [01/Jan/2024:10:00:06 +0000] "GET /api/health HTTP/1.1" 200 50' >> /data/access.log && \
    echo '192.168.1.103 - - [01/Jan/2024:10:00:07 +0000] "POST /api/crash HTTP/1.1" 500 0' >> /data/access.log && \
    echo '192.168.1.100 - - [01/Jan/2024:10:00:08 +0000] "GET /api/users HTTP/1.1" 200 1234' >> /data/access.log && \
    echo '192.168.1.102 - - [01/Jan/2024:10:00:09 +0000] "GET /missing HTTP/1.1" 404 0' >> /data/access.log

CMD ["/bin/bash"]
