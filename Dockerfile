FROM envoyproxy/envoy-distroless:v1.33-latest
COPY --chown=0:0 --chmod=755 --from=builder /app/io /usr/local/bin/io
WORKDIR /io
ENTRYPOINT ["/usr/local/bin/io"]
CMD ["io"]
