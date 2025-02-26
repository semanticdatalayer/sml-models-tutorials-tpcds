./benchmark.sh -r "2025.2.100GB" -j "apache-jmeter-5.5/bin/jmeter.sh" -x "TPC-DS-Benchmark-AtScale.jmx" -d "AtScale.Databricks" -s "jdbc:postgresql://localhost:15432/tpcds" -u "<atscale_user_name>" -p "<atscale_password>" -n "tpcds" -z "tpcds_benchmark_model" -l "Benchmark-Results"
