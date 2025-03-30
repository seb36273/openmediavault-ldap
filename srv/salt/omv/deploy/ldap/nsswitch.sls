{% set config = salt['omv_conf.get']('conf.service.ldap') %}

configure_ldap_nsswitch_conf:
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
