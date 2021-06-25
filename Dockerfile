FROM rockylinux/rockylinux:8

LABEL maintainer="Robert de Bock <robert@meinit.nl>"

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils spectool dnf-utils && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
