
from pathlib import Path
import pandas as pd

BASE_DIR = Path(__file__).resolve().parent.parent
    
RAW_PATH = BASE_DIR / "Data" / "healthcare_dataset.csv"
OUT_PATH = BASE_DIR / "Data" / "healthcare_dataset_cleaned.csv"

df = pd.read_csv(RAW_PATH)
print(f"Raw rows: {len(df)}")

# 1. Standardize text casing
df["Name"] = df["Name"].str.strip().str.title()
df["Doctor"] = df["Doctor"].str.strip().str.title()
df["Hospital"] = df["Hospital"].str.strip()
df["Medical Condition"] = df["Medical Condition"].str.strip().str.title()
df["Insurance Provider"] = df["Insurance Provider"].str.strip()
df["Admission Type"] = df["Admission Type"].str.strip().str.title()
df["Medication"] = df["Medication"].str.strip().str.title()
df["Test Results"] = df["Test Results"].str.strip().str.title()
df["Gender"] = df["Gender"].str.strip().str.title()
df["Blood Type"] = df["Blood Type"].str.strip()

# 2. Parse dates
df["Date of Admission"] = pd.to_datetime(df["Date of Admission"], errors="coerce")
df["Discharge Date"] = pd.to_datetime(df["Discharge Date"], errors="coerce")

# 3. Round billing amount
df["Billing Amount"] = df["Billing Amount"].round(2)

# 4. Drop exact duplicates
before = len(df)
df = df.drop_duplicates()
print(f"Dropped {before - len(df)} duplicate rows")

# 5. Derived column: Length of Stay (days)
df["Length of Stay"] = (df["Discharge Date"] - df["Date of Admission"]).dt.days

# Add a stable admission_id (row-based, after cleaning)
df = df.reset_index(drop=True)
df.insert(0, "Admission_ID", df.index + 1)

df.to_csv(OUT_PATH, index=False)
print(f"Clean rows: {len(df)}")
print(f"Saved to {OUT_PATH}")
