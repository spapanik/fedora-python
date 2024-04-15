FROM fedora:40

ENV PYTHON_USER=brian

RUN groupadd --gid 1000 ${PYTHON_USER} && \
    useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${PYTHON_USER} && \
    echo "${PYTHON_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    dnf makecache --refresh && \
    dnf --assumeyes --nodocs --setopt install_weak_deps=False install \
    git gcc python python-devel pipx && \
    dnf --assumeyes clean all

USER ${PYTHON_USER}
ENV PATH="/home/${PYTHON_USER}/.local/bin:${PATH}"
ENV PYTHONPYCACHEPREFIX="/home/${PYTHON_USER}/.cache/pycache/"

RUN pipx install yamk==7.0.0 && \
    pipx install phosphorus==0.3.0
