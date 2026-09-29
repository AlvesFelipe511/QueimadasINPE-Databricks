# Projeto Hands-on de Databricks
## Bronze em CSV no Volume, Silver no Lakehouse e Gold no MySQL com Jobs and Pipelines

Este projeto foi desenhado para uma aula hands-on de Databricks em nível intermediário/avançado, considerando que a turma já possui conhecimentos básicos de:
- Databricks
- Python
- arquitetura Medallion

A proposta do projeto é construir um pipeline analítico completo, com:
- provisionamento de infraestrutura na Azure com Terraform
- versionamento no GitHub
- execução manual com GitHub Actions
- ingestão da camada Bronze a partir de um CSV armazenado em um Volume do Databricks
- transformação e qualidade na camada Silver
- publicação da camada Gold em um Azure Database for MySQL Flexible Server
- orquestração com Jobs and Pipelines

---

# 1. Arquitetura do projeto

## Fluxo geral

1. Provisionar a infraestrutura do MySQL na Azure com Terraform
2. Versionar o código no GitHub
3. Executar o provisionamento manualmente com GitHub Actions
4. Armazenar o CSV de queimadas em um Volume do Databricks
5. Ler o CSV e persistir a camada Bronze
6. Processar a Bronze para gerar a Silver
7. Publicar a Gold no banco MySQL
8. Orquestrar o fluxo com Jobs
9. Monitorar runs e registrar auditoria

## Arquitetura lógica

- **Provisionamento:** Terraform + GitHub Actions
- **Origem de ingestão:** CSV em Volume do Databricks
- **Bronze:** Lakehouse no Databricks
- **Silver:** Lakehouse no Databricks
- **Gold:** Azure Database for MySQL Flexible Server
- **Orquestração:** Databricks Jobs and Pipelines

---

# 2. Estrutura do repositório

```text
queimadas-hands-on/
├── .github/
│   └── workflows/
│       └── terraform-apply.yml
├── infra/
│   ├── versions.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── databricks/
│   ├── 01_bronze_csv_ingest.py
│   ├── 02_silver_standardize_quality.py
│   ├── 03_gold_publish_mysql.py
│   └── 04_audit_run.py
└── README.md
