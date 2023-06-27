# s6-overlay-showcase

The `s6-overlay-showcase` project is a demonstration of how to use the [s6-overlay](https://github.com/just-containers/s6-overlay) in a Docker container. The project also includes a Go application that uses the [chi](https://github.com/go-chi/chi) router, returning system variables when the root route is accessed.

## Application

The Go application is a simple web server that listens on port 3000. When you access the root ("/") route, it returns the system's environment variables. The application is built using Go modules, and utilizes the chi router.

## Building

You can build the project using `make`. The Makefile has several commands:

- `make build`: Compiles the Go application and places the binary in the `.targets` directory.
- `make docker_build`: Builds the Docker image. You can specify the architecture using the `ARCH` parameter. For example, `make docker_build ARCH=aarch64`.
- `make docker_push`: Pushes the Docker image to a Docker registry. The image version can be specified with the `VERSION` parameter. For example, `make docker_push VERSION=1.0.0`.

## Dockerfile

The Dockerfile uses a multi-stage build. The first stage compiles the Go application in a builder container. The second stage is based on a Docker image with the s6-overlay preinstalled, and the Go binary is copied into this image. The architecture of the binary is determined by the `ARCH` build argument.

## GitHub Actions

The GitHub Actions workflow is triggered when you push a tag or merge to the master branch. When a tag is pushed, the tag (minus any leading "v") is used as the image version. When merged to master, "latest" is used as the image version. The workflow builds and pushes the Docker image using Docker's buildx action, which supports building multi-platform images.

## Helm Chart

The project includes a Helm chart for deploying the application to a Kubernetes cluster. The `values.yaml` file contains a map of environment variables (`app.env`), which are transformed into a Kubernetes Secret by the chart. The keys in the `app.env` map correspond to the filenames in the Secret, and the values correspond to the file contents.

## License

This project is open source and available under the MIT License. See the LICENSE file for more details.
