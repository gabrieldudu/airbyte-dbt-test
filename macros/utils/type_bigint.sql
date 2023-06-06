{%- macro type_bigint() -%}
  {{ adapter.dispatch('type_bigint', packages = ['dbt_utils'])() }}
{%- endmacro -%}



{%- macro postgres__type_bigint() -%}
  {{ adapter.dispatch('postgres__type_bigint', packages = ['dbt_utils'])() }}
{%- endmacro -%}