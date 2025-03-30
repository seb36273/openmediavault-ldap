#!/bin/sh

set -e

. /usr/share/openmediavault/scripts/helper-functions

if ! omv_config_exists "/config/services/ldap"; then
	omv_config_add_node "/config/services" "ldap"
	omv_config_add_key "/config/services/ldap" "enable" "0"
	omv_config_add_key "/config/services/ldap" "host" ""
	omv_config_add_key "/config/services/ldap" "port" "389"
	omv_config_add_key "/config/services/ldap" "enablessl" "0"
	omv_config_add_key "/config/services/ldap" "base" ""
	omv_config_add_key "/config/services/ldap" "rootbinddn" ""
	omv_config_add_key "/config/services/ldap" "rootbindpw" ""
	omv_config_add_key "/config/services/ldap" "usersuffix" "ou=Users"
	omv_config_add_key "/config/services/ldap" "groupsuffix" "ou=Groups"
	omv_config_add_key "/config/services/ldap" "machinesuffix" "ou=Computers"
	omv_config_add_key "/config/services/ldap" "idmapsuffix" "ou=idmap"
	omv_config_add_key "/config/services/ldap" "enablepam" "1"
	omv_config_add_key "/config/services/ldap" "extraoptions" ""
	omv_config_add_key "/config/services/ldap" "extraclientoptions" ""
fi

exit 0
