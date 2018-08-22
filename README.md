# MIR-toolbox-docker

This project provides a docker image to run a jupyter notebook server with
essentia, freesound-python and a set of python dependencies commonly used in
Music Information Retrieval (MIR).

## Building

You can build the image by running

    make build

This will build the image and tag it as `mtgupf/mir-toolbox`.
Alternatively, you can pull the latest version of the image from docker hub.

## Running

Run the image with no arguments to start a Notebook server as root:

    docker run --rm -p 8888:8888 mtgupf/mir-toolbox

You can access the notebook at http://localhost:8888, use the password **mir**
to log in.

If you want to access a notebook from your host machine, mount a volume pointing
to `/notebooks` inside the container

    docker run --rm -p 8888:8888 --mount type=bind,source=$(pwd),target=/notebooks mtgupf/mir-toolbox

ensure that the `source` location in the `--mount` option is an absolute path.

### Permissions

On linux, running jupyter-notebook as root means that any new files that you
create will be owned by root. To prevent this from happening, you can set an
environment variable, `JUPYTER_USER_ID` to a UID which will be used to run
the notebook in the container. You can set this to the UID of your local user:

    docker run --rm -e JUPYTER_USER_ID=$(id -u) -p 8888:8888 --mount type=bind,source=$(pwd),target=/notebooks mtgupf/mir-toolbox
