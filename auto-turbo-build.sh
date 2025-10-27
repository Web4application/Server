#!/bin/bash
# turbo-build.sh - optimized Go build

# Exit immediately if a command fails
set -e

# Use all available CPU cores for parallel builds
export GOMAXPROCS=$(nproc)

# Use persistent build cache to avoid recompiling unchanged packages
export GOCACHE=${GOCACHE:-$HOME/.cache/go-build}

# Optional: Use shared module cache for multiple projects
export GOMODCACHE=${GOMODCACHE:-$HOME/.cache/go-mod}

echo "=============================="
echo "Starting Turbo Build..."
echo "GOMAXPROCS=$GOMAXPROCS"
echo "GOCACHE=$GOCACHE"
echo "GOMODCACHE=$GOMODCACHE"
echo "=============================="

# Pre-download all dependencies (avoids network fetch during build)
echo "Downloading dependencies..."
go mod download

# Build your project incrementally with trimmed paths
echo "Building project..."
go build -trimpath -o bin/myapp ./...

# Optional: install globally
echo "Installing binary..."
go install -trimpath ./...

echo "=============================="
echo "Turbo Build Completed Successfully!"
date
echo "=============================="

GOMAXPROCS=$(( $(nproc) / 2 )) \
GOCACHE=${GOCACHE:-$HOME/.cache/go-build} \
GOMODCACHE=${GOMODCACHE:-$HOME/.cache/go-mod} \
echo "Downloading dependencies..." && go mod download && \
echo "Building project (slim mode)..." && go build -trimpath -o bin/myapp ./... && \
echo "Installing binary..." && go install -trimpath ./... && \
echo "Slim Turbo Build Completed!" && date



$ go clean -cache -modcache
$ /bin/time -v go install .
go: downloading cloud.google.com/go/translate v1.12.7
go: downloading google.golang.org/protobuf v1.36.9
go: downloading github.com/spf13/cobra v1.10.1
go: downloading cloud.google.com/go v0.121.6
go: downloading github.com/spf13/pflag v1.0.9
go: downloading google.golang.org/api v0.247.0
go: downloading github.com/googleapis/gax-go/v2 v2.15.0
go: downloading cloud.google.com/go/longrunning v0.6.7
go: downloading google.golang.org/genproto v0.0.0-20250603155806-513f23925822
go: downloading google.golang.org/grpc v1.74.2
go: downloading google.golang.org/genproto/googleapis/api v0.0.0-20250818200422-3122310a409c
go: downloading google.golang.org/genproto/googleapis/rpc v0.0.0-20250818200422-3122310a409c
go: downloading golang.org/x/net v0.43.0
go: downloading golang.org/x/sys v0.35.0
go: downloading golang.org/x/text v0.28.0
go: downloading cloud.google.com/go/auth v0.16.4
go: downloading golang.org/x/oauth2 v0.31.0
go: downloading go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.61.0
go: downloading golang.org/x/time v0.12.0
go: downloading cloud.google.com/go/compute/metadata v0.8.0
go: downloading cloud.google.com/go/auth/oauth2adapt v0.2.8
go: downloading go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.61.0
go: downloading golang.org/x/sync v0.16.0
go: downloading github.com/google/s2a-go v0.1.9
go: downloading github.com/googleapis/enterprise-certificate-proxy v0.3.6
go: downloading go.opentelemetry.io/otel v1.36.0
go: downloading go.opentelemetry.io/otel/metric v1.36.0
go: downloading go.opentelemetry.io/otel/trace v1.36.0
go: downloading github.com/felixge/httpsnoop v1.0.4
go: downloading golang.org/x/crypto v0.41.0
go: downloading go.opentelemetry.io/auto/sdk v1.1.0
go: downloading github.com/go-logr/stdr v1.2.2
go: downloading github.com/go-logr/logr v1.4.3
        Command being timed: "go install ."
        User time (seconds): 142.75
        System time (seconds): 21.69
        Percent of CPU this job got: 239%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:08.62
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 224736
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 14
        Minor (reclaiming a frame) page faults: 2956930
        Voluntary context switches: 179979
        Involuntary context switches: 66098
        Swaps: 0
        File system inputs: 778
        File system outputs: 1589064
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 

#!/bin/bash
# Ultra-Slim Auto Build for Go Projects

set -e

echo "=============================="
echo "Starting Ultra-Slim Auto Build..."
echo "Detecting system resources..."
CPU_CORES=$(nproc)
TOTAL_RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
TOTAL_RAM_MB=$((TOTAL_RAM_KB / 1024))

# Decide optimal GOMAXPROCS based on RAM
# Rough estimate: 500MB RAM per core for heavy builds
MAX_CORES_RAM=$((TOTAL_RAM_MB / 500))
if [ $MAX_CORES_RAM -lt 1 ]; then
  MAX_CORES_RAM=1
fi
GOMAXPROCS=$(( CPU_CORES < MAX_CORES_RAM ? CPU_CORES : MAX_CORES_RAM ))

export GOMAXPROCS
export GOCACHE=${GOCACHE:-$HOME/.cache/go-build}
export GOMODCACHE=${GOMODCACHE:-$HOME/.cache/go-mod}

echo "CPU cores: $CPU_CORES"
echo "Total RAM: ${TOTAL_RAM_MB}MB"
echo "GOMAXPROCS set to: $GOMAXPROCS"
echo "GOCACHE: $GOCACHE"
echo "GOMODCACHE: $GOMODCACHE"
echo "=============================="

echo "Downloading dependencies..."
go mod download

echo "Building project with trimpath..."
go build -trimpath -o bin/myapp ./...

echo "Installing binary..."
go install -trimpath ./...

echo "=============================="
echo "Ultra-Slim Auto Build Completed Successfully!"
date
echo "=============================="

