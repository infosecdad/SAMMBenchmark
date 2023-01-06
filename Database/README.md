# Python and SQL scripts to build the SAMM Benchmark database and insert content.

## Order of Operations

0. Connect to your database of choice, running postgresql in Azure currently

1. Run `CreateDB_samm-benchmark-dev.pgsql` to build the database schema/tables

2. Run `insert_staticValues.pgsql` to insert default static values supporting the models

3. Run `generateSQL.py` that will parse the model YAML files and create `insert_model.pgsql`

4. Run `insert_model.pgsql` to insert the model into the database

5. Run `parseToolbox.py` to parse a toolbox assessment and create `insert_assessment.pgsql`

6. Run `insert_assessment.pgsql` to insert the parsed assessment


There are a number of manual steps at the moment.

a. When a model changes, will have to test parsing and id numbers

b. Parsing a toolbox assessment still requires a little manual editing for core id numbers.