from diagrams import Diagram, Cluster
from diagrams.onprem.compute import Server
from diagrams.onprem.database import Oracle
from diagrams.saas.analytics import Snowflake
from diagrams.onprem.network import Nginx
from diagrams.onprem.analytics import Dbt
from diagrams.onprem.analytics import Powerbi

with Diagram("oracle_to_snowflake_pipeline", show=False, direction="LR"):
    oracle = Oracle("Oracle EBS")
    odi = Server("Oracle ODI")
    snowflake = Snowflake("Snowflake")
    dbt = Dbt("dbt")
    snowflake2 = Snowflake("Snowflake")
    powerbi = Powerbi("Power BI")

    oracle >> odi >> snowflake >> dbt >> snowflake2 >> powerbi
