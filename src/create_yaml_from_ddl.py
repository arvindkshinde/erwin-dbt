"""
Script Name: create_yaml_from_ddl.py
Author: Arvind Shinde
Date: Oct-2024
Description:
	This is a "SAMPLE" script to convert Oracle DDL SQL file (generated using erwin FE) to DBT YAML file. 
	Please further customize this script as per your YAML format requirement.

Expected DBT YAML format:

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
Setup:
 Install python packages: sqlparse, yaml, re, sys

Usage:
    python create_yaml_from_ddl.py "<input_file>" "<output_file>"

Arguments:
    <input_file>       Specify the DDL sql input file.
    <output_file>      Specify the YAML output file.

Example:
    python create_yaml_from_ddl.py "/Users/path/to/my/model/oracle_sample_schema_oe.sql" /Users/path/to/my/model/oracle_sample_schema_oe.yaml
"""

import sqlparse
import yaml
import re
import sys

def parse_ddl(ddl_file_path):
    with open(ddl_file_path, 'r') as erwin_ddl_file:
        ddl_content = erwin_ddl_file.read()

    statements = sqlparse.split(ddl_content)

    tables = []
    column_details = []

    for stmt in statements:
        # print(stmt)
        parsed_stmt = sqlparse.parse(stmt)[0]
        # print(parsed_stmt)
        # Check if this is a CREATE TABLE statement
        is_create_table = False
        table_name = None
        if parsed_stmt.get_type() == 'CREATE':
            table_name = None
            for token in parsed_stmt.tokens:
                if token.ttype == sqlparse.tokens.Keyword and token.value.upper() == 'TABLE':
                    table_name = parsed_stmt.tokens[parsed_stmt.tokens.index(token) + 2].get_real_name()
                if isinstance(token, sqlparse.sql.Parenthesis):
                    column_values = token.value
                    column_values = re.sub(r',\s*FOREIGN KEY.*\)', ')', column_values)
                    column_values = re.sub(r'\bPRIMARY KEY\b', '', column_values)
                    columns = re.split(r',\s*(?![^()]*\))', column_values[1:-1])

            if table_name:
                tables.append({'name': table_name, 'columns': columns})

    return tables



def create_dbt_yaml(tables, output_file_path):
    dbt_yaml = {'version': 2, 'models': []}
        
    for table in tables:
        # Extract table name
        table_name = table['name']
        
        # Define model with table name and description
        model = {
            'name': table_name,
            'description': f"Model for table {table_name}",
            'columns': []
        }
        
        # Process each column to extract name and type
        for col in table['columns']:
            col_parts = col.split()
            col_name = col_parts[0]  # First part is the column name
            col_type = " ".join(col_parts[1:])  # Remaining parts are the data type
            # print(col_type)
            data_type = re.match(r'^[A-Za-z]+', col_type).group(0)

            constraints = []
            if re.search(r'\bNOT NULL\b', col_type, re.IGNORECASE):
                constraints.append({'type': 'NOT NULL'})
            # print(constraint)

            
            # Append column details to model
            model['columns'].append({
                'name': col_name,
                # 'description': f"Column {col_name} of type {col_type}",
                'data_type': data_type,
                **({'constraints': constraints, 'tests': ['not_null']} if constraints else {})

            })
        
        # Add the model to the DBT YAML structure
        dbt_yaml['models'].append(model)

    # print("DBT YAML structure:", yaml.dump(dbt_yaml, sort_keys=False))

        # Write the YAML structure to a file
    with open(output_file_path, 'w') as yaml_file:
        yaml.dump(dbt_yaml, yaml_file, sort_keys=False)
        print(f"YAML file generated at {output_file_path}")


tables = parse_ddl(sys.argv[1])
create_dbt_yaml(tables, sys.argv[2])

