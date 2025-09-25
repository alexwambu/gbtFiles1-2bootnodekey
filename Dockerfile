# Minimal test Dockerfile for Render
FROM alpine:latest

WORKDIR /app

# Simple hello test
RUN echo "✅ Render is reading the Dockerfile correctly!" > test.txt

CMD ["cat", "test.txt"]
