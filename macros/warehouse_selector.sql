{% macro warehouse_selector() %}

     {%- set is_query_redirect_on = false -%}
     {%- set model_name = model.name -%}
     {%- set warehouse_recommendation = target.warehouse -%}
     {%- set bluesky_id = "BLUESKY_DP" -%}

     {%- set bluesky_id = var('bluesky_id') -%}   

     {%- set results = run_query("select recommended_wh, is_query_redirect_on from " ~ bluesky_id ~ ".public.dbt_model_to_warehouse where output_model_name = '" ~ model_name ~ "'") -%}

     {%- if results|length > 0 -%}
        {%- set warehouse_recommendation = results.columns[0].values()[0] -%}
        {%- set is_query_redirect_on = results.columns[1].values()[0] -%}
     {%- endif -%}

     {%- set base_tag = {
        "app": "dbt", 
        "model_name" : model_name,
        "current_warehouse": target.warehouse,
        "warehouse_recommendation": warehouse_recommendation,
        "bluesky_id": bluesky_id,
        "is_query_redirect_on": is_query_redirect_on
    } -%}

     {%- set new_query_tag = tojson(base_tag) -%}
     {%- do run_query("alter session set query_tag = '{}'".format(new_query_tag)) -%}
    
     {%- if is_query_redirect_on -%}
        {%- do return(warehouse_recommendation) -%}
     {%- endif -%}

     {%- do return(target.warehouse) -%}

{% endmacro %}