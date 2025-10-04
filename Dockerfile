FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl unzip less groff python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Download & install Amazon Q CLI
RUN curl --proto '=https' --tlsv1.2 -sSf "https://desktop-release.q.us-east-1.amazonaws.com/latest/q-x86_64-linux.zip" -o "q.zip" && \
    unzip q.zip && \
    chmod +x ./q/install.sh && \
    ./q/install.sh --no-confirm --force && \
    rm -rf q.zip q && \
    QPATH=$(find / -name q -type f 2>/dev/null | head -n 1) && \
    echo "Q binary installed at: $QPATH" && \
    ln -sf "$QPATH" /usr/local/bin/q

WORKDIR /root

CMD ["bash"]
