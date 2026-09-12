from sqlalchemy.engine.cursor import CursorResult
from typing import Any
from pandas.core.frame import DataFrame
from sqlalchemy.engine.base import Engine
import pandas as pd
from sqlalchemy import create_engine

# Read the CSV from your device
df: DataFrame = pd.read_csv(r"./SQL/Datasets/smartphones.csv")
df.head()

# Option A: using PyMySQL driver (most common/recommended)
engine: Engine = create_engine(
    "mysql+pymysql://shriram:8842@localhost:3306/Tutorial"
)

# Option B: using mysql-connector-python driver instead
engine = create_engine(
    "mysql+mysqlconnector://shriram:8842@localhost:3306/Tutorial"
)

# Quick test
with engine.connect() as conn:
    result: CursorResult[Any] = conn.exec_driver_sql("SELECT DATABASE();")
    print(result.fetchone())
    print("Connection Successful")

# Push the DataFrame into MySQL as a table
df.to_sql(
    name="smartphones",      # table name to create/append to
    con=engine,
    if_exists="replace",     # "replace" | "append" | "fail"
    index=False,             # don't write pandas' row index as a column
    chunksize=1000,          # batch inserts — important for large files
    method="multi"           # batches multiple rows per INSERT statement (faster)
)

print("Upload complete.")