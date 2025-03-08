from typing import Dict

import requests
from pandas import DataFrame, read_csv, to_datetime

def temp() -> DataFrame:
    """Get the temperature data.
    Returns:
        DataFrame: A dataframe with the temperature data.
    """
    return read_csv("data/temperature.csv")

def get_public_holidays(public_holidays_url: str, year: str) -> DataFrame:
    """Get the public holidays for the given year for Brazil.
    Args:
        public_holidays_url (str): url to the public holidays.
        year (str): The year to get the public holidays for.
    Raises:
        SystemExit: If the request fails.
    Returns:
        DataFrame: A dataframe with the public holidays.
    """
    # Construir la URL completa para los días festivos de Brasil
    full_url = f"{public_holidays_url}/{year}/BR"
    
    try:
        # Usar la biblioteca requests para obtener los días festivos públicos del año dado
        response = requests.get(full_url)
        
        # Usar raise_for_status() para manejar errores de solicitud
        response.raise_for_status()
        
        # Convertir la respuesta a DataFrame
        holidays_data = response.json()
        holidays_df = DataFrame(holidays_data)
        
        # Eliminar las columnas "types" y "counties"
        columns_to_drop = ['types', 'counties']
        for col in columns_to_drop:
            if col in holidays_df.columns:
                holidays_df = holidays_df.drop(columns=[col])
        
        # Convertir la columna "date" a datetime
        holidays_df['date'] = to_datetime(holidays_df['date'])
        
        return holidays_df
    
    except requests.RequestException as e:
        # Lanzar SystemExit si la solicitud falla
        raise SystemExit(f"Error al obtener días festivos: {e}")


def extract(
    csv_folder: str, csv_table_mapping: Dict[str, str], public_holidays_url: str
) -> Dict[str, DataFrame]:
    """Extract the data from the csv files and load them into the dataframes.
    Args:
        csv_folder (str): The path to the csv's folder.
        csv_table_mapping (Dict[str, str]): The mapping of the csv file names to the
        table names.
        public_holidays_url (str): The url to the public holidays.
    Returns:
        Dict[str, DataFrame]: A dictionary with keys as the table names and values as
        the dataframes.
    """
    dataframes = {
        table_name: read_csv(f"{csv_folder}/{csv_file}")
        for csv_file, table_name in csv_table_mapping.items()
    }

    holidays = get_public_holidays(public_holidays_url, "2017")

    dataframes["public_holidays"] = holidays

    return dataframes