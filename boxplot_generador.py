import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math


def convertir_a_segundos(hhmmss):
    """
    Convierte una cadena en formato HH:mm:ss a segundos como entero.

    Args:
        hhmmss (str): Cadena en formato HH:mm:ss.

    Returns:
        int: Número total de segundos.
    """
    try:
        print("convertir_a_segundos", hhmmss)
        h, m, s = map(int, hhmmss.split(":"))
        return h * 3600 + m * 60 + s
    except ValueError:
        print(f"Formato inválido: {hhmmss}")
        return None

def generar_boxplot_personalizado(csv_file, column_index=1, output_image="boxplot_personalizado.png"):
    """
    Genera un boxplot personalizado a partir de una columna específica de un archivo CSV.

    Args:
        csv_file (str): Ruta al archivo CSV.
        column_index (int): Índice de la columna a usar (0 basado). Por defecto es 1.
        output_image (str): Nombre del archivo de imagen de salida para el boxplot.
    """
    try:
        # Leer el archivo CSV
        data = pd.read_csv(csv_file)
        
        # Asegurar que el índice de la columna sea válido
        if column_index >= len(data.columns):
            raise IndexError(f"El archivo CSV no tiene suficientes columnas. Índice proporcionado: {column_index}")
        
        # Seleccionar la columna por índice
        column_name = data.columns[column_index]
        values = data[column_name]
        
        # Generar el boxplot personalizado
        plt.figure(figsize=(6, 8))
        box = plt.boxplot(
            values,
            vert=True,
            patch_artist=True,
            boxprops=dict(facecolor='palegreen', color='black'),
            whiskerprops=dict(color='black'),
            capprops=dict(color='black'),
            medianprops=dict(color='black', linewidth=2),
        )
        
        # Configurar título y etiquetas
        plt.title(f"Boxplot de la columna: {column_name}")
        plt.ylabel(column_name)
        
        # Guardar la imagen
        plt.savefig(output_image)
        print(f"Boxplot personalizado guardado como {output_image}")
        
        # Mostrar el gráfico
        plt.show()
    
    except FileNotFoundError:
        print(f"Archivo no encontrado: {csv_file}")
    except Exception as e:
        print(f"Ocurrió un error: {e}")

def generar_histograma(csv_file, column_index=1, output_image="histograma.png", bins=20):
    """
    Genera un histograma a partir de una columna específica de un archivo CSV,
    filtrando valores extremos (outliers).

    Args:
        csv_file (str): Ruta al archivo CSV.
        column_index (int): Índice de la columna a usar (0 basado). Por defecto es 1.
        output_image (str): Nombre del archivo de imagen de salida para el histograma.
        bins (int): Número de bins para el histograma.
    """
    try:
        # Leer el archivo CSV
        data = pd.read_csv(csv_file)
        
        # Asegurar que el índice de la columna sea válido
        if column_index >= len(data.columns):
            raise IndexError(f"El archivo CSV no tiene suficientes columnas. Índice proporcionado: {column_index}")
        
        # Seleccionar la columna por índice
        column_name = data.columns[column_index]
        data[column_name] = data[column_name].apply(convertir_a_segundos)
        values = data[column_name].dropna()
        
        # Filtrar valores extremos (outliers) usando el rango intercuartil (IQR)
        Q1 = np.percentile(values, 25)  # Primer cuartil
        Q3 = np.percentile(values, 75)  # Tercer cuartil
        IQR = Q3 - Q1
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        filtered_values = values[(values >= lower_bound) & (values <= upper_bound)]
        
        # Generar el histograma
        plt.figure(figsize=(8, 6))
        plt.hist(filtered_values, bins=bins, color='skyblue', edgecolor='black')
        plt.title(f"Histograma de la columna: {column_name} (filtrado)")
        plt.xlabel(column_name)
        plt.ylabel("Frecuencia")
        
        # Guardar la imagen
        plt.savefig(output_image)
        print(f"Histograma guardado como {output_image}")
        
        # Mostrar el gráfico
        plt.show()
    
    except FileNotFoundError:
        print(f"Archivo no encontrado: {csv_file}")
    except Exception as e:
        print(f"Ocurrió un error: {e}")

# Ejemplo de uso
csv_path = r"C:\Users\j_god\Repos\SolidityAbstractor\graph\k_8\to_600\resumen_query_time.csv"
column_index=2
#csv_path = r"C:\Users\j_god\Repos\SolidityAbstractor\tiempo_total_todos.csv"
#generar_boxplot_personalizado(csv_path, column_index=2, output_image="boxplot_tiempo_total.png")

# generar_histograma(csv_path)

import matplotlib.pyplot as plt



# Convertir tiempos a segundos
def time_to_seconds(time_str):
    h, m, s = map(int, time_str.split(":"))
    return h * 3600 + m * 60 + s


def generar_histograma():
    # Datos
    cant = [21, 13, 4, 6, 10, 6, 4]
    minutos = [1, 2, 3, 10, 15, 30, 60]
    max_time = ["0:00:57", "0:01:51", "0:02:48", "0:09:18", "0:14:11", "0:28:32", "0:52:34"]

    max_seconds = [time_to_seconds(t) for t in max_time]
    
    # Gráfico 1: Histograma (Cantidad vs Minutos)
    plt.figure(figsize=(10, 5))
    plt.bar(minutos, cant, width=2, color='skyblue', edgecolor='black')
    plt.xlabel("Intervalo de minutos")
    plt.ylabel("Cantidad")
    plt.title("Distribución de Cantidad por Intervalo de Tiempo")
    plt.xticks(minutos)
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.show()

    # Gráfico 2: Línea (Máximos vs Minutos)
    plt.figure(figsize=(10, 5))
    plt.plot(minutos, max_seconds, marker='o', color='green', label='Tiempo Máximo')
    plt.xlabel("Intervalo de minutos")
    plt.ylabel("Máximo tiempo (segundos)")
    plt.title("Tiempo Máximo por Intervalo")
    plt.xticks(minutos)
    plt.grid(linestyle='--', alpha=0.7)
    plt.legend()
    plt.show()

generar_histograma()