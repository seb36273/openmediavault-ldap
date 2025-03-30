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
