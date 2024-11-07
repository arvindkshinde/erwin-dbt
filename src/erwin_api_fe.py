# Script Name: erwin_api_fe.py
# Author: Arvind Shinde
# Date: Oct-2024
# Description:
# 	This is a "SAMPLE" script to generate Forward Engineered DDL script using erwin API
# 
# Setup:
#  Install python packages: pywin32
# 
# Usage:
#     python erwin_api_fe.py
# 
# 
# 



import win32com.client
api = win32com.client.Dispatch("erwin9.SCAPI")
unit = api.PersistenceUnits.Add(r"C:\Users\path\to\erwin\models\file.erwin", "RDO=Yes")
unit.FEModel_DDL(r"C:\Users\path\to\erwin\models\output_fe.sql")

