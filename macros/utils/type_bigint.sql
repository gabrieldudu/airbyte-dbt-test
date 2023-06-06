{%- macro type_bigint() -%}
  {{ adapter.dispatch('type_bigint', packages = dbt_utils._get_utils_namespaces())() }}
{%- endmacro -%}