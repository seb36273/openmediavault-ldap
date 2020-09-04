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
{% set ldap_version = salt['pillar.get']('default:OMV_LDAP_LDAPVERSION', '3') %}

configure_nsswitch:
  file.managed:
    - name: "/etc/nsswitch.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-nsswitch_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
    - user: root
    - group: root
    - mode: 644

{% if config.enable | to_bool and config.enablepam | to_bool %}

configure_libnss:
  file.managed:
    - name: "/etc/libnss-ldap.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-libnss_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
        ldap_version: {{ ldap_version }}
    - user: root
    - group: root
    - mode: 644

configure_libnss_passwd:
  file.managed:
    - name: "/etc/libnss-ldap.secret"
    - contents: |
       {{ config.rootbindpw }}
    - user: root
    - group: root
    - mode: 600

configure_nslcd:
  file.managed:
    - name: "/etc/nslcd.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-nslcd_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
        ldap_version: {{ ldap_version }}
    - user: root
    - group: root
    - mode: 600

configure_nscd:
  file.managed:
    - name: "/etc/nscd.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-nscd_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
    - user: root
    - group: root
    - mode: 644

{% else %}

remove_nsswitch_ldap:
  file.absent:
    - name: "/etc/nsswitch.conf"

remove_libnss_ldap:
  file.absent:
    - name: "/etc/libnss-ldap.conf"

remove_libnss_ldap_passwd:
  file.absent:
    - name: "/etc/libnss-ldap.secret"

remove_nslcd:
  file.absent:
    - name: "/etc/nslcd.conf"

remove_nscd:
  file.absent:
    - name: "/etc/nscd.conf"

{% endif %}