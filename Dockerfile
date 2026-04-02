FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Dependências básicas
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    git \
    nodejs \
    npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Solana CLI
RUN sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Anchor (via AVM)
RUN cargo install --git https://github.com/coral-xyz/anchor avm --force && \
    avm install latest && \
    avm use latest

# Criar diretório de trabalho
WORKDIR /workspace

# Mantém container interativo
CMD ["bash"]
