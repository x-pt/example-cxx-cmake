# BUILDING
FROM rockylinux:9 AS builder
LABEL author="X Author Name"
WORKDIR /app

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.cernet.edu.cn/rocky|g' \
         -i.bak \
         /etc/yum.repos.d/rocky-extras.repo \
         /etc/yum.repos.d/rocky.repo && \
    dnf upgrade --refresh -y && \
    dnf groupinstall -y "Development Tools"

# Copy source code
COPY . .

# Build the project
RUN make build

# DEPLOYING STAGE (distroless)
FROM gcr.io/distroless/static-debian12

# Copy the static binary from the builder stage
COPY --from=builder /app/build/bin/example-cxx-cmake /example-cxx-cmake

# Set execution command
CMD ["/example-cxx-cmake"]
