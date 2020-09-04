# This file is part of OpenMediaVault.
#
# @license   http://www.gnu.org/licenses/gpl.html GPL Version 3
# @author    Volker Theile <volker.theile@openmediavault.org>
# @copyright Copyright (c) 2009-2020 Volker Theile
#
# OpenMediaVault is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# OpenMediaVault is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with OpenMediaVault. If not, see <http://www.gnu.org/licenses/>.

{% set config = salt['omv_conf.get']('conf.service.ldap') %}

prereq_ldap:
  salt.state:
    - tgt: '*'
    - sls: omv.deploy.ldap

prereq_nss:
  salt.state:
    - tgt: '*'
    - sls: omv.deploy.nss

{% if config.enable | to_bool and config.enablepam | to_bool %}

configure_pam_ldap:
  file.managed:
    - name: "/etc/pam_ldap.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-pam-ldap_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
    - user: root
    - group: root
    - mode: 600

configure_pam_ldap_passwd:
  file.managed:
    - name: "/etc/pam_secret.conf"
    - contents: |
       {{ config.rootbindpw }}
    - user: root
    - group: root
    - mode: 600

activate_pam_ldap_auth:
  cmd.run:
    - name: "pam-auth-update --force --package ldap"

{% else %}

deactivate_pam_ldap_auth:
  cmd.run:
    - name: "pam-auth-update --force --package --remove ldap"

remove_pam_ldap:
  file.absent:
    - name: "/etc/pam_ldap.conf"

remove_pam_ldap_passwd:
  file.absent:
    - name: "/etc/pam_secret.conf"

{% endif %}