import pandas as pd
import csv
from datetime import datetime
import os
from Differ import load_dot_file

# Función para convertir tiempo en formato "HH:MM:SS" a segundos
def get_segundos(tiempo_str):
    tiempo_objeto = datetime.strptime(tiempo_str, '%H:%M:%S')
    segundos = tiempo_objeto.hour * 3600 + tiempo_objeto.minute * 60 + tiempo_objeto.second
    return segundos

def getListaSubjects(data):
    subjects = []
    for i in range(len(data)):
        subjects.append(getSubject(data[i]))
    return subjects

def getSubject(row):
    sufix = "Config_k=n"
    subject = row[SUBJ_I].strip()[:-len(sufix)] + "_Mode"
    subject += ".epa" if row[MODE_I] == "epa" else ".states"
    return subject
    
def getMode(row):
    return row[MODE_I]

def getTime(row):
    return get_segundos(row[TIME_I])

def getTotalMethods(row):
    return row[FN_I]



def getRowWithSubjectMode(data, subject, mode):
    for row in data.values:
        if subject == getSubject(row) and getMode(row) == mode:
            return row
    return []

# Nombre del archivo CSV generado con tabulate
nombre_archivo_k4 = 'k4.csv'
nombre_archivo_k8 = 'k8.csv'
nombre_archivo_k16 = 'k16.csv'


#header = ["Subject","mode",        "k=4",                   "k=8",                "k=16"]
header = ["Subject","mode","#M", "time","new tx","to tx","time","new tx","to tx", "time","new tx","to tx"]

file_k4 = pd.read_csv(nombre_archivo_k4, delimiter=",", header=None)
file_k8 = pd.read_csv(nombre_archivo_k8, delimiter=",", header=None)
file_k16 = pd.read_csv(nombre_archivo_k16, delimiter=",", header=None)
SUBJ_I = 0
MODE_I = 1
TIME_I = 2
FN_I = 6
_mode = ""
repo_path = ""
data = []
repo_path = "D:\\Documentos\\Git\\SolidityAbstractor\\graph\\"

for row in file_k4.values:
    subject, mode, time = getSubject(row), getMode(row), getTime(row)
    path_subject_k4 = os.path.join(repo_path, f"k_{4}", "to_600", subject)
    path_subject_k8 = os.path.join(repo_path, f"k_{8}", "to_600", subject)
    path_subject_k16 = os.path.join(repo_path, f"k_{16}", "to_600", subject)
    
    k4_txs = -1 if not os.path.exists(path_subject_k4) else load_dot_file(path_subject_k4, False)[2]
    k4_txs_to = -1 if not os.path.exists(path_subject_k4) else load_dot_file(path_subject_k4, True)[2]
    k8_txs = -1 if not os.path.exists(path_subject_k8) else load_dot_file(path_subject_k8, False)[2]
    k8_txs_to = -1 if not os.path.exists(path_subject_k8) else load_dot_file(path_subject_k8, True)[2]
    k16_txs = -1 if not os.path.exists(path_subject_k16) else load_dot_file(path_subject_k16, False)[2]
    k16_txs_to = -1 if not os.path.exists(path_subject_k16) else load_dot_file(path_subject_k16, True)[2]
    
    subject_info = [subject, mode, getTotalMethods(row), time, k4_txs, (k4_txs_to-k4_txs)]
    subject_info_aux = ["-", "-", "-"]
    row = getRowWithSubjectMode(file_k8, subject, mode)
    if len(row)> 0:
        subject_info_aux = [getTime(row), k8_txs-k4_txs, k8_txs_to-k8_txs]
    subject_info.extend(subject_info_aux)
    
    subject_info_aux = ["-", "-", "-"]
    row = getRowWithSubjectMode(file_k16, subject, mode)
    if len(row)> 0:
        subject_info_aux = [getTime(row), k16_txs-k8_txs, k16_txs_to-k16_txs]
    subject_info.extend(subject_info_aux)
    
    data.append(subject_info)


df = pd.DataFrame(data, columns=header)
# df['% increase'] = round(((df['k=10'] - df['k=4']) / df['k=4'])*100,2)

# df = df.sort_values('mode')

# print(df)

tabla_latex = df.to_latex(index=False)
print("Tabla en formato LaTeX:")
print(tabla_latex)
