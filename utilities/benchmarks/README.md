# TPC-DS Benchmark Instructions

The [TPC-DS](https://www.tpc.org/tpcds/) (Transaction Processing Performance Council Decision Support) model dataset is a widely recognized benchmarking standard designed to evaluate the performance of data warehousing and business intelligence systems. It simulates a real-world retail company focusing on sales across multiple channels. The dataset includes various dimensions such as store, item, customer, and promotion, and fact tables like sales, inventory, and returns, reflecting typical business activities and analytical queries. TPC-DS supports a wide array of query types and data volumes, making it an essential tool for assessing the efficiency, scalability, and data processing capabilities of modern data management systems.

The utilities in this directory will allow you to run a TPC-DS benchmark using the AtScale Semantic Layer Platform and the SML TPC-DS semantic model in this repository.

## Set up Instructions
1. Clone this repository to a machine that can run JMeter.
2. Download and install Apache JMeter Unzip [here](https://jmeter.apache.org/download_jmeter.cgi). Note: These scripts have been tested on v5.5.
3. Download and install the Postgres JDBC driver [here] (https://jdbc.postgresql.org/download) and copy it into the JMeter `lib` directory
4. Add the model in this repository to a running AtScale instance.
5. Update and deploy your global settings for your AtScale instance to include the settings in this [global_settings.yml](global_settings.yml) file.
6. Deploy the TPC-DS model from AtScale.
7. Edit the parameters in the [run-benchmark.sh](run-benchmark.sh) script with your instance details.
8. Make the [run-benchmark.sh](run-benchmark.sh) and [benchmark.sh](benchmark.sh) runnable by executing the following on each script: `chmod +x <filename>`.
9. Run the benchmark by executing the following command: `./benchmark_runner.sh`.

## Parameters for run-benchmark.sh
1. `-r` -> Run Label: A directory label for identifying the test run (example: `Databricks.2025.02.25.100GB`) *NOTE: DON'T USE '-' IN THE NAME SINCE THIS IS USED IN PARSING THE OUTPUT!*
2. `-j` -> JMeter executable location (example: `apache-jmeter-5.5/bin/jmeter.sh`)
3. `-x` -> JMXFilename location (example: `TPC-DS-Benchmark-AtScale.jmx`)
4. `-d` -> Data Platform Name (possible values: `AtScale.Databricks`, `AtScale.Snowflake`, `AtScale.BigQuery`, `AtScale.Redshift`) 
5. `-s` -> JDBC Connection String (example: `jdbc:postgresql://localhost:15432/tpcds`) 
6. `-u` -> AtScale user name (example: `admin`)
7. `-p` -> AtScale password
8. `-n` -> AtScale catalog name (Omit for non-AtScale platforms) (example: `tpcds`)
9. `-z` -> AtScale model name (Omit for non-AtScale platforms) (example: `tpcds_benchmark_model`)
10. `-l` -> Output directory for JMeter CSV & HTML file (example: `Benchmark-Results`)

## Output
The output from the benchmark script will be written to the directory specified in the [benchmark_runner.sh](benchmark_runner.sh) file. It will create two root directories: CSV output and HTML output. Within these directories, the scripts will create a directory for each thread group (1, 5, 25, 50) and a directory that combines all the thread groups.

