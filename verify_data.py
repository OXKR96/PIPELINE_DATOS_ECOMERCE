import os
import sys
import requests
import pandas as pd

# Agregar el directorio del proyecto al path de Python
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

# Importar desde src
from src.config import DATASET_ROOT_PATH, PUBLIC_HOLIDAYS_URL, get_csv_to_table_mapping

def verify_csv_data():
    """
    Verificar la carga de datos desde archivos CSV
    """
    print("=== Verificación de Datos CSV ===")
    
    # Obtener el mapeo de archivos CSV
    csv_mapping = get_csv_to_table_mapping()
    
    # Ruta de la carpeta de datasets
    dataset_folder = DATASET_ROOT_PATH
    
    for csv_file, table_name in csv_mapping.items():
        file_path = os.path.join(dataset_folder, csv_file)
        
        try:
            # Intentar leer el CSV
            df = pd.read_csv(file_path)
            
            print(f"\nArchivo: {csv_file}")
            print(f"Tabla: {table_name}")
            print(f"Número de filas: {len(df)}")
            print(f"Columnas: {', '.join(df.columns)}")
            print("-" * 50)
        
        except Exception as e:
            print(f"Error al leer {csv_file}: {e}")

def verify_holidays_api_data():
    """
    Verificar la obtención de datos de días festivos desde la API
    """
    print("\n=== Verificación de Datos de Días Festivos ===")
    
    try:
        # URL de la API de días festivos
        full_url = f"{PUBLIC_HOLIDAYS_URL}/2017/BR"
        
        # Realizar la solicitud GET
        response = requests.get(full_url)
        
        # Verificar el estado de la respuesta
        response.raise_for_status()
        
        # Convertir la respuesta a DataFrame
        holidays_data = response.json()
        holidays_df = pd.DataFrame(holidays_data)
        
        print("Datos de días festivos obtenidos correctamente:")
        print(f"Número de días festivos: {len(holidays_df)}")
        print("\nPrimeros 5 días festivos:")
        print(holidays_df[['date', 'name']].head())
    
    except requests.RequestException as e:
        print(f"Error al obtener días festivos: {e}")
    except Exception as e:
        print(f"Error inesperado: {e}")

def main():
    """
    Función principal para ejecutar todas las verificaciones
    """
    verify_csv_data()
    verify_holidays_api_data()

if __name__ == "__main__":
    main()