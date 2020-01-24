FROM centos:8

WORKDIR /github/workspace

RUN dnf install -y rpmdevtools dnf-utils spectool && \
    dnf clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec ; rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
