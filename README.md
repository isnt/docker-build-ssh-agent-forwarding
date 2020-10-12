## A small example of Docker's SSH Agent forwarding capability

* Will use a non-root user to clone a repository over SSH connection using the
  host's SSH agent for authentication
* Requires an SSH Agent on the host machine and Docker engine >=18.09
* A key must be loaded to the SSH agent

### Build

* Override the default ARGs for `GIT_SERVER` and `GIT_SERVER_PORT`
* Set a valid repo URL for the `git clone` command at the end of the
  `Dockerfile`
* Run `docker build`:

```sh
DOCKER_BUILDKIT=1 docker build --ssh default -t agent-forwadring-test .
```

### Sources
* <https://docs.docker.com/develop/develop-images/build_enhancements/>
* <https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066>
