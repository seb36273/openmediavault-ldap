{% set dirpath = '/srv/salt' | path_join(tpldir) %}

include:
{% for file in salt['file.find'](dirpath, iname='*.sls', print='name') | difference(['init.sls', 'default.sls']) %}
  - .{{ file | replace('.sls', '') }}
{% endfor %}
