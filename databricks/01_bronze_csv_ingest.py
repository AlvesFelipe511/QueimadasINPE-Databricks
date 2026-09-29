input_file_path = "/Volumes/main/queimadas/landing/queimadas_brasil.csv"

df_raw = (
    spark.read
    .option("header", True)
    .option("inferSchema", False)
    .option("sep", ",")
    .csv(input_file_path)
)

display(df_raw)
df_raw.printSchema()

df_raw.write.mode("overwrite").saveAsTable("bronze_queimadas_csv_raw")
