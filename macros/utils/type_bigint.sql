{%- macro type_bigint() -%}
  {{ adapter.dispatch('type_bigint', packages = ['dbt_utils'])() }}
{%- endmacro -%}