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

{% set smb_config_file = salt['pillar.get']('default:OMV_SAMBA_CONFIG', '/etc/samba/smb.conf') %}

{% if config.enable | to_bool %}

configure_samba_global_ldap:
  file.append:
    - name: {{ smb_config_file }}
    - sources:
      - salt://{{ tpldir }}/files/global-ldap.j2
    - template: jinja
    - context:
       config: {{ config | json }}
    - watch_in:
      - service: start_samba_service

configure_samba_passwd_ldap:
  cmd.run:
    - name: "smbpasswd -w \"{{ config.rootbindpw }}\" 2>&1"

{% endif %}
