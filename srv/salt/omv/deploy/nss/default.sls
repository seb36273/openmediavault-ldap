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

{% set dirpath = '/srv/salt' | path_join(tpldir) %}

include:
{% for file in salt['file.find'](dirpath, iname='*.sls', print='name') | difference(['init.sls', 'default.sls']) %}
  - .{{ file | replace('.sls', '') }}
{% endfor %}

{% set config = salt['omv_conf.get']('conf.service.ldap') %}

{% if config.enable | to_bool and config.enablepam | to_bool %}

start_nss_service_nslcd:
  service.running:
    - name: nslcd
    - enable: True
    - require:
      - file: "/etc/nslcd.conf"

start_nss_service_nscd:
  service.running:
    - name: nscd
    - enable: True
    - require:
      - file: "/etc/nscd.conf"

{% else %}

stop_nss_service_nslcd:
  service.dead:
    - name: nslcd
    - enable: False

stop_nss_service_nscd:
  service.dead:
    - name: nscd
    - enable: False

{% endif %}