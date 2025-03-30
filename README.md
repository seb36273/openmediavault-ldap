# LDAP Plugin for OpenMediaVault

This plugin connects OpenMediaVault to an LDAP Server for centralized user management
and authentification.

You can use LDAP
for system wide User- and Groupmanagement. Additionally you can activate PAM auth 
with `libpam-ldapd` module. The name switch service is done with `libnss-ldapd`.
For caching actually the NSCD service is used, maybe we should change from NSLCD to 
SSSD in future. A good explanation of the pam auth and nss process will give
you the reference [4].

**Be aware**: This code was tested in a clean environment with fresh installed OpenMediaVault setup.
I am not responsible for loss of your data! Please make always a full backup
of your OpenMediaVault machine before installing this plugin!

## Install Dependencies

`sudo apt install libnss-ldap libpam-ldap smbldap-tools`

## Build DEBIAN package

Install `sudo apt install debhelper`.

Create `.deb` package with `dpkg-buildpackage -uc -us` inside the
source directory. The `.deb` file will be placed in the parent
directory.

## Install Plugin into OpenMediaVault

Upload the generated `.deb` file to OpenMediaVault plugins and install it. Once it is
installed, you have an additional menu item for LDAP Server settings.

## Environment for Testing

* OpenMediaVault 6.9.16-1 (Shaitan) with running SAMBA service
* OpenLDAP 2.4.57+dfsg-3+deb11u1 server (setup with `smbldap-populate`)
* all smbldap-tools 0.9.11-2 installed on OpenMediaVault

## Troubleshooting

If you get in trouble, try:
* update system with `apt-get update` and `apt-upgrade`
* remove all uploaded packages via `omv-firstaid` tool
* remove plugin and reinstall
* change plugin settings
* get omv ldap config with `omv-confdbadm read "conf.service.ldap"`

## References
* [1]  https://github.com/openmediavault
* [2]  https://wiki.debian.org/LDAP/PAM
* [3]  https://linux-club.de/wiki/opensuse/Samba_und_OpenLDAP
* [4]  https://www.debuntu.org/how-to-set-up-a-ldap-server-and-its-clients-page-2/
* [5]  https://deepdoc.at/dokuwiki/doku.php?id=server_und_serverdienste:openldap_mit_samba_als_pdc_neues_backend
