# Openmediavault LDAP

This plugin connects to an OPEN-LDAP Server for centralized user management
and authentification. It adapts the official LDAP plugin for OMV4 to use it
with OMV5.  
Basically there aren't any fundamental changes yet. Actually it uses
PAM auth with *libnss-ldapd* as default. I will switch to the *libpam-ldapd*
later on. Maybe we should use PAM auth with SSSD in future.  
This repo is under development. Checkout the master branch for stable 
releases. If you encounter some problems make a new issue or write an email
to *devel[at]nareo.de*.  
I am not responsible for loss of data. Please
make always a full backup of your OMV machine before installing this plugin!

## Build DEBIAN package

Create DEB package with `dpkg-buildpackage -uc -us` inside the
source directory. The \*.deb file will be placed in the parent
directory.

## Install Plugin into Openmediavault 5

Upload the generated \*.deb file to OMV5 plugins and install it. Once it is
installed, you have an additional menu item for LDAP Server settings.

## Testing Environment and Help

The directory *.test* contains some basic config files for test environment
with OMV5. I need someone to test with other LDAP services.

remove all uploaded packages via `omv-firstaid` tool  
get omv ldap config with `omv-confdbadm read "conf.service.ldap"`  

## Sources
* https://github.com/openmediavault
* https://wiki.debian.org/LDAP/PAM
* https://linux-club.de/wiki/opensuse/Samba_und_OpenLDAP
