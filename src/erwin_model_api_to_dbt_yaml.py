# """
# Script Name: erwin_model_api_to_dbt_yaml.py
# Author: Arvind Shinde
# Date: Oct-2024
# Description:
# 	This is a "SAMPLE" script to generate DBT YAML file from erwin model. It uses erwin APIs to access objects within model.
# 	Please further customize this script as per your YAML format requirement.
# 
# Expected DBT YAML format:
# 
# 	version: 2
# 	models:
# 	- name: <table_name>
# 	  description: <table description>
# 	  columns:
# 	  - name: <column_name>
# 	    data_type: <data type>
# 	    constraints:
# 	    - type: <constraint>
# 	    tests:
# 	    - <constraint>
# Setup:
#  Install python packages: pywin32, pyYAML, sys
# 
# Usage:
#     python erwin_model_api_to_dbt_yaml.py "<input_file>" "<output_file>"
# 
# Arguments:
#     <input_file>       Specify the erwin model file.
#     <output_file>      Specify the YAML output file.
# 
# Example:
#      python erwin_model_api_to_dbt_yaml.py "C:\Users\path\to\models\sample.erwin" "C:\Users\path\to\models\dbt_yaml_output.yaml"
# """
# 
# 

import win32com.client
import yaml
import sys

def get_model_objects_details():
    # Initialize ERwin SCAPI Application
    oERwin = win32com.client.Dispatch("ERwin9.SCAPI")
    
    # Open the model
    model_path = sys.argv[1]
    oPU = oERwin.PersistenceUnits.Add(model_path, "RDO=Yes")
    
    # Create a session
    oSess = oERwin.Sessions.Add()
    oSess.Open(oPU)

    yaml_data = {"version": 2, "models": []}

    try:
        # Collect "Entity" model objects
        oEntities = oSess.ModelObjects.Collect(oSess.ModelObjects.Root, "Entity", 2)

        # Iterate over each entity to retrieve attributes
        for entity in oEntities:
            # Prepare model structure for YAML
            model_info = {
                "name": entity.Name.lower(),
                "description": f"Model for table {entity.Name.lower()}",
                "columns": []
            }
            
            # Collect "Attribute" objects related to this entity
            attributes = oSess.ModelObjects.Collect(entity.ObjectId, "Attribute", 2)
            
            for attribute in attributes:
                # Access various attribute properties
                propertyDataType = attribute.Properties("Physical_Data_Type").Value
                propertyNullOption = attribute.Properties("Null_Option_Type").Value  # 1 for Not Null, 0 for Null

                # Structure attribute information for YAML
                column_info = {
                    "name": attribute.Name.lower(),
                    "data_type": propertyDataType,
                    "constraints": [],
                    "tests": []
                }
                
                if propertyNullOption == 1:
                    column_info["constraints"].append({"type": "NOT NULL"})
                    column_info["tests"].append("not_null")
                else:
                    column_info["constraints"].append("NULL")
                    column_info["tests"].append("null")

                # Add column info to the model's columns list
                model_info["columns"].append(column_info)

            # Add model info to the main list
            yaml_data["models"].append(model_info)

    except Exception as e:
        print(f"Error accessing model details: {e}")

    finally:
        # Close the session and clean up
        oSess.Close()
        oERwin.Sessions.Clear()
        oPU = None
        oERwin = None

    # Export collected data to YAML
    yaml_file_path = sys.argv[2]
    with open(yaml_file_path, "w") as yaml_file:
        yaml.dump(yaml_data, yaml_file, default_flow_style=False, sort_keys=False)
    
    print(f"YAML file created at: {yaml_file_path}")

# Call function
get_model_objects_details()