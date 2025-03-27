""" import_HS12_directly.py   --   Importieren von HS12-Daten im .csv-Format in jeweils eigene Tabellen
        Tbs.:   tbs.import_CSV_directly.py
		Ref.:	https://www.datameer.com/blog/loading-data-into-snowflake-with-efficiency/

Description:
	.csv file given by a list will be used to automatically create Sniwflake tables.
	The data content of these file will then be loaded into the newly created tales.
"""
import sqlalchemy as sql
import pandas as pd
import os
from sqlalchemy.dialects import registry
import time
 
# Setup an SQL Alchemy Engine connection
registry.register('snowflake', 'snowflake.sqlalchemy', 'dialect')
engine = sql.create_engine(
    'snowflake://{u}:{p}@{a}/{d}/{s}?warehouse={w}&role={r}'.format(
        u='MBASUL250206',
        p='gOkmN+6cF=6Yj5jeKRxtN',
        a='APXGJLP-SB58316',
        r='sysadmin',
        d='DMAS',
        s='AOEC',
        w='DMAS_2X',
    )
)

# List of all survey filenames
csv_path = r'C:\Users\balzer\Documents\Projekte\Sulzer\UserStories_Sulzer\DMAS\DMAS.AEC\10.DMAS_AEC.Materialien\Dataset.HS_12'
csv_input_filepaths = [
	'hs12_country_product_year_1.csv',
	'hs12_country_product_year_2.csv',
	'hs12_country_product_year_4.csv',
	'hs12_country_product_year_6.csv',
	'hs12_country_country_product_year_1.csv',
	'hs12_country_country_product_year_2.csv',
	'hs12_country_country_product_year_4_2012_2016.csv'
]
 
os.chdir(csv_path)
try:
    # Process each path
    for path in csv_input_filepaths:
 
        # Create table with filename (i.e. "survey1.csv" will load with a table name of survey1)
        filename, _ext = os.path.splitext(os.path.basename(path))
        table_name = 'RAW_'+file_name.upper()

        start_sec = time.time()
        start = time.localtime(start_sec)
        print("=== Reading:   {0:s}  (Start: {1:02d}:{2:02d}:{3:02d})".format(path, start.tm_hour, start.tm_min, start.tm_sec))
        # Use pandas to load data with headers and use existing datatypes to populate schema
        data = pd.read_csv(path)

        load_sec = time.time()
        print("=== Loading:   {0:s}  (Load: {1:02d}:{2:02d}:{3:02d})".format(path, start.tm_hour, start.tm_min, start.tm_sec))
        # Store into Snowflake with table name from code above
        data.to_sql(table_name, engine, index = False, chunksize = 20000, if_exists = 'replace')
        ende_sec = time.time()
        ende = time.localtime(ende_sec)
        print("---     Ready:   {0:5d} [sec]  (Ende: {1:02d}:{2:02d}:{3:02d})".format(int(ende_sec-start_sec), ende.tm_hour, ende.tm_min, ende.tm_sec))
 
finally:
    # Disconnect engine
    engine.dispose()
