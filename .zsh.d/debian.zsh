rbuilddep() {
    grep-dctrl -sPackage -i -r -F Build-Depends,Build-Depends-Indep "\b$1\b" \
            /var/lib/apt/lists/*_Sources \
        | awk '{ print $2 }' \
        | sort \
        | uniq
}

alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"

# Review Release-Critical bugs
rcal() {
  rc-alert --exclude-tags 'SH+PI' -d TU | vim -
}

# Show most recent build log, a la debi/debc
deblog() {
  local pkg=$(dpkg-parsechangelog | grep '^Source:' | awk '{print $2}')
  local ver=$(dpkg-parsechangelog | grep '^Version:' | awk '{print $2}'| cut -d: -f2)
  local arch=$(dpkg-architecture -qDEB_HOST_ARCH)
  view ../${pkg}_${ver}_${arch}.build
}

quilt-mv() {
  quilt add $1
  quilt add $2
  mv $1 $2
}

svn-bc() {
    svn-buildpackage \
        --svn-builder='pdebuild --pbuilder cowbuilder --buildresult ..' \
        --svn-lintian \
        "$@"
}

gbp-exp-base () {
    git-buildpackage \
        --git-debian-branch=experimental \
        --git-upstream-branch=upstream-experimental \
        "$@"
}

gbp-exp-nc () {
    gbp-exp-base \
        -uc -us \
        "$@"
}

gbp-exp () {
    gbp-exp-nc \
        --git-pbuilder \
        "$@"
}

gbp-exp-up () {
    gbp-exp-base \
        -S -sa \
        "$@"
}
