# Script Name: upload_to_git.py
# Author: Arvind Shinde
# Date: Oct-2024
# Description:
# 	This is a "SAMPLE" script to upload file to git repo
# 
# Setup:
#  Install python packages: pygithub
# 
# Usage:
#     python upload_to_git.py
# 
# 
# 


from github import Github
import os

g = Github('asdljsldkfnliuokjhslkfjasl')

repo = g.get_repo('git/repo')

uploadfile = '/Users/path/to/erwin/models/oracle_sample_schema_oe.yaml'

with open(uploadfile, 'r') as file:
    data = file.read()

repo.create_file(os.path.basename(uploadfile), 'erwin-dbt yaml file', data, branch='main')