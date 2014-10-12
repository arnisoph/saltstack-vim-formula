#!jinja|yaml

{% from "vim/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('vim:lookup')) %}

vim:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}

{% for u in salt['pillar.get']('vim:config:manage:users', []) %}
vimrc_{{ u }}:
  file:
    - managed
    - name: {{ salt['user.info'](u).home ~ '/.vimrc' }}
    - source: salt://vim/files/vimrc
    - mode: 644
    - user: {{ u }}
    - group: {{ u }}
{% endfor %}
