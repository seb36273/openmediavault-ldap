{% set config = salt['omv_conf.get']('conf.service.ldap') %}

configure_pam_ldap_trigger:
  cmd.run:
    {% if config.enable | to_bool and config.enablepam | to_bool %}
    - name: "pam-auth-update --force --package ldap"
    {% else %}
    - name: "pam-auth-update --force --package --remove ldap"
    {% endif %}
