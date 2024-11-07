
# get views from models

import win32com.client
import sys

# def get_model_objects_details():
    # Initialize ERwin SCAPI Application
oERwin = win32com.client.Dispatch("ERwin9.SCAPI")

# Open the model
model_path = sys.argv[1]
oPU = oERwin.PersistenceUnits.Add(model_path, "RDO=Yes")

# Create a session
oSess = oERwin.Sessions.Add()
oSess.Open(oPU)

# Data structure to hold models and columns for YAML export
yaml_data = {"version": 2, "models": []}

print('before try')

try:
# Collect "View" model objects
    print('in try')
    oEntities = oSess.ModelObjects.Collect(oSess.ModelObjects.Root, "View", 2)

    for entity in oEntities:
        # Prepare model structure for YAML
        print(entity.Name)

except Exception as e:
    print(f"Error accessing model details: {e}")

