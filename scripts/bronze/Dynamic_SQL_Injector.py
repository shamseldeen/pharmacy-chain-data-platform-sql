"""
Data Engineering Migration Tool: Dynamic SQL Injector
Author: Junior Data Engineer
Reviewed by: Senior Python Developer

Description:
This script opens an existing .sql file, automatically identifies all 'CREATE TABLE'
statements, extracts the table names, and injects an 'IF OBJECT_ID ... DROP TABLE' 
idempotency block directly above each creation script.
"""

import os
import re

def inject_drop_checks_into_sql(input_file: str, output_file: str) -> None:
    """
    Opens an existing SQL script, scans for table names, and writes a new 
    SQL script with structural drop-checks injected before every table creation.
    """
    # Force alignment of the directory path with the script's physical location
    try:
        os.chdir(os.path.dirname(os.path.abspath(__file__)))
    except NameError:
        pass

    # Ensure that the target file to be modified actually exists
    if not os.path.exists(input_file):
        print(f"❌ Error: The source file '{input_file}' was not found.")
        return

    # Read the full content of the old SQL file using UTF-8 encoding
    with open(input_file, "r", encoding="utf-8") as f:
        sql_content = f.read()

    # Regex Pattern: Looks for "CREATE TABLE schema.table_name" statements
    # It extracts the full table name into a variable block (Group 1)
    # \s+ matches one or more spaces, and ([\w.]+) captures the schema and table name
    table_pattern = re.compile(r"CREATE\s+TABLE\s+([\w.]+)", re.IGNORECASE)

    # Initialize an array to accumulate the modified lines for the new file
    modified_sql_lines = []
    
    # Split the raw script string into individual lines to inspect them one by one
    lines = sql_content.splitlines()
    tables_updated_count = 0

    for line in lines:
        # Check if the current line matches the table creation syntax pattern
        match = table_pattern.search(line)
        
        if match:
            # Extract the raw, clean table name (e.g., bronze.customers) from the match object
            table_name = match.group(1)
            
            # Construct the dynamic conditional block using the captured table string asset
            drop_check = (
                f"IF OBJECT_ID ('{table_name}', 'U') IS NOT NULL\n"
                f"\tDROP TABLE {table_name};\n"
            )
            
            # Inject the drop constraint into the array directly before the current CREATE TABLE line
            modified_sql_lines.append(drop_check)
            tables_updated_count += 1
            
        # Append the original file line as-is (whether it was a CREATE statement or standard script text)
        modified_sql_lines.append(line)

    # Merge the modified array items and write them into a completely new SQL asset file
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("\n".join(modified_sql_lines))

    print(f"🚀 Success! Modified script saved to: '{output_file}'")
    print(f"🛠️ Injected {tables_updated_count} dynamic drop-check structures into the code.")

# --- Script Execution Block ---
if __name__ == "__main__":
    # Specify the name of your old, unautomated SQL file residing in this folder
    old_file = "handNotAutomated.sql" 
    
    # Name the new file output asset that will house your idempotent schema scripts
    new_file = "idempotent_schema_generation.sql"
    
    inject_drop_checks_into_sql(old_file, new_file)
