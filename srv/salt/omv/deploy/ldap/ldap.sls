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
{% set ldap_config_file = salt['pillar.get']('default:OMV_LDAP_CONFIG', '/etc/ldap/ldap.conf') %}
{% set ldap_pam_config_file = salt['pillar.get']('default:OMV_LDAP_PAM_CONFIG', '/etc/pam_ldap.conf') %}
{% set ldap_libnss_config_file = salt['pillar.get']('default:OMV_LDAP_LIBNSS_CONFIG', '/etc/libnss-ldap.conf') %}
{% set ldap_libnss_secret_file = salt['pillar.get']('default:OMV_LDAP_LIBNSS_SECRET', '/etc/libnss-ldap.secret') %}

{% if config.enable | to_bool %}

configure_ldap:
  file.managed:
    - name: {{ ldap_config_file }}
    - source:
      - salt://{{ tpldir }}/files/etc-ldap_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
    - user: root
    - group: root
    - mode: 644

configure_ldap_pam:
  file.managed:
    - name: {{ ldap_pam_config_file }}
    - source:
      - salt://{{ tpldir }}/files/etc-ldap-pam_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
        ldap_version: {{ ldap_version }}
    - user: root
    - group: root
    - mode: 600

configure_ldap_libnss:
  file.managed:
    - name: {{ ldap_libnss_config_file }}
    - source:
      - salt://{{ tpldir }}/files/etc-ldap-libnss_conf.j2
    - template: jinja
    - context:
        config: {{ config | json }}
        ldap_version: {{ ldap_version }}
    - user: root
    - group: root
    - mode: 644

configure_ldap_libnss_passwd:
  file.managed:
    - name: {{ ldap_libnss_secret_file }}
    - contents: |
       {{ config.rootbindpw }}
    - user: root
    - group: root
    - mode: 600

{% endif %}
