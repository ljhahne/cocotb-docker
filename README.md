# cocotb-docker

Simple multi-arch cocotb Docker image for arm and amd based systems. [cocotb-test](https://github.com/themperek/cocotb-test) and [pytest-xdist](https://github.com/pytest-dev/pytest-xdist) are also included.

The image can be build via `docker buildx`:

```bash
docker buildx build --build-arg NJOBS=$(nproc) --push --platform linux/arm64,linux/amd64 -t ghcr.io/$USER/$IMAGE .
```
