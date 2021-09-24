FROM fedora:31

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2021-09-24"

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils spectool dnf-utils && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
