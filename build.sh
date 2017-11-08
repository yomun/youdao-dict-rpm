#!/usr/bin/env bash
#
# Author: Jason Mun <yomun@yahoo.com>
# https://github.com/yomun/youdaodict_5.5
#
# sudo apt install rpm
# bash build.sh
# sudo rpm -i youdao-dict-1.1.1-0.x86_64.rpm

set -e
set -x

# Prepare 'youdao-dict.temp.spec' & 'youdao-dict' (file replace of /usr/bin/youdao-dict)
PATH_DATA="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEB="youdao-dict_1.1.1-0~ubuntu_amd64.deb"
DEB_URL="https://github.com/yomun/youdaodict_5.5/raw/master/${DEB}"
SPEC="youdao-dict.spec"
NAME="youdao-dict"
VERSION="1.1.1"
RELEASE="0"
ARCH="x86_64"
SEMIDIR="${NAME}-${VERSION}"
FULLDIR="${SEMIDIR}-${RELEASE}.${ARCH}"

# Prepare a space to ready the Source
rm -rf "tmp-${ARCH}"
mkdir -p "tmp-${ARCH}"
cd tmp-${ARCH}

# Prepare SPEC
cp -rv "${PATH_DATA}/youdao-dict.temp.spec" "${SPEC}"
sed -i "s/\${VERSION}/${VERSION}/g" "${SPEC}"
sed -i "s/\${RELEASE}/${RELEASE}/g" "${SPEC}"
sed -i "s/\${ARCH}/${ARCH}/g" "${SPEC}"
sed -i "s/\${SOURCE}/${SEMIDIR}.tar.gz/g" "${SPEC}"

# Download DEB
rm -rf "${DEB}"
wget "${DEB_URL}"

# Extract DEB
ar xf "${DEB}"
tar xvf "data.tar.xz" .

mkdir -p "{$SEMIDIR}"
mkdir -p "${SEMIDIR}/usr/bin"
cp -R usr "${SEMIDIR}/"
cp -R etc "${SEMIDIR}/"

# The Original /usr/bin/youdao-dict is a System Link
rm -rf "${SEMIDIR}/usr/bin/youdao-dict"
install -m 755 "${PATH_DATA}/youdao-dict" "${SEMIDIR}/usr/bin/youdao-dict"

# Prepare the Source Done..
tar zcvf "${SEMIDIR}.tar.gz" "${SEMIDIR}"

mkdir -p "${HOME}/rpmbuild/SOURCES"
mkdir -p "${HOME}/rpmbuild/SPECS"

cp "${SEMIDIR}.tar.gz" "${HOME}/rpmbuild/SOURCES/"
cp "${SPEC}" "${HOME}/rpmbuild/SPECS/"

# Build RPM
fakeroot rpmbuild -ba "${SPEC}" --target "${ARCH}"

cp "${HOME}/rpmbuild/RPMS/${ARCH}/${FULLDIR}.rpm" "${HOME}"

# Clear
rm -rf "tmp-${ARCH}"

rm -rf "${HOME}/rpmbuild/BUILD/${SEMIDIR}"
rm -rf "${HOME}/rpmbuild/RPMS/${ARCH}"
rm -rf "${HOME}/rpmbuild/SOURCES/${SEMIDIR}.tar.gz"
rm -rf "${HOME}/rpmbuild/SPECS/${SPEC}"
rm -rf "${HOME}/rpmbuild/SRPMS/${SEMIDIR}-${RELEASE}.src.rpm"
