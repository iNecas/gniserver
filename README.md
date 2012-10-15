# Gem Nice Install server

Provides information on what non-gem dependencies the gem requires so
that it can be installed to your system before the gem.

## Example

```
curl http://gniserver-inecas.rhcloud.com/fedora.yml

basic_build_deps:
  - gcc
  - ruby-devel
gems:
  nokogiri:
    - libxml2-devel
    - libxslt-devel
  sqlite3:
    - sqlite-devel
```
