# bluesky_dbt_optimize

This package is maintained by [Bluesky](https://www.getbluesky.io/) and it allows our customers to dynamically direct dbt models to the optimum warehouse at runtime.

## Installation Instructions

1. Add this package to your `packages.yml` file and run `dbt deps` to install it.

```yaml
packages:
  - git: "https://github.com/getbluesky/bluesky_dbt_optimize.git"
    revision: v1.0.0
```

2. Contact Bluesky to get your organization's unique identification code and add a variable to your `dbt_project.yml` file.
   Replace the ** in the example below with the identification code provided by Bluesky.  Example:  `"BLUESKY_DP0"`

```yaml
vars:
  bluesky_id: "BLUESKY_DP**"
```

3. In your `dbt_project.yml` file, create the pre-hook call in the models section.

```yaml
models:
  +pre-hook:
    sql: "use warehouse {{ bluesky_dbt_optimize.warehouse_selector() }}"
```

4. When these steps are complete, inform your customer success contact and Bluesky will open the data share to provide
   the recommendations at runtime.
