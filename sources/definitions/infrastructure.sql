-- Database per environment
DEFINE DATABASE {{db}};

-- Functional schemas
DEFINE SCHEMA {{db}}.EXTRACT;
DEFINE SCHEMA {{db}}.STAGE;
DEFINE SCHEMA {{db}}.WAREHOUSE;

-- Compute
DEFINE WAREHOUSE ASSA_ENV_WH_{{env}}
WITH
  WAREHOUSE_SIZE = '{{wh_size}}'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  COMMENT = '{{env}} warehouse for ASSA project';