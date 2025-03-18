-- creating_a_GitHub_repository_stage.DMAS.PUBLIC.sql   --      Creating a GitHub repository stage
--
-- Reference:
--      https://docs.snowflake.com/developer-guide/git/git-setting-up: https://docs.snowflake.com/developer-guide/git/git-setting-up
--
-- Partameter:
--      DMAS                            : Database
--      PUBLIC                          : schema
--      MBASUL                          : GitHub-User (eg. MBASUL)
--      <github_password>               : GitHub-Password
--      https://github.com/mbasul       : URL
--      DMAS                            : Repository (e.g. Learn_SN)

-- ===========================================================================================
-- Create a secret with credentials for authenticating
use role SECURITYADMIN;
--   ROLE    --   SNGIT_ADMIN_SECRET   -----------------------------------
create role if not exists SNGIT_ADMIN_SECRET;
grant create secret on schema DMAS.PUBLIC to role SNGIT_ADMIN_SECRET;
-- revoke create secret on schema DMAS.PUBLIC from role SNGIT_ADMIN_SECRET;
grant role SNGIT_ADMIN_SECRET to role SECURITYADMIN;

use role ACCOUNTADMIN;
grant usage on database DMAS to role SNGIT_ADMIN_SECRET;
grant usage on schema DMAS.PUBLIC to role SNGIT_ADMIN_SECRET;

-- ---------------------------------------------------------------------------------
use role SNGIT_ADMIN_SECRET;
use database DMAS;
use schema DMAS.PUBLIC;

--   SECRET  --   SNGIT_GITHUB_SECR_MBASUL  ------------------------------
create or replace secret SNGIT_GITHUB_SECR_MBASUL
    type = password
    username = 'MBASUL'
    password = 'OluNF0oPDMQo#jbqYJml'
;
-- drop secret SNGIT_GITHUB_SECR_MBASUL;
show secrets;


-- ===========================================================================================
use role SECURITYADMIN;
--   ROLE    --   SNGIT_ADMIN_GIT   --------------------------------------
create role if not exists SNGIT_ADMIN_GIT;
use role ACCOUNTADMIN;
grant create integration on account to role SNGIT_ADMIN_GIT;
grant usage on database DMAS to role SNGIT_ADMIN_GIT;
grant usage on schema DMAS.PUBLIC to role SNGIT_ADMIN_GIT;
grant role SNGIT_ADMIN_GIT to role ACCOUNTADMIN;

use role SNGIT_ADMIN_SECRET;
grant usage on secret SNGIT_GITHUB_SECR_MBASUL to role SNGIT_ADMIN_GIT;
-- revoke role SNGIT_ADMIN_GIT from role SYSADMIN;

use role SNGIT_ADMIN_GIT;
--   INTEGRATION  --   SNGIT_GITHUB_INTEG_MBASUL_DMAS  --------------------
create api integration if not exists SNGIT_GITHUB_INTEG_MBASUL_DMAS
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/mbasul/DMAS')
    allowed_authentication_secrets = (SNGIT_GITHUB_SECR_MBASUL)
    enabled = true
;

show roles in account;
show api integrations;


-- ===========================================================================================
use role SECURITYADMIN;
grant usage on integration SNGIT_GITHUB_INTEG_MBASUL_DMAS to role SNGIT_ADMIN_GIT;
grant create git repository on schema DMAS.PUBLIC to role SNGIT_ADMIN_GIT;

use role SNGIT_ADMIN_GIT;
create or replace git repository SNGIT_REPOS_GITHUB_MBASUL_DMAS
    api_integration = SNGIT_GITHUB_INTEG_MBASUL_DMAS
    git_credentials = SNGIT_GITHUB_SECR_MBASUL
    origin = 'https://github.com/mbasul/DMAS'
;

use role accountadmin;
show integrations;
show git repositories;
describe git repository SNGIT_REPOS_GITHUB_MBASUL_DMAS;
-- list repository DMAS.AOEC.SNGIT_REPOS_GITHUB_MBASUL_DMAS;

