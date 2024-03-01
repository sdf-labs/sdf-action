{% macro create_domain_udfs() %}
{% set sql %}
create or replace function dbt_hol_dev.public.getdomain(url string)
    returns string
    language python
    runtime_version = '3.8'
    packages =(
        'tldextract==3.2.0'
    )
    handler = 'getdomain_py'
    as
    $$
    import tldextract
    import urllib.parse

    def getdomain_py(url):
      try:
        result = tldextract.extract(urllib.parse.unquote(url))
        if result.domain:
          if result.suffix:
            return result.domain + "." + result.suffix
          return result.domain
        return ""
      except: 
        return ""
$$;
create or replace function dbt_hol_dev.public.getprotocol(url string)
    returns string
    language python
    runtime_version = '3.8'
    packages =(
        'tldextract==3.2.0'
    )
    handler = 'getprotocol'
    as
    $$
    import tldextract
    import urllib.parse

    def getprotocol(url):
      try:
        return urllib.parse.urlparse(urllib.parse.unquote(url))
      except: 
        return ""
$$;
{% endset %}
{{ sql }}
{% endmacro %}
