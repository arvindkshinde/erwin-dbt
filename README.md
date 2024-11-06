<!DOCTYPE html>
<html lang="en">
<body>

<h1>erwin-dbt Integration Scripts</h1>

<p>This repository contains sample Python scripts to automate integration between <strong>erwin Data Modeler</strong> and <strong>dbt</strong> (Data Build Tool). The scripts enable automated generation of DDLs and conversion into dbt-compatible YAML formats, with an option to upload these YAML files to GitHub for version control.</p>

<h2>Contents</h2>
<ul>
    <li><code>erwin_api_fe.py</code>: Generates Forward Engineered DDL scripts using erwin API</li>
    <li><code>create_yaml_from_ddl.py</code>: Converts Oracle DDL SQL files to dbt YAML format</li>
    <li><code>upload_to_git.py</code>: Uploads files to a specified GitHub repository</li>
    <li><code>erwin_model_api_to_dbt_yaml.py</code>: Generates dbt YAML file directly from an erwin model via erwin API</li>
    <li><code>sample_oracle_ddl.sql</code>: Sample Oracle DDL file for testing and demonstration purposes</li>
</ul>

<h3>Prerequisites</h3>
<p>Install the required Python packages for each script:</p>
<pre><code>pip install pywin32 sqlparse pyyaml pygithub</code></pre>

<h2>Scripts Overview</h2>

<h3>1. <code>erwin_api_fe.py</code></h3>
<ul>
    <li><strong>Description:</strong> Generates Forward Engineered DDL script using erwin API.</li>
    <li><strong>Setup:</strong> Requires <code>pywin32</code> for COM API interaction with erwin.</li>
    <li><strong>Usage:</strong>
        <pre><code>python erwin_api_fe.py</code></pre>
    </li>
</ul>

<h3>2. <code>create_yaml_from_ddl.py</code></h3>
<ul>
    <li><strong>Description:</strong> Converts an Oracle DDL SQL file to a dbt-compatible YAML file.</li>
    <li><strong>Expected YAML Format:</strong>
        <pre><code>version: 2
models:
  - name: &lt;table_name&gt;
    description: &lt;table description&gt;
    columns:
      - name: &lt;column_name&gt;
        data_type: &lt;data type&gt;
        constraints:
          - type: &lt;constraint&gt;
        tests:
          - &lt;constraint&gt;</code></pre>
    </li>
    <li><strong>Setup:</strong> Requires <code>sqlparse</code>, <code>pyyaml</code>, <code>re</code>, <code>sys</code>.</li>
    <li><strong>Usage:</strong>
        <pre><code>python create_yaml_from_ddl.py "&lt;input_file&gt;" "&lt;output_file&gt;"</code></pre>
    </li>
    <li><strong>Arguments:</strong>
        <ul>
            <li><code>&lt;input_file&gt;</code>: Specify the DDL SQL input file.</li>
            <li><code>&lt;output_file&gt;</code>: Specify the YAML output file.</li>
        </ul>
    </li>
    <li><strong>Example:</strong>
        <pre><code>python create_yaml_from_ddl.py "/path/to/oracle_sample_schema_oe.sql" "/path/to/oracle_sample_schema_oe.yaml"</code></pre>
    </li>
</ul>

<h3>3. <code>upload_to_git.py</code></h3>
<ul>
    <li><strong>Description:</strong> Uploads a file to a specified GitHub repository.</li>
    <li><strong>Setup:</strong> Requires <code>pygithub</code> to interact with the GitHub API.</li>
    <li><strong>Usage:</strong>
        <pre><code>python upload_to_git.py</code></pre>
    </li>
</ul>

<h3>4. <code>erwin_model_api_to_dbt_yaml.py</code></h3>
<ul>
    <li><strong>Description:</strong> Directly generates a dbt-compatible YAML file from an erwin model using the erwin API.</li>
    <li><strong>Expected YAML Format:</strong>
        <pre><code>version: 2
models:
  - name: &lt;table_name&gt;
    description: &lt;table description&gt;
    columns:
      - name: &lt;column_name&gt;
        data_type: &lt;data type&gt;
        constraints:
          - type: &lt;constraint&gt;
        tests:
          - &lt;constraint&gt;</code></pre>
    </li>
    <li><strong>Setup:</strong> Requires <code>pywin32</code>, <code>pyyaml</code>, and <code>sys</code>.</li>
    <li><strong>Usage:</strong>
        <pre><code>python erwin_model_api_to_dbt_yaml.py "&lt;input_file&gt;" "&lt;output_file&gt;"</code></pre>
    </li>
    <li><strong>Arguments:</strong>
        <ul>
            <li><code>&lt;input_file&gt;</code>: Specify the erwin model file.</li>
            <li><code>&lt;output_file&gt;</code>: Specify the YAML output file.</li>
        </ul>
    </li>
    <li><strong>Example:</strong>
        <pre><code>python erwin_model_api_to_dbt_yaml.py "C:\path\to\model.erwin" "C:\path\to\dbt_yaml_output.yaml"</code></pre>
    </li>
</ul>

<h3>5. <code>sample_oracle_ddl.sql</code></h3>
<ul>
    <li><strong>Description:</strong> A sample Oracle DDL file provided for testing the erwin-dbt integration scripts.</li>
</ul>

</body>
</html>

This HTML provides a well-structured overview of each script and their usage in the project. Let me know if you need further customization!
