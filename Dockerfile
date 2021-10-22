FROM opensuse/leap:15

LABEL maintainer="Hugo Rodrigues <hugorodrigues@hugorodrigues.xyz>"
LABEL build_date="2021-10-22"

WORKDIR /github/workspace

RUN zypper install -y rpmdevtools rpm-build

CMD rpmdev-spectool --get-files --all SPECS/*.spec && \
    zypper  install -yn $(rpmspec --parse SPECS/*.spec | grep BuildRequires | awk '{print $2}' | sort | uniq | xargs) && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec
