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
    sufix = "Config_k"
    sufix_idx = row[SUBJ_I].strip().index(sufix)
    subject = row[SUBJ_I].strip()[:sufix_idx] + "_Mode"
    subject += ".epa" if row[MODE_I] == "epa" else ".states"
    return subject
    
def getMode(row):
    return row[MODE_I]

def getTime(row):
    return get_segundos(row[TIME_I])

# def getTotalMethods(row):
#     return row[FN_I]



def getRowWithSubjectMode(data, subject, mode):
    for row in data.values:
        if subject == getSubject(row) and getMode(row) == mode:
            return row
    return []

# Nombre del archivo CSV generado con tabulate
nombre_archivo_k4 = 'B2_k4.csv'
nombre_archivo_k8 = 'B2_k8.csv'
nombre_archivo_k16 = 'B2_k16.csv'


header = ["Subject","mode", "time","new tx","to tx","time","new tx","to tx", "time","new tx","to tx"]

file_k4 = pd.read_csv(nombre_archivo_k4, delimiter=",", header=None)
file_k8 = pd.read_csv(nombre_archivo_k8, delimiter=",", header=None)
file_k16 = pd.read_csv(nombre_archivo_k16, delimiter=",", header=None)
SUBJ_I = 0
MODE_I = 1
TIME_I = 2
# FN_I = 6
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
    
    if k8_txs>0 and k8_txs<k4_txs or k16_txs>0 and k16_txs<k8_txs:
        print(f"Error en {subject}")
        import pydot
        graphk4 = pydot.graph_from_dot_file(path_subject_k4)[0]
        graphk8 = pydot.graph_from_dot_file(path_subject_k8)[0]
        graphk16 = pydot.graph_from_dot_file(path_subject_k16)[0]
        
        #Filtrar los edges que no tienen label con "?" en k=8
        edgesk4 = [edge for edge in graphk4.get_edge_list() if "?" not in edge.get('label')]
        edgesk8 = [edge for edge in graphk8.get_edge_list() if "?" not in edge.get('label')]
        edgesk16 = [edge for edge in graphk16.get_edge_list() if "?" not in edge.get('label')]
        if k8_txs>0 and len(set(edgesk4)) > len(set(edgesk8)):
            print("Ey! hay ejes de k=4 a k=8 que se perdieron!")
        if k16_txs>0 and len(set(edgesk8)) > len(set(edgesk16)):
            print("Ey! hay ejes de k=8 a k=16 que se perdieron!")
        
        #Mostrar los edges que están en edgesk8 pero no están en edgesk16
        missing_edges = [edge for edge in edgesk8 if edge not in graphk16.get_edge_list()]
        print("Edges present in k=8 but not in k=16:")
        for edge in missing_edges:
            print(edge)
            print("")
        continue
    
    subject_parsed = subject.replace("_Mode.states","").replace("_Mode.epa","")
    subject_info = [subject_parsed, mode, time, k4_txs, (k4_txs_to-k4_txs)]
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
