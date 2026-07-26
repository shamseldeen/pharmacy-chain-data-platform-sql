r"""
==============================================================================
DATASET PREPARATION & REORGANIZATION SCRIPT
==============================================================================

DESCRIPTION:
    This script automatically scans raw source folders ('source_erp' and 'source_crm'),
    appends the appropriate source prefixes ('erp_' or 'crm_') to all CSV filenames,
    and copies the renamed files into a new target directory named 'new_name/'.

PREREQUISITES & FOLDER STRUCTURE:
    This script MUST be placed directly in your main project root directory alongside
    the data source folders:

    sql-data-warehouse-project/
    │
    ├── prepare_datasets.py     <-- (THIS SCRIPT)
    │
    ├── source_erp/             <-- Source data from ERP
    │   ├── cust_az12.csv
    │   └── geography/
    │       └── stores.csv
    │
    └── source_crm/             <-- Source data from CRM
        └── cust_info.csv

HOW TO RUN:
    1. Open your terminal or PowerShell.
    2. Navigate to the project directory:
       cd "C:\Users\Win 10.1 64bit\Downloads\sql-data-warehouse-project"

    3. Run a Dry-Run (Preview mode - no files created or copied):
       python prepare_datasets.py

    4. Execute actual copying & renaming:
       python prepare_datasets.py --apply

OUTPUT:
    A new directory 'new_name/' will be created with the restructured files:
    
    new_name/
    ├── source_erp/
    │   ├── erp_cust_az12.csv
    │   └── geography/
    │       └── erp_stores.csv
    └── source_crm/
        └── crm_cust_info.csv
==============================================================================
"""

import os
import sys
import shutil
from pathlib import Path

# ==============================================================================
# CONFIGURATION
# Map each source folder to its corresponding data source prefix
# ==============================================================================
FOLDER_PREFIX_MAP = {
    "source_erp": "erp",
    "source_crm": "crm",
}

# Target folder name where newly named copies will be stored
OUTPUT_FOLDER = "new_name"


def main():
    """
    Main execution pipeline.
    Handles command-line arguments, checks directory availability,
    and coordinates recursive file searching and copying.
    """
    # Parse command line flags
    args = [a for a in sys.argv[1:] if a != "--apply"]
    apply_changes = "--apply" in sys.argv
    
    # Automatically resolve the base project directory where this script resides
    base_dir = Path(args[0]) if args else Path(__file__).resolve().parent
    destination_root = base_dir / OUTPUT_FOLDER

    print("--- DATASET REORGANIZATION TOOL ---")
    print(f"Mode: {'APPLYING CHANGES' if apply_changes else 'DRY RUN (Preview mode)'}")
    print(f"Base Directory: {base_dir}")
    print(f"Destination Root: {destination_root}\n")

    total_copied = 0
    found_any_folder = False

    # Process each source data folder (ERP, CRM)
    for folder_name, prefix in FOLDER_PREFIX_MAP.items():
        source_path = base_dir / folder_name
        
        # Skip if the source folder does not exist
        if not source_path.is_dir():
            print(f"NOTE: Source folder not found, skipping: {folder_name}/")
            continue

        found_any_folder = True
        print(f"Processing source folder: {folder_name}/ (Prefix: {prefix}_)")
        
        # Recursively scan for all .csv files (including nested subfolders)
        csv_files = list(source_path.rglob("*.csv"))

        for old_path in csv_files:
            # Maintain original relative subfolder paths
            rel_path = old_path.relative_to(source_path)
            
            # Format filename with prefix
            old_name = old_path.name
            new_name = old_name if old_name.startswith(f"{prefix}_") else f"{prefix}_{old_name}"
            
            # Construct target destination path inside 'new_name/'
            target_path = destination_root / folder_name / rel_path.parent / new_name

            print(f"  [COPY] {rel_path} -> {target_path.relative_to(base_dir)}")

            # Create destination folder structure and copy data file
            if apply_changes:
                target_path.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(old_path, target_path)

            total_copied += 1
        print()

    # Friendly execution feedback
    if not found_any_folder:
        print("ERROR: No 'source_erp' or 'source_crm' folders found in the current directory.")
        print("Make sure this script is placed in your main project folder alongside source datasets.")
        return

    if not apply_changes:
        print("=" * 60)
        print(f"DRY RUN COMPLETE: {total_copied} file(s) would be copied.")
        print("To execute changes, re-run with the '--apply' flag:")
        print("  python prepare_datasets.py --apply")
        print("=" * 60)
    else:
        print("=" * 60)
        print(f"SUCCESS: {total_copied} file(s) copied into '{OUTPUT_FOLDER}/'.")
        print("=" * 60)


if __name__ == "__main__":
    main()
