FROM ubuntu:22.04

WORKDIR /home/toolchain

# Install required packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    git \
    openssh-client \ 
    libncurses5 \
    curl \
    dos2unix \
    python-is-python3 \
    python3.10 \
    python3.10-venv \
    libpython3.10 \
    libpython3.10-dev \
    ca-certificates \
    wget \
    tar \
    xz-utils \
    cmake \
    make \
    gcc \
    g++ \
    musl-dev \
    && wget https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar -xf arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && rm arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && wget --post-data "accept_license_agreement=accepted&submit=Download+software" \
    		"https://www.segger.com/downloads/jlink/JLink_Linux_V812b_x86_64.tgz" -O JLink_Linux.tgz \
    && tar xzf JLink_Linux.tgz -C /opt/ \
    && rm JLink_Linux.tgz \
    && wget -O APFW0002-app-release-exec-linux-SE_FW_1.104.00_DEV.tar https://alifsemi.com/download/APFW0002 \
    && tar -xvf APFW0002-app-release-exec-linux-SE_FW_1.104.00_DEV.tar \
    && rm APFW0002-app-release-exec-linux-SE_FW_1.104.00_DEV.tar \
    && apt-get remove -y wget xz-utils gcc g++ musl-dev \
    && apt-get autoremove -y \
    && apt-get clean

ENV PATH=$PATH:/home/toolchain/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin
ENV PATH=$PATH:/opt/JLink_Linux_V812b_x86_64
ENV PATH=$PATH:/home/toolchain/app-release-exec-linux

CMD ["/bin/bash"]

