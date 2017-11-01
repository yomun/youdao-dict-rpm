%global debug_package %{nil}
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}

Name:		youdao-dict
Version:	${VERSION}
Release:	${RELEASE}
Summary:	Youdao Dict (unofficial release, package made by Jason Mun)

Group:		Accessories
License:	Proprietary
URL:		  https://github.com/yomun/youdaodict_5.5
Source:   ${SOURCE}

AutoReqProv:	no

Provides:	youdao-dict = ${VERSION}-${RELEASE}
Provides:	application(youdao-dict.desktop)

Requires:	python%{?_isa}
Requires:	python3-lxml%{?_isa}
Requires:	python3-pillow%{?_isa}
Requires:	python3-qt5%{?_isa}
Requires:	python3-qt5-devel%{?_isa}
Requires:	python3-qt5-webkit%{?_isa}
Requires:	tesseract-devel%{?_isa}

%description
Youdao Dict (unofficial release, package made by Jason Mun <yomun@yahoo.com>)

%prep
%setup -q

%build
echo $RPM_BUILD

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
mv ./* $RPM_BUILD_ROOT/

%post
gtk-update-icon-cache /usr/share/icons/hicolor

%files
%defattr(-,root,root)
/usr/share/icons/hicolor/scalable/apps/youdao-dict.svg
/usr/share/icons/hicolor/16x16/apps/youdao-dict.png
/usr/share/icons/hicolor/24x24/apps/youdao-dict.png
/usr/share/icons/hicolor/48x48/apps/youdao-dict.png
/usr/share/icons/hicolor/64x64/apps/youdao-dict.png
/usr/share/icons/hicolor/96x96/apps/youdao-dict.png
/usr/share/applications/youdao-dict.desktop
/usr/share/dbus-1/services/com.youdao.backend.service
/usr/share/dbus-1/services/com.youdao.indicator.service
/usr/share/doc/youdao-dict/*
/usr/share/youdao-dict/*
/usr/share/youdao-dict
/usr/bin/youdao-dict
/etc/xdg/autostart/youdao-dict-autostart.desktop

%clean
rm -rf $RPM_BUILD_ROOT

%changelog
* Mon Oct 30 2017 Jason Mun <yomun@yahoo.com> - 1.1.1
- First rpm package! :-)
