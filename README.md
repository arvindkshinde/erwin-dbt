Here’s a README.md file for your project, summarizing each script’s purpose, setup, usage, and example:

erwin-dbt Integration Scripts

This repository contains sample Python scripts to automate integration between erwin Data Modeler and dbt (Data Build Tool). The scripts enable automated generation of DDLs and conversion into dbt-compatible YAML formats, with an option to upload these YAML files to GitHub for version control.

Contents

	•	erwin_api_fe.py: Generates Forward Engineered DDL scripts using erwin API
	•	create_yaml_from_ddl.py: Converts Oracle DDL SQL files to dbt YAML format
	•	upload_to_git.py: Uploads files to a specified GitHub repository
	•	erwin_model_api_to_dbt_yaml.py: Generates dbt YAML file directly from an erwin model via erwin API
	•	sample_oracle_ddl.sql: Sample Oracle DDL file for testing and demonstration purposes

Prerequisites

Install the required Python packages for each script:

pip install pywin32 sqlparse pyyaml pygithub

Scripts Overview

1. erwin_api_fe.py

	•	Author: Arvind Shinde
	•	Date: October 2024
	•	Description: Generates Forward Engineered DDL script using erwin API.
	•	Setup: Requires pywin32 for COM API interaction with erwin.
	•	Usage:

python erwin_api_fe.py



2. create_yaml_from_ddl.py

	•	Author: Arvind Shinde
	•	Date: 29-Oct-2024
	•	Description: Converts an Oracle DDL SQL file to a dbt-compatible YAML file.
	•	Expected YAML Format:

version: 2
models:
  - name: <table_name>
    description: <table description>
    columns:
      - name: <column_name>
        data_type: <data type>
        constraints:
          - type: <constraint>
        tests:
          - <constraint>


	•	Setup: Requires sqlparse, pyyaml, re, sys.
	•	Usage:

python create_yaml_from_ddl.py "<input_file>" "<output_file>"


	•	Arguments:
	•	<input_file>: Specify the DDL SQL input file.
	•	<output_file>: Specify the YAML output file.
	•	Example:

python create_yaml_from_ddl.py "/path/to/oracle_sample_schema_oe.sql" "/path/to/oracle_sample_schema_oe.yaml"



3. upload_to_git.py

	•	Author: Arvind Shinde
	•	Date: October 2024
	•	Description: Uploads a file to a specified GitHub repository.
	•	Setup: Requires pygithub to interact with the GitHub API.
	•	Usage:

python upload_to_git.py



4. erwin_model_api_to_dbt_yaml.py

	•	Author: Arvind Shinde
	•	Date: October 2024
	•	Description: Directly generates a dbt-compatible YAML file from an erwin model using the erwin API.
	•	Expected YAML Format:

version: 2
models:
  - name: <table_name>
    description: <table description>
    columns:
      - name: <column_name>
        data_type: <data type>
        constraints:
          - type: <constraint>
        tests:
          - <constraint>


	•	Setup: Requires pywin32, pyyaml, and sys.
	•	Usage:

python erwin_model_api_to_dbt_yaml.py "<input_file>" "<output_file>"


	•	Arguments:
	•	<input_file>: Specify the erwin model file.
	•	<output_file>: Specify the YAML output file.
	•	Example:

python erwin_model_api_to_dbt_yaml.py "C:\path\to\model.erwin" "C:\path\to\dbt_yaml_output.yaml"



5. sample_oracle_ddl.sql

	•	Description: A sample Oracle DDL file provided for testing the erwin-dbt integration scripts.

License

This project is open-source for educational and integration purposes. Please ensure compliance with erwin and dbt licensing terms if using in production environments.

This README.md provides a comprehensive guide for each script’s purpose, installation, and usage within the erwin-dbt integration workflow.
