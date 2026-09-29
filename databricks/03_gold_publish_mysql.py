from pyspark.sql.functions import count, avg, max as spark_max

mysql_host = "<mysql_fqdn>"
mysql_port = "3306"
mysql_db = "queimadas"
mysql_user = "queimada-usr"
mysql_password = dbutils.secrets.get("queimadas-scope", "mysql-app-password")

jdbc_url = f"jdbc:mysql://{mysql_host}:{mysql_port}/{mysql_db}?useSSL=true&requireSSL=true"

df_silver = spark.table("silver_queimadas_focos")

gold_estado_dia = (
    df_silver.groupBy("data", "estado")
    .agg(
        count("*").alias("qtd_focos"),
        avg("frp").alias("frp_medio"),
        avg("risco_fogo").alias("risco_medio")
    )
)

gold_bioma_dia = (
    df_silver.groupBy("data", "bioma")
    .agg(
        count("*").alias("qtd_focos"),
        avg("frp").alias("frp_medio")
    )
)

gold_municipios_criticidade = (
    df_silver.groupBy("estado", "municipio")
    .agg(
        count("*").alias("qtd_focos"),
        avg("frp").alias("frp_medio"),
        avg("risco_fogo").alias("risco_medio"),
        spark_max("frp").alias("frp_max")
    )
)

for df_out, table_name in [
    (gold_estado_dia, "gold_focos_estado_dia"),
    (gold_bioma_dia, "gold_focos_bioma_dia"),
    (gold_municipios_criticidade, "gold_municipios_criticidade")
]:
    (
        df_out.write
        .format("jdbc")
        .option("url", jdbc_url)
        .option("dbtable", table_name)
        .option("user", mysql_user)
        .option("password", mysql_password)
        .option("driver", "com.mysql.cj.jdbc.Driver")
        .mode("overwrite")
        .save()
    )
