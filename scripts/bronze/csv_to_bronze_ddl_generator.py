"""
Data Engineering Automation Tool: SQL Server DDL Schema Generator
Author: Junior Data Engineer
Reviewed by: Senior Python Developer

Description:
This script scans a directory for flat CSV files, infers their table schemas
using pandas, and dynamically writes a structured, executable SQL Server (.sql) 
script with 'DROP TABLE IF EXISTS' logic for idempotent migrations.
"""

import os
import glob
import pandas as pd

def export_ddl_to_file(output_filename: str = "bronze_schema_generation.sql", schema_name: str = "bronze") -> None:
    """
    Scans local directory for CSV files, determines data layout rules,
    and exports a combined, clean SQL Server 'CREATE TABLE' script file
    with conditional safety drops before each creation block.
    """
    # CRITICAL: Force Python execution context to align with the script's physical location.
    try:
        os.chdir(os.path.dirname(os.path.abspath(__file__)))
    except NameError:
        pass  # Gracefully handle interactive runtime environments like Jupyter Notebooks

    # Retrieve all local files ending with the .csv file extension
    csv_files = glob.glob("./*.csv")
    if not csv_files:
        print("❌ Error: No source CSV files found to generate the script.")
        return

    # Open/Create the target .sql file using a Context Manager to guarantee safe memory flushing
    with open(output_filename, "w", encoding="utf-8") as sql_file:
        
        # Inject standard structural database headers at the top of the script
        sql_file.write("/* ====================================================\n")
        sql_file.write(f"   AUTOMATICALLY GENERATED DDL FOR SCHEMA: {schema_name}\n")
        sql_file.write("   ==================================================== */\n\n")

        # Loop through each individual discovered CSV file path
        for file_path in csv_files:
            # Isolate the bare file string name (e.g., extracts 'customers' from './customers.csv')
            base_name = os.path.splitext(os.path.basename(file_path))[0]
            table_name = f"{schema_name}.{base_name}"
            
            # MEMORY OPTIMIZATION: Read only the first 50 rows. 
            df_sample = pd.read_csv(file_path, nrows=50)
            
            ddl_lines = []
            # Iterate through the inferred structural properties of each column
            for col_name in df_sample.columns:
                col_type = df_sample[col_name].dtype
                
                # RULE-BASED STRUCTURAL DATATYPE MAPPER
                if "int" in str(col_type):
                    sql_type = "INT"
                elif "float" in str(col_type):
                    sql_type = "FLOAT(53)"
                else:
                    # Filter non-null entries for actual content validation
                    non_null_series = df_sample[col_name].dropna()
                    is_date = False
                    
                    if not non_null_series.empty:
                        try:
                            # Attempt parsing values as datetime; raises an exception if invalid text is present
                            pd.to_datetime(non_null_series, errors="raise")
                            is_date = True
                        except (ValueError, TypeError, OverflowError):
                            is_date = False

                    if is_date or "datetime" in str(col_type):
                        sql_type = "DATE"
                    else:
                        # DYNAMIC TEXT SIZING: Calculate max string length to optimize database memory & storage
                        if not non_null_series.empty:
                            max_len = non_null_series.astype(str).str.len().max()
                        else:
                            max_len = 0

                        # Memory allocation tiers based on observed data dimensions
                        if max_len <= 50:
                            sql_type = "NVARCHAR(50)"
                        elif max_len <= 255:
                            sql_type = "NVARCHAR(255)"
                        else:
                            sql_type = "NVARCHAR(MAX)"
                    
                # Exact column name preservation to guarantee 1:1 mapping for BULK INSERT
                ddl_lines.append(f"\t{col_name} {sql_type}")
                
            # Compile column arrays into a structured SQL string block
            columns_ddl = ",\n".join(ddl_lines)
            
            # DYNAMIC CHECK BLOCK: Generates the safe conditional drop statement for this specific table
            drop_check = (
                f"IF OBJECT_ID ('{table_name}', 'U') IS NOT NULL\n"
                f"\tDROP TABLE {table_name};\n"
            )
            
            # Combine the drop block and create block into one executable script unit
            create_statement = f"{drop_check}CREATE TABLE {table_name} (\n{columns_ddl}\n);\n\n"
            
            # Commit the full block directly to the physical .sql file
            sql_file.write(create_statement)
            
    print(f"💾 Success! Created layout script: '{output_filename}' ({len(csv_files)} tables written).")

# --- SCRIPT EXECUTION BLOCK ---
if __name__ == "__main__":
    export_ddl_to_file()

    
