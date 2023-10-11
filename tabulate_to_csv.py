import pandas as pd
from datetime import datetime

# Función para convertir tiempo en formato "HH:MM:SS" a segundos
def get_segundos(tiempo_str):
    tiempo_objeto = datetime.strptime(tiempo_str, '%H:%M:%S')
    segundos = tiempo_objeto.hour * 3600 + tiempo_objeto.minute * 60 + tiempo_objeto.second
    return segundos

# Nombre del archivo CSV generado con tabulate
nombre_archivo = 'copiaTiempos-2023-08-14 16-16-45.922855.csv'


# Leer el archivo de texto
with open(nombre_archivo, 'r') as archivo:
    lineas = archivo.readlines()
    
_nuevo_caso = ""
_mode = ""
header = ["Subject","mode","k=4","k=5","k=6","k=7","k=8","k=9","k=10"]
data = []
i = 1
### REQUIERE QUE NO ESTE INTERCALADO LOS MODOS!!! ###
while i < len(lineas):
    subject, mode, time,_,_,_,_ = lineas[i].strip().split(',')
    time = get_segundos(time)
    if _nuevo_caso == "":
        subject_info = []
        _nuevo_caso = subject[:subject.index("_k")]
        _mode = mode
        k = subject[subject.index("_")+3:]
        subject_info.append(_nuevo_caso.replace("Config",""))
        subject_info.append(mode)
        subject_info.append(time)
        i += 1
    else:
        if _nuevo_caso == subject[:subject.index("_k")] and _mode == mode:
            subject_info.append(time)
            i+=1
        else:
            _nuevo_caso = ""
            data.append(subject_info)
            print(subject_info)
data.append(subject_info)


df = pd.DataFrame(data, columns=header)
df['% increase'] = round(((df['k=10'] - df['k=4']) / df['k=4'])*100,2)

# df = df.sort_values('mode')

# print(df)

tabla_latex = df.to_latex(index=False)
print("Tabla en formato LaTeX:")
print(tabla_latex)
