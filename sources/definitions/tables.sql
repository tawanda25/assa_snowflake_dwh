-- EXTRACT layer: raw/landing tables
DEFINE TABLE {{db}}.EXTRACT.CUSTOMERS_RAW (
    id NUMBER AUTOINCREMENT,
    raw_data VARIANT,
    source_system VARCHAR(100),
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
CHANGE_TRACKING = TRUE
COMMENT = 'Raw customer data';

DEFINE TABLE {{db}}.EXTRACT.MEMBERS_RAW (
    id NUMBER AUTOINCREMENT,
    raw_data VARIANT,
    source_system VARCHAR(100),
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
CHANGE_TRACKING = TRUE
COMMENT = 'Raw members data';

-- STAGE layer: cleansed tables
DEFINE TABLE {{db}}.STAGE.CUSTOMERS_CLEANED (
    id NUMBER,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    staged_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Cleansed customer data';

-- WAREHOUSE layer: modeled tables
DEFINE TABLE {{db}}.WAREHOUSE.DIM_CUSTOMER (
    id NUMBER,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    updated_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
DATA_RETENTION_TIME_IN_DAYS = {{data_retention_days}}
COMMENT = 'Customer dimension table';