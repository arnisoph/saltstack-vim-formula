{% from "vim/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('vim:lookup')) %}

vim:
  pkg:
    - installed
    - pkgs:
{% for p in datamap['pkgs'] %}
      - {{ p }}
{% endfor %}
