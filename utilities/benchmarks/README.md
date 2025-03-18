# TPC-DS Benchmark Instructions

The [TPC-DS](https://www.tpc.org/tpcds/) (Transaction Processing Performance Council Decision Support) model dataset is a widely recognized benchmarking standard designed to evaluate the performance of data warehousing and business intelligence systems. It simulates a real-world retail company focusing on sales across multiple channels. The dataset includes various dimensions such as store, item, customer, and promotion, and fact tables like sales, inventory, and returns, reflecting typical business activities and analytical queries. TPC-DS supports a wide array of query types and data volumes, making it an essential tool for assessing the efficiency, scalability, and data processing capabilities of modern data management systems.

The utilities in this directory will allow you to run a TPC-DS benchmark using the SML TPC-DS semantic model in this repository. You can also run a TPC-DS benchmark on the raw TPC-DS tables (without the SML semantic layer) by using the `run-benchmark-raw.sh` version of the script.

## Required Software
1. JMeter 5.x or higher (note: For newer versions of JMeter, you must edit the `jmeter.properties` file to enable header row output (`jmeter.save.saveservice.print_field_names=true`) as described in this [post](https://stackoverflow.com/questions/54367120/how-to-get-header-file-in-csv-file-in-jmeter)
2. Postgres JDBC driver for AtScale or Data Platform JDBC driver (copy into the JMeter `/lib` directory)
3. Access to a supported data platform (i.e. Snowflake, Databricks, etc.)
4. AtScale (if you want to run the SML version of the script)
   
## Set up Instructions
1. Clone this repository to a machine that can run JMeter.
2. Download and install Apache JMeter Unzip [here](https://jmeter.apache.org/download_jmeter.cgi). Note: These scripts have been tested on v5.5.
3. Download and install the Postgres JDBC driver [here] (https://jdbc.postgresql.org/download) and copy it into the JMeter `lib` directory
4. Add the model in this repository to a running AtScale instance.
5. Update and deploy your global settings for your AtScale instance to include the settings in this [global_settings.yml](global_settings.yml) file.
6. Deploy the TPC-DS model from AtScale.
7. Edit the parameters in the [run-benchmark-sml.sh](run-benchmark-sml.sh) or [run-benchmark-raw.sh](run-benchmark-raw.sh) script with your instance details.
8. Make the [run-benchmark-sml.sh](run-benchmark-sml.sh), [run-benchmark-raw.sh](run-benchmark-raw.sh), and [benchmark.sh](benchmark.sh) scripts runnable by executing the following on each script: `chmod +x <filename>`.
9. Run the benchmark by executing the following command: `./run-benchmark_sml.sh` or `./run-benchmark_raw.sh`.

## Parameters for run-benchmark-sml.sh and run-benchmark-raw.sh
1. `-r` -> Run Label: A directory label for identifying the test run (example: `20250225.100GB.Databricks.Run1`) *NOTE: DON'T USE '-' IN THE NAME SINCE THIS IS USED IN PARSING THE OUTPUT!*
2. `-j` -> JMeter executable location (example: `apache-jmeter-5.5/bin/jmeter.sh`)
3. `-x` -> JMXFilename location (example: `TPC-DS-Benchmark-AtScale.jmx` or `TPC-DS-Benchmark-Raw.jmx`)
4. `-d` -> Data Platform Name (possible values: `AtScale.Databricks`, `AtScale.Snowflake`, `AtScale.BigQuery`, `AtScale.Redshift`) 
5. `-c` -> Data Platform Size (example: `2XSMALL`, `XLARGE`) *Important: Remove `-` when specifying data warehouse/cluster size*.
6. `-s` -> JDBC Connection String (example: `jdbc:postgresql://localhost:15432/tpcds`)
    1. NOTE: For Databricks JDBC driver for a Raw Test, you need to add the following to the JDBC connection string to resolve a JMeter incompatibility: `;EnableArrow=0`
    2. For a Raw test, add the data location's catalog (database) and schema to the JDBC connection string. (i.e. For Databricks, `ConnCatalog=<catalog-name>;ConnSchema=<schema-name>`)
7. `-u` -> AtScale/Data Platform user name (example: `admin`)
8. `-p` -> AtScale/Data Platform password
9. `-n` -> AtScale catalog name (Omit for non-AtScale platforms) (example: `tpcds`) - NOT REQUIRED FOR RAW TEST
10. `-z` -> AtScale model name (Omit for non-AtScale platforms) (example: `tpcds_benchmark_model`) - NOT REQUIRED FOR RAW TEST
11. `-l` -> Output directory for JMeter CSV & HTML file (example: `Benchmark-Results`)

## JMeter Output & Reporting
The output from the benchmark scripts will be written to the directory specified in the [run_benchmark_sml.sh](run-benchmark_sml.sh) or [run_benchmark_raw.sh](run-benchmark_raw.sh) file. It will create two root directories: CSV output and HTML output. Within these directories, the scripts will create a directory for each thread group (1, 5, 25, 50) and a directory that combines all the thread groups. You can use this [Tableau Workbook](TPC-DS-Benchmark-AtScale.jmx) to load the CSV files with pre-formatted reports. To load multiple results files, follow these [Tableau Union Instructions](https://community.tableau.com/s/question/0D54T00000C6l3wSAB/connecting-to-mutliple-csv-files).

