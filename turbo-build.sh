
#!/bin/bash
# turbo-build.sh

# Limit CPU cores (optional, use all if unset)
export GOMAXPROCS=${GOMAXPROCS:-$(nproc)}

# Enable Go build cache
export GOCACHE=${GOCACHE:-$HOME/.cache/go-build}

# Pre-download all dependencies to avoid network fetch during build
echo "Downloading dependencies..."
go mod download

# Build only what changed, trim paths for reproducibility
echo "Building project..."
go build -trimpath -o bin/myapp ./...

# Optional: install to GOPATH/bin for global usage
echo "Installing binary..."
go install -trimpath ./...

echo "Build completed in $(date)"

$ go clean -cache -modcache
$ /bin/time -v go install .
go: downloading github.com/agentio/sidecar v0.1.12
go: downloading google.golang.org/protobuf v1.36.9
go: downloading github.com/spf13/cobra v1.10.1
go: downloading github.com/spf13/pflag v1.0.9
        Command being timed: "go install ."
        User time (seconds): 76.02
        System time (seconds): 10.45
        Percent of CPU this job got: 688%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:12.56
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 225280
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 11
        Minor (reclaiming a frame) page faults: 1554340
        Voluntary context switches: 87486
        Involuntary context switches: 23776
        Swaps: 0
        File system inputs: 712
        File system outputs: 264712
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
