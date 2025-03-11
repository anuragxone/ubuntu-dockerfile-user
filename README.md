# Ubuntu Dockerfile (Non Root User Container)

To build a container with non-root user, you can do that by:

```bash
docker build -t ubuntu-nonroot:v1 .
```

To run it (interactive & tty):

```bash
docker run -it ubuntu-nonroot:v1
```
