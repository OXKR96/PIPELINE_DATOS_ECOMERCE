from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
        database (Engine): SQLAlchemy database engine
    """
    # Por cada DataFrame en el diccionario, usar pandas.DataFrame.to_sql() 
    # para cargar el DataFrame en la base de datos como una tabla.
    # Para el nombre de la tabla, utiliza las claves del diccionario `data_frames`.
    for table_name, dataframe in data_frames.items():
        dataframe.to_sql(table_name, database, if_exists='replace', index=False)