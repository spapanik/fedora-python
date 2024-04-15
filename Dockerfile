FROM fedora:39

ENV PYTHON_USER=brian

RUN groupadd --gid 1000 ${PYTHON_USER} && \
    useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${PYTHON_USER} && \
    echo "${PYTHON_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    dnf --assumeyes --nodocs --setopt install_weak_deps=False install gcc python3.12 python3.12-devel pipx && \
    dnf --assumeyes clean all && \
    alternatives --install /usr/bin/python python /usr/bin/python3.12 1

USER ${PYTHON_USER}
ENV PATH="/home/${PYTHON_USER}/.local/bin:${PATH}"
ENV PYTHONPYCACHEPREFIX="/home/${PYTHON_USER}/.cache/pycache/"

RUN pipx install yamk==6.1.0 && \
    pipx install poetry==1.8.2
