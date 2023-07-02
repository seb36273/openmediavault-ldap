# Openmediavault LDAP

This plugin connects OMV6 to an OPEN-LDAP Server for centralized user management
and authentification. It adapts the official LDAP plugin [1] for OMV4 to use it
with OMV6 or OMV5.  
Basically there aren't any fundamental changes up to 6.3.5-2 tag. You can use LDAP
for system wide User- and Groupmanagement. Additionally you can activate PAM auth 
with *libpam-ldapd* module. The name switch service is done with *libnss-ldapd*.
For caching actually the NSCD service is used, maybe we should change from NSLCD to 
SSSD in future. A good explanation of the pam auth and nss process will give
you the reference [4].  
The security is enforced at StartTLS or SSL. 
This repo is under development. Checkout the tags in the master branch for stable 
and tested releases. If you encounter some problems make a new issue or write an email
to *devel[at]nareo.de*.  
Be aware: This code was tested in a clean environment with fresh installed OMV6 setup.
I am not responsible for loss of your data! Please make always a full backup
of your OMV machine before installing this plugin!

## Install dependencies

sudo apt install build-essential git curl debhelper libnss-ldap libpam-ldap smbldap-tools

## Get code

cd /usr/local/src

git clone <repository url>


## Build DEBIAN package

Create DEB package with `dpkg-buildpackage -uc -us` inside the
source directory. The \*.deb file will be placed in the parent
directory.

## Install Plugin into Openmediavault 6

Upload the generated \*.deb file to OMV6 plugins and install it. Once it is
installed, you have an additional menu item for LDAP Server settings.

## Testing Environment and Help

The directory *.test* contains some basic config files for test environment
with OMV6. I need someone to test with other LDAP services.

Environment:
* Openmediavault 6.3.5-2 (Shaitan,) with running SAMBA service
* OpenLDAP 2.4.47 server (setup with `smbldap-populate`)
* all smbldap-tools 0.9.9-1 installed on OMV6

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
