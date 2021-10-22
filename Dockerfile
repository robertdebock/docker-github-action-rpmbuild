FROM rockylinux/rockylinux:8

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2021-10-22"

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils dnf-utils epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled powertools && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
