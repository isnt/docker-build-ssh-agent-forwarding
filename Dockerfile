# syntax=docker/dockerfile:experimental
FROM centos:7

ARG USERNAME=cloner
ARG GIT_SERVER=foo-git-server
ARG GIT_SERVER_PORT=git-port

# Create a user what we will use to clone repos
# Use "--skel /dev/null" to make sure only the home folder gets created
# and specify a fixed UID what we will use to mount the SSH Agent socket
RUN useradd \
	--create-home \
	--skel /dev/null \
	--comment "Cloner user" \
	--uid 2222 \
	${USERNAME}

RUN yum install --assumeyes git

USER ${USERNAME}

WORKDIR /home/${USERNAME}

# Fetch the Git server's public SSH host key
RUN mkdir --parents --mode=0700 ~/.ssh && \
	ssh-keyscan -p ${GIT_SERVER_PORT} ${GIT_SERVER} >> ~/.ssh/known_hosts

# Clone an example repo
# Specify a UID to --mount=type=ssh otherwise the SSH socket will only be
# available for the root user.
# Idea from here: https://github.com/moby/buildkit/issues/760#issuecomment-488727879
RUN --mount=type=ssh,uid=2222 \
	git clone ssh://git@${GIT_SERVER}:${GIT_SERVER_PORT}/foo-project/repo.git
