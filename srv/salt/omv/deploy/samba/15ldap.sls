{% set config = salt['omv_conf.get']('conf.service.ldap') %}
{% set smb_config = salt['omv_conf.get']('conf.service.smb') %}
{% set smb_config_file = salt['pillar.get']('default:OMV_SAMBA_CONFIG', '/etc/samba/smb.conf') %}

{% if config.enable | to_bool and smb_config.enable | to_bool %}

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
    - name: "smbpasswd -w '{{ config.rootbindpw }}' 2>&1"

{% endif %}
