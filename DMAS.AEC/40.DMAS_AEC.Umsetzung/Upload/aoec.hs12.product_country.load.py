# The Snowpark package is required for Python Worksheets. 
# You can add more packages by selecting them using the Packages control and then importing them.

import sys
import os
import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
import pandas as pd

def main(session: snowpark.Session): 
    # Your code goes here, inside the "main" handler.

    print('=== Start')
    from snowflake.snowpark.context import get_active_session
    session = get_active_session()
    session.query_tag = {"origin":"sf_sit-is", 
                         "name":"load_aoec_hs12_stata_data", 
                         "version":{"major":1, "minor":0},
                         "attributes":{"is_quickstart":1, "source":"notebook", "vignette":"table_from_stata_file"}}

    objs = [
        ('aoec_files_hs12/hs12_country_country_product_year_1.dta.gz',              'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1'),
        ('aoec_files_hs12/hs12_country_country_product_year_2.dta.gz',              'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2'),
        ('aoec_files_hs12/hs12_country_country_product_year_4_2012_2016.dta.gz',    'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016'),
        ('aoec_files_hs12/hs12_country_product_year_1.dta.gz',                      'RAW_HS12_COUNTRY_PRODUCT_YEAR_1'),
        ('aoec_files_hs12/hs12_country_product_year_2.dta.gz',                      'RAW_HS12_COUNTRY_PRODUCT_YEAR_2'),
        ('aoec_files_hs12/hs12_country_product_year_4.dta.gz',                      'RAW_HS12_COUNTRY_PRODUCT_YEAR_4'),
        ('aoec_files_hs12/hs12_country_product_year_6.dta.gz',                      'RAW_HS12_COUNTRY_PRODUCT_YEAR_6')
    ]
    for (F, T) in objs:
        print('Tab: '+T+',   File: '+F)

    for (F, T) in objs:
        try:
            stage_path = "@" + F
            _ = session.file.get(stage_path, "stata_files")
            os.listdir("stata_files")
    
            # Read Stata data format
            df_dta = pd.read_stata("stata_files/" + os.path.basename(F))
    
            # SN-Column names are upper cases
            df_dta.columns = map(lambda x: str(x).upper(), df_dta.columns)
    
            #
            session.write_pandas(df_dta, T, database='DMAS', schema='AOEC')
        except:
            print(repr(sys.exception()))
            raise repr(sys.exception()) 
            
    # =============================================================================================
    # Abschliessende Zaehlung
    sql_cmd = ''
    for (_, T) in objs:
        T = T.strip()
        sql_cmd = sql_cmd + (('' if sql_cmd == '' else ' union all ') + "select '"+T+"' as Tab, count(*) from DMAS.AOEC."+T)
    #sql_cmd = sql_cmd + ';'
    print(sql_cmd)
    try:
        res = session.sql(sql_cmd)
        res.show()
    except:
        print(repr(sys.exception()))
        raise repr(sys.exception()) 
        
    
    #tableName = 'information_schema.packages'
    #dataframe = session.table(tableName).filter(col("language") == 'python')

    # Print a sample of the dataframe to standard output.
    #dataframe.show()

    # Return value will appear in the Results tab.
    return res