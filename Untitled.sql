-- User for PROD deployments (triggered on push to main)
CREATE USER IF NOT EXISTS GITHUB_ACTIONS_SERVICE_USER
  TYPE = SERVICE
  DEFAULT_ROLE = ACCOUNTADMIN
  DEFAULT_WAREHOUSE = COMPUTE_WH
  COMMENT = 'Service user for GitHub Actions - push to main';

GRANT ROLE ACCOUNTADMIN TO USER GITHUB_ACTIONS_SERVICE_USER;

-- Set OIDC trust for push-to-main events
-- NOTE: Replace the numeric IDs with your actual values from the GitHub error message
ALTER USER GITHUB_ACTIONS_SERVICE_USER SET
  WORKLOAD_IDENTITY = (
    TYPE = OIDC
    ISSUER = 'https://token.actions.githubusercontent.com'
    SUBJECT = 'repo:your-username@OWNER_ID/your-repo@REPO_ID:ref:refs/heads/main'
  );

-- User for DEV/QA deployments (triggered on pull requests)
CREATE USER IF NOT EXISTS GITHUB_ACTIONS_PR_USER
  TYPE = SERVICE
  DEFAULT_ROLE = ACCOUNTADMIN
  DEFAULT_WAREHOUSE = COMPUTE_WH
  COMMENT = 'Service user for GitHub Actions - pull requests';

GRANT ROLE ACCOUNTADMIN TO USER GITHUB_ACTIONS_PR_USER;

-- Set OIDC trust for pull request events
ALTER USER GITHUB_ACTIONS_PR_USER SET
  WORKLOAD_IDENTITY = (
    TYPE = OIDC
    ISSUER = 'https://token.actions.githubusercontent.com'
    SUBJECT = 'repo:your-username@OWNER_ID/your-repo@REPO_ID:pull_request'
  );