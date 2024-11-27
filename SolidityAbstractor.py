import itertools
import subprocess
import os
import shutil
import numpy  as np
import graphviz
from threading import Thread
import time
from enum import Enum
import sys
import platform
import psutil
import remove_unknown_tx
import concurrent.futures

def getCombinations(funcionesNumeros):
    global statePreconditions
    indices_con_truePreconditions = []
    results = []
    statesTemp = []
    cantidad_funciones = len(funcionesNumeros)
    for index, statePrecondition in enumerate(statePreconditions):
        if statePrecondition == "true":
            indices_con_truePreconditions.append(index + 1)#se suma 1 porque funcionesNumeros empieza en 1

    # Combinations
    for L in range(len(funcionesNumeros) + 1):
        for subset in itertools.combinations(funcionesNumeros, L):
            if reducedTrue:
                isTrue = True
                for truePre in indices_con_truePreconditions:
                    if truePre not in subset:
                        isTrue = False
                if isTrue == True:
                    results.append(subset)
            else:
                results.append(subset)

    for partialResult in results:
        paddingResult = []
        paddingResult = [0 for _ in range(cantidad_funciones)] 
        for i in range(cantidad_funciones):
            if len(partialResult) > i and partialResult[i] >=0:
                indice = partialResult[i]
                paddingResult[indice-1] = indice
        statesTemp.append(paddingResult)
    statesTemp2 = []
    
    if not(reducedEqual):
        for combination in statesTemp:
            isCorrect = True
            for iNumber, number in enumerate(combination):
                for idx, x in enumerate(statePreconditions):
                    if iNumber != idx:
                        if number == 0:
                            if statePreconditions[iNumber] == x and combination[idx] != 0:
                                isCorrect = False
                        elif statePreconditions[iNumber] == x and not((idx+1) in combination):
                            isCorrect = False
            
            if isCorrect:
                statesTemp2.append(combination)
    else:
        statesTemp2 = statesTemp       
    return statesTemp2

def getPreconditions(funcionesNumeros):
    global states, statePreconditions
    preconditions = []
    for result in states:
        precondition = ""
        for number in funcionesNumeros:
            if precondition != "":
                precondition += " && "
            if number in result:
                precondition += statePreconditions[number-1]
            else:
                precondition += "!(" + statePreconditions[number-1] + ")"
        preconditions.append(precondition)
    return preconditions

def combinationToString(combination):
    output = ""
    for i in combination:
        output += str(i) + "-"
    return output

def functionOutput(number):
    return "function vc" + number + "(" + functionVariables + ") payable public {"

def getToolCommand(includeNumber, toolCommand, combinations, txBound, trackAllVars):
    global contractName
    command = toolCommand + " " 
    command = command + "/txBound:" + str(txBound) + " "
    command = command + "/noPrf "
    if trackAllVars:
        command = command + "/trackAllVars"+ " "
    for indexCombination, combi in enumerate(combinations):
        if combi != includeNumber: 
            command += "/ignoreMethod:vc"+ combi +"@" + contractName + " "
    # print(command)
    return command

def get_extra_condition_output(condition):
    extraConditionOutput = ""
    if condition != "" and condition != None:
        extraConditionOutput = "require("+condition+");\n"
    return extraConditionOutput 

def output_transitions_function(preconditionRequire, function, preconditionAssert, functionIndex, extraConditionPre, extraConditionPost):
    if mode == Mode.epa:
        precondictionFunction = functionPreconditions[functionIndex]
    else:
        precondictionFunction = "true"
    extraConditionOutputPre = get_extra_condition_output(extraConditionPre)
    extraConditionOutputPost = get_extra_condition_output(extraConditionPost)
    verisolFucntionOutput = "require("+preconditionRequire+");//requiere para estado inicial\nrequire("+precondictionFunction+");//require para precondición de parámetros\n" + extraConditionOutputPre + function + "\n"  + "assert(!(" + preconditionAssert + "&& " + extraConditionPost + "));//Llego a estado final\n"
    return verisolFucntionOutput

def output_init_function(preconditionAssert, extraCondition):
    extraConditionOutput = get_extra_condition_output(extraCondition)
    verisolFucntionOutput =  extraConditionOutput + "assert(!(" + preconditionAssert + "));\n"
    return verisolFucntionOutput

def output_valid_state(preconditionRequire, extraCondition):
    extraConditionOutput = get_extra_condition_output(extraCondition)
    return "require("+preconditionRequire+");\n" + extraConditionOutput + "assert(false);\n"

def output_combination(indexCombination, tempCombinations):
    combination = tempCombinations[indexCombination]
    output = ""
    for function in combination:
        if function != 0:
            if mode == Mode.epa:
                output += functions[function-1] +"\n"
            else:
                output += statesNames[function-1]

    if output == "":
        output = "Vacio\n"
    return output

def print_combination(indexCombination, tempCombinations):
    output = output_combination(indexCombination, tempCombinations)
    if basic_mode == False:
        print(output + "---------")

def print_output(indexPreconditionRequire, indexFunction, indexPreconditionAssert, combinations, fullCombination, succes_by_to):
    output ="Desde este estado:\n"+ output_combination(indexPreconditionRequire, combinations) + "\nHaciendo " + str(functions[indexFunction]+succes_by_to) + "\n\nLlegas al estado:\n" + output_combination(indexPreconditionAssert, fullCombination) + "\n---------"
    if basic_mode == False or succes_by_to != "":
        print(output)

def create_directory(index):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, r'output'+str(index))
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)
    return final_directory

def create_directory_base(name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)
    return final_directory

def delete_directory(final_directory):
    try:
        shutil.rmtree(final_directory)
    except Exception as e:
        print("Excepción al querer borrar carpeta: " + str(e))

def create_file(index, final_directory):
    global contractName, fileName
    fileNameTemp = "OutputTemp"+str(index)+".sol"
    fileNameTemp = os.path.join(final_directory, fileNameTemp)
    if os.path.isfile(fileNameTemp):
        os.remove(fileNameTemp)
    shutil.copyfile(fileName, fileNameTemp)
    return fileNameTemp

def create_file_base(final_directory, name):
    global contractName, fileName
    fileNameTemp = os.path.join(final_directory, name)
    if os.path.isfile(fileNameTemp):
        os.remove(fileNameTemp)
    shutil.copyfile(fileName, fileNameTemp)
    return fileNameTemp

def write_file(fileNameTemp, body):
    inputfile = open(fileNameTemp, 'r').readlines()
    write_file = open(fileNameTemp,'w')
    for line in inputfile:
        write_file.write(line)
        if 'contract ' + contractName in line:
                write_file.write(body)
    write_file.close()

def get_valid_preconditions_output(preconditions, extraConditions):
    temp_output = ""
    tempFunctionNames = []
    for indexPreconditionRequire, preconditionRequire in enumerate(preconditions):
        functionName = get_temp_function_name(indexPreconditionRequire, "0", "0")
        tempFunctionNames.append(functionName)
        temp_function = functionOutput(functionName) + "\n"
        temp_function += output_valid_state(preconditionRequire, extraConditions[indexPreconditionRequire])
        temp_output += temp_function + "}\n"
    return temp_output, tempFunctionNames

def get_valid_transitions_output(arg, preconditionsThread, preconditions, extraConditionsTemp, extraConditions, functions, statesThread): 
    global mode
    temp_output = ""
    tempFunctionNames = []
    for indexPreconditionRequire, preconditionRequire in enumerate(preconditionsThread):
        #TODO refactorizar esto, no tiene sentido que se pase el indexPreconditionRequire
        #busco el índice real de la precondición, preconditionsThread va a tener solo un elemento, por lo que indexPreconditionRequire siempre es 0
        for indexPreconditionAssert, preconditionAssert in enumerate(preconditions):
            if str(preconditionRequire) == str(preconditionAssert):
                indexPreconditionRequireReal = indexPreconditionRequire
                break
        for indexPreconditionAssert, preconditionAssert in enumerate(preconditions):
            for indexFunction, function in enumerate(functions):
                extraConditionPre = extraConditionsTemp[indexPreconditionRequire]
                extraConditionPost = extraConditions[indexPreconditionAssert]
                if ((indexFunction + 1) in statesThread[indexPreconditionRequire] and mode == Mode.epa) or (mode == Mode.states):
                    functionName = get_temp_function_name(indexPreconditionRequireReal, indexPreconditionAssert, indexFunction)
                    tempFunctionNames.append(functionName)
                    temp_function = functionOutput(functionName) + "\n"
                    temp_function += output_transitions_function(preconditionRequire, function, preconditionAssert, indexFunction, extraConditionPre, extraConditionPost)
                    temp_output += temp_function + "}\n"
                    # TODO ejecutar aca Verisol para cada fn?
                    dirname = str(arg)+"_"+functionName
                    final_directory = create_directory(dirname)
                    fileNameTemp = create_file(dirname, final_directory)
                    write_file(fileNameTemp, temp_output)
                    tool = "VeriSol " + fileNameTemp + " " + contractName
                    try_transaction(tool, tempFunctionNames, final_directory, statesThread, states, arg)
                    if not verbose:
                        delete_directory(final_directory)
                    tempFunctionNames = []
                    temp_output = ""
    return temp_output, tempFunctionNames

# def get_init_output(preconditions, extraConditions): 
#     temp_output = ""
#     tempFunctionNames = []
#     for indexPreconditionAssert, preconditionAssert in enumerate(preconditions):
#         functionName = get_temp_function_name(indexPreconditionAssert, "0" , "0")
#         tempFunctionNames.append(functionName)
#         temp_function = functionOutput(functionName) + "\n"
#         temp_function += output_init_function(preconditionAssert, extraConditions[indexPreconditionAssert])
#         temp_output += temp_function + "}\n"
#     return temp_output, tempFunctionNames

def get_init_output(indexPreconditionAssert, preconditionAssert, extraConditions): 
    temp_output = ""
    functionName = get_temp_function_name(indexPreconditionAssert, "0" , "0")
    temp_function = functionOutput(functionName) + "\n"
    temp_function += output_init_function(preconditionAssert, extraConditions[indexPreconditionAssert])
    temp_output += temp_function + "}\n"
    return functionName, temp_output

def try_preconditions(tool, tempFunctionNames, final_directory, statesTemp, preconditionsTemp, extraConditionsTemp, arg): 
    global txBound, time_out
    preconditionsTemp2 = []
    statesTemp2 = []
    extraConditionsTemp2 = []
    
    for functionName in tempFunctionNames:
        if basic_mode == False:
            print(functionName + "---" + str(arg))
        indexPreconditionRequire, _, _ = get_params_from_function_name(functionName)
        query_result = try_command(tool, functionName, tempFunctionNames, final_directory, statesTemp, txBound, time_out, False)
        if query_result[1] == TRACK_VARS:
            query_result = try_command(tool, functionName, tempFunctionNames, final_directory, statesTemp, txBound, time_out, True)
        success = query_result[0]
        if success:
            # print_combination(indexPreconditionRequire, statesTemp)
            preconditionsTemp2.append(preconditionsTemp[indexPreconditionRequire])
            statesTemp2.append(statesTemp[indexPreconditionRequire])
            extraConditionsTemp2.append(extraConditionsTemp[indexPreconditionRequire])
            if query_result[1] != "":
                print("[try_preconditions] Time out en función: " + functionName + " desde estado inicial:")
                i_state = output_combination(indexPreconditionRequire, statesTemp)
                print(i_state)
    return preconditionsTemp2, statesTemp2, extraConditionsTemp2

def try_transaction(tool, tempFunctionNames, final_directory, statesTemp, states, arg):
    global txBound, time_out
    for functionName in tempFunctionNames:
        if basic_mode == False:
            print(functionName + "---" + str(arg))
        indexPreconditionRequire, indexPreconditionAssert, indexFunction = get_params_from_function_name(functionName)
        
        query_result = try_command(tool, functionName, tempFunctionNames, final_directory, statesTemp, txBound, time_out, False)
        if query_result[1] == TRACK_VARS:
            query_result = try_command(tool, functionName, tempFunctionNames, final_directory, statesTemp, txBound, time_out, True)
        success = query_result[0]
        succes_by_timeout = query_result[1]
        if success:
            add_node_to_graph(indexPreconditionRequire, indexPreconditionAssert, indexFunction, statesTemp, states, succes_by_timeout)
            print_output(indexPreconditionRequire, indexFunction, indexPreconditionAssert, statesTemp, states, succes_by_timeout)

def try_init(states, preconditionAssertTuple):
    global dot, time_out
    
    indexPreconditionAssert = preconditionAssertTuple[0]
    preconditionAssert = preconditionAssertTuple[1]
    functionName, body = get_init_output(indexPreconditionAssert, preconditionAssert, extraConditions)
    dirname = f"_init_{indexPreconditionAssert}_{functionName}"
    final_directory = create_directory(dirname)
    fileNameTemp = create_file(dirname, final_directory)
    write_file(fileNameTemp, body)
    tool = "VeriSol " + fileNameTemp + " " + contractName
    txBound_constructor = 1
    tempFunctionNames = [] # Esto se usa para ignorar metodos que no sean functionName, pero ahora tengo una función tipo query por archivo
    query_result = try_command(tool, functionName, tempFunctionNames, final_directory, [], txBound_constructor, time_out, False)
    if query_result[1] == TRACK_VARS:
        query_result = try_command(tool, functionName, tempFunctionNames, final_directory, [], txBound_constructor, time_out, True)
    success = query_result[0]
    succes_by_to = query_result[1]
    if success:
        dot.node("init", "init")
        dot.node(combinationToString(states[indexPreconditionAssert]), output_combination(indexPreconditionAssert, states))
        dot.edge("init",combinationToString(states[indexPreconditionAssert]) , "constructor"+succes_by_to)
        
    if not verbose:
        delete_directory(final_directory)


def try_command(tool, temp_function_name, tempFunctionNames, final_directory, statesTemp, txBound, time_out, trackAllVars):
    global tool_output, verbose, number_to, number_corral_fail, number_corral_fail_with_tackvars
    ADD_TX_IF_TIMEOUT = False
    ADD_TX_IF_FAIL = False
    # trackAllVars = True #
    
    #Evito chequear funciones "dummy"
    if len(statesTemp) > 0:
        indexPreconditionRequire, indexPreconditionAssert, indexFunction = get_params_from_function_name(temp_function_name)
        i_state = output_combination(indexPreconditionRequire, statesTemp)
        f_state = output_combination(indexPreconditionAssert, states)
        if functions[indexFunction].startswith("dummy_"):
            if i_state != f_state:
                return (False,"")
            else:
                return (True,"")
    
    command = getToolCommand(temp_function_name, tool, tempFunctionNames, txBound, trackAllVars)
    if verbose:
       print(command)
    result = ""
    FAIL_TO = False
    init = time.time()
    try:
        if platform.system() == "Windows":
            proc = subprocess.Popen(command.split(" "), stdout=subprocess.PIPE, cwd=final_directory)
            result = proc.communicate(timeout=time_out)
            # result = subprocess.check_output(command.split(" "), shell = False, cwd=final_directory, timeout=10.0)#Javi
        else:
            #TODO: run with timeout in unix
            result = subprocess.run([command, ""], shell = True, cwd=final_directory, stdout=subprocess.PIPE)
        end = time.time()
    except Exception as e:
        end = time.time()
        number_to += 1
        print(f"---EXCEPTION por time out de {time_out} segs al ejecutar '{command}' desde folder '{final_directory}'")
        indexPreconditionRequire, indexPreconditionAssert, indexFunction = get_params_from_function_name(temp_function_name)
        i_state = output_combination(indexPreconditionRequire, statesTemp)
        f_state = output_combination(indexPreconditionAssert, states)
        print(f"TimeOut ([indexPre,indexAssert,indxFn][{indexPreconditionRequire},{indexPreconditionAssert},{indexFunction}]) desde state \n{i_state}\n al state \n{f_state}\n con la función '{functions[indexFunction]}'")
        process = psutil.Process(proc.pid)
        for proc in process.children(recursive=True):
            proc.kill()
        process.kill()
        process.wait(2) # wait for killing subprocess
        FAIL_TO = True
    
    
    total_query_time = end - init
    add_query_time(total_query_time, FAIL_TO)

    if FAIL_TO:
        return ADD_TX_IF_TIMEOUT,"?" # Si tiró timeout, retorno False.
    
    output_verisol = str(result[0].decode('utf-8'))
    output_successful = "Formal Verification successful"

    # if verbose:
    #     print(output_verisol)

    if not tool_output in output_verisol and not output_successful in output_verisol:
        print(output_verisol)
    
    #Corral can "fail"
    output_error = "Corral may have aborted abnormally"
    if output_error in output_verisol:
        if not trackAllVars:
            number_corral_fail += 1
            return False,TRACK_VARS
        else:
            number_corral_fail_with_tackvars += 1
            return ADD_TX_IF_FAIL,"fail?" # if corral fails with trackvars, we don't know if it's a real counterexample or not
    return tool_output in output_verisol, ""

def get_temp_function_name(indexPrecondtion, indexAssert, indexFunction):
    return str(indexPrecondtion) + "x" + str(indexAssert) + "x" + str(indexFunction)

def get_params_from_function_name(temp_function_name):
    array = temp_function_name.split('x')
    return int(array[0]), int(array[1]), int(array[2])

def add_node_to_graph(indexPreconditionRequire, indexPreconditionAssert, indexFunction, statesTemp, states, succes_by_to):
    global dot, functions
    dot.node(combinationToString(statesTemp[indexPreconditionRequire]), output_combination(indexPreconditionRequire, statesTemp))
    dot.node(combinationToString(states[indexPreconditionAssert]), output_combination(indexPreconditionAssert, states))
    # transiciones dummy no las agrego
    if not functions[indexFunction].startswith("dummy_"):
        dot.edge(combinationToString(statesTemp[indexPreconditionRequire]),combinationToString(states[indexPreconditionAssert]) , label=str(functions[indexFunction]+succes_by_to))

def reduceCombinations(arg):
    global fileName, preconditionsThreads, statesThreads, extraConditionsThreads, contractName
    preconditionsTemp = preconditionsThreads[arg]
    statesTemp = statesThreads[arg]
    extraConditionsTemp = extraConditionsThreads[arg]
    final_directory = create_directory(arg)
    fileNameTemp = create_file(arg, final_directory)
    body,fuctionCombinations = get_valid_preconditions_output(preconditionsTemp, extraConditionsTemp)
    write_file(fileNameTemp, body)
    tool = "VeriSol " + fileNameTemp + " " + contractName
    preconditionsTemp2, statesTemp2, extraConditionsTemp2 = try_preconditions(tool, fuctionCombinations, final_directory, statesTemp, preconditionsTemp, extraConditionsTemp , arg)
    preconditionsThreads[arg] = preconditionsTemp2
    statesThreads[arg] = statesTemp2
    extraConditionsThreads[arg] = extraConditionsTemp
    if not verbose:
        delete_directory(final_directory)

def validCombinations(arg):
    global preconditionsThreads, statesThreads, extraConditionsThreads, extraConditions, preconditions, states, contractName, fileName, dot
    preconditionsTemp = preconditionsThreads[arg]
    statesTemp = statesThreads[arg]
    extraConditionsTemp = extraConditionsThreads[arg]
    # final_directory = create_directory(arg)
    # fileNameTemp = create_file(arg, final_directory)
    #TODO refactorizar esto, simplificar ahora que se guarda un archivo por query
    body, fuctionCombinations = get_valid_transitions_output(arg, preconditionsTemp, preconditions, extraConditionsTemp, extraConditions, functions, statesTemp)
    # write_file(fileNameTemp, body)
    # tool = "VeriSol " + fileNameTemp + " " + contractName
    # try_transaction(tool, fuctionCombinations, final_directory, statesTemp, states, arg)
    # if not verbose:
    #     delete_directory(final_directory)

def validInit(arg):
    global preconditionsThreads, extraConditions, preconditions, states, contractName, fileName, dot
    # final_directory = create_directory(arg)
    # fileNameTemp = create_file(arg, final_directory)

    # body, fuctionCombinations = get_init_output(preconditions, extraConditions)
    # write_file(fileNameTemp, body)
    
    # tool = "VeriSol " + fileNameTemp + " " + contractName
    # try_init(tool, fuctionCombinations, final_directory, states)
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
        for indexPreconditionAssert, preconditionAssert in enumerate(preconditions):
            executor.submit(try_init, states, (indexPreconditionAssert, preconditionAssert))

class Mode(Enum):
    epa = "epa"
    states = "states"

def make_global_variables(config):
    global fileName, preconditions, dot, statesNames, functions, statePreconditions, contractName, functionVariables
    global functionPreconditions, txBound, time_out, statePreconditionsModeState, statesModeState, SAVE_GRAPH_PATH, NO_UNKNOWN_TX
    fileName = os.path.join("Contracts", config.fileName)
    print(config.fileName)
    functions = config.functions
    statePreconditions = config.statePreconditions
    statesNames = config.statesNamesModeState
    contractName = config.contractName
    functionVariables = config.functionVariables
    functionPreconditions = config.functionPreconditions
    if txBound == None:
        txBound = config.txBound
    else:
        print("txBound en config ignorado. Usando parámetro txBound="+ str(txBound))
    if time_out == None:
        try:
            time_out = float(config.time_out)
        except Exception:
            time_out = 600.0
    else:
        print("time_out en config ignorado. Usando parámetro time_out="+ str(time_out))
    statePreconditionsModeState = config.statePreconditionsModeState
    statesModeState = config.statesModeState
    SAVE_GRAPH_PATH = "graph/k_"+str(txBound)+"/to_"+str(int(time_out))+"/"
    NO_UNKNOWN_TX = "_no_unknown_tx"

def main():
    global config, dot, preconditionsThreads, statesThreads, states, preconditions, extraConditionsThreads, extraConditions, SAVE_GRAPH_PATH, QUERY_TYPE
    make_global_variables(config)

    count = len(functions)
    #lista de numeros de 1 a N, donde N es la cantidad de funciones
    funcionesNumeros = list(range(1, count + 1))

    #TODO hilos para correr en paralelo. Pasar esto a un parámetro
    thread_workers = 1
    
    
    threads = []

    dot = graphviz.Digraph(comment=config.fileName)

    extraConditions = []
    countPreInitial = 0
    countPreFinal = 0

    if mode == Mode.epa :
        #states tiene todos los posibles estados de acuerdo a las funciones habilitadas/no habilitadas
        states = getCombinations(funcionesNumeros)
        #preconditions tiene las precondiciones de cada estado, donde el indice i de preconditions es el estado i de states
        preconditions = getPreconditions(funcionesNumeros)
        try:
            extraConditions = [config.epaExtraConditions for i in range(len(states))]
        except:
            extraConditions = ["true" for i in range(len(states))]
    else :
        preconditions = statePreconditionsModeState
        states = statesModeState
        try:
            extraConditions = config.statesExtraConditions
        except:
           extraConditions = ["true" for i in range(len(states))]
    
    tempDir = create_directory_base("temp")

    countPreInitial = len(preconditions)

    # Quiero que haya 1 metodo tipo query por archivo
    # si hay muchas queries en un archivo, por más que se use ignoreMethod, puede llegar a tardar mucho
    # para no cambiar tanto la implementación, vamos a tener un archivo por cada query
    cant_preconditions = len(preconditions)
    preconditionsThreads = preconditions
    preconditionsThreads = np.array_split(preconditionsThreads, cant_preconditions)
    statesThreads = states
    statesThreads = np.array_split(statesThreads, cant_preconditions)
    extraConditionsThreads = extraConditions
    if len(extraConditionsThreads) != 0:
        extraConditionsThreads = np.array_split(extraConditions, cant_preconditions)

    if basic_mode == False:
        print("Length")
        print(len(preconditions))

    
    if mode == Mode.epa and not(reduced):
        print("Reducing combinations...")
        # Otra alternativa
        QUERY_TYPE = "QUERY_REDUCE_COMBINATION"
        with concurrent.futures.ThreadPoolExecutor(max_workers=thread_workers) as executor:
            for i in range(cant_preconditions):
                executor.submit(reduceCombinations, i)
        
        # for i in range(threadCount):
        #     thread = Thread(target = reduceCombinations, args = [i])
        #     thread.start()
        #     threads.append(thread)

        # for thread in threads:
        #     thread.join()

    print("Reducing combinations Ended.")

    preconditionsThreads = [x for x in preconditionsThreads if len(x)]
    statesThreads = [x for x in statesThreads if len(x)]
    extraConditionsThreads = [x for x in extraConditionsThreads if len(x)]

    preconditionsThreads = np.concatenate(preconditionsThreads)
    statesThreads = np.concatenate(statesThreads)
    if len(extraConditionsThreads) != 0:
        extraConditionsThreads = np.concatenate(extraConditionsThreads)
    states = statesThreads
    preconditions = preconditionsThreads
    extraConditions = extraConditionsThreads
    realThreadCount = len(preconditionsThreads)

    countPreFinal = len(preconditions)
    temp_dir = os.path.join(tempDir, configFile + "-" + str(mode) + ".txt")
    f = open(temp_dir, "w")
    f.write(str(countPreInitial) + "\n" + str(countPreFinal) + "\n" + str(len(functions)))
    f.close()

    threads = []
    divideThreads = 1
    moduleThreadsConut = 0
    divideCount = realThreadCount
    if basic_mode == False:
        print("Length")
        print(len(preconditionsThreads))
    # if len(preconditionsThreads) > 30:
    #     if basic_mode == False:
    #         print("MAYOR A 200")
    #     divideCount = len(preconditionsThreads)
    #     divideThreads = int(divideCount/threadCount)
    #     moduleThreadsConut = divideCount % threadCount

    # preconditionsThreads = np.array_split(preconditionsThreads, divideCount)
    # statesThreads = np.array_split(statesThreads, divideCount)
    # extraConditionsThreads = np.array_split(extraConditionsThreads, divideCount)
    cant_valid_states = len(preconditionsThreads)
    preconditionsThreads = np.array_split(preconditionsThreads, cant_valid_states)
    statesThreads = np.array_split(statesThreads, cant_valid_states)
    extraConditionsThreads = np.array_split(extraConditionsThreads, cant_valid_states)

    # for y in range(divideThreads):
    #     threads = []
    #     for i in range(realThreadCount):
    #         thread = Thread(target = validCombinations, args = [i + y * threadCount])
    #         thread.start()
    #         threads.append(thread)

    #     for thread in threads:
    #         thread.join()
            
    QUERY_TYPE =  "QUERY_NORMAL"
    # Otra alternativa
    with concurrent.futures.ThreadPoolExecutor(max_workers=thread_workers) as executor:
        for i in range(cant_valid_states):
            executor.submit(validCombinations, i)

    threads = []
    
    # for index in range(moduleThreadsConut):
    #     thread = Thread(target = validCombinations, args = [threadCount * divideThreads + index])
    #     thread.start()
    #     threads.append(thread)
    
    # with concurrent.futures.ThreadPoolExecutor(max_workers=thread_workers) as executor:
    #     for index in range(moduleThreadsConut):
    #         executor.submit(validCombinations, threadCount * divideThreads + index)
                
    # thread = Thread(target = validInit, args = [len(preconditionsThreads)])
    # thread.start()
    # threads.append(thread)
    # for thread in threads:
    #     thread.join()
    QUERY_TYPE = "QUERY_NORMAL_CONSTRUCTOR"
    with concurrent.futures.ThreadPoolExecutor(max_workers=thread_workers) as executor:
        for indexPreconditionAssert, preconditionAssert in enumerate(preconditions):
            executor.submit(try_init, states, (indexPreconditionAssert, preconditionAssert))
    print("ENDED")
    
    # threads = []
    # threadCount = thread_workers # TODO fix temporal para mantener código anterior
    # divideThreads = 1
    # moduleThreadsConut = 0
    # divideCount = realThreadCount
    # if basic_mode == False:
    #     print("Length")
    #     print(len(preconditionsThreads))
    # if len(preconditionsThreads) > 30:
    #     if basic_mode == False:
    #         print("MAYOR A 200")
    #     divideCount = len(preconditionsThreads)
    #     divideThreads = int(divideCount/threadCount)
    #     moduleThreadsConut = divideCount % threadCount

    # preconditionsThreads = np.array_split(preconditionsThreads, divideCount)
    # statesThreads = np.array_split(statesThreads, divideCount)
    # extraConditionsThreads = np.array_split(extraConditionsThreads, divideCount)

    # for y in range(divideThreads):
    #     threads = []
    #     for i in range(realThreadCount):
    #         thread = Thread(target = validCombinations, args = [i + y * threadCount])
    #         thread.start()
    #         threads.append(thread)

    #     for thread in threads:
    #         thread.join()
            
    
    # Otra alternativa
    # with concurrent.futures.ThreadPoolExecutor(max_workers=threadCount) as executor:
    #     for y in range(divideThreads):
    #         for i in range(realThreadCount):
    #             executor.submit(validCombinations, i + y * threadCount)

    # threads = []
    
    # for index in range(moduleThreadsConut):
    #     thread = Thread(target = validCombinations, args = [threadCount * divideThreads + index])
    #     thread.start()
    #     threads.append(thread)
    
    # thread = Thread(target = validInit, args = [len(preconditionsThreads)])
    # thread.start()
    # threads.append(thread)
    # for thread in threads:
    #     thread.join()
    # print("ENDED")
    
    
    tempFileName = configFile.replace('Config','')
    tempFileName = tempFileName + "_" + str(mode)
    output_dot = SAVE_GRAPH_PATH + tempFileName
    dot.render(output_dot)
    output_with_no_unknown_tx = SAVE_GRAPH_PATH + tempFileName + NO_UNKNOWN_TX
    ret,removed_tx = remove_unknown_tx.remove_transitions(os.path.join(os.getcwd(), output_dot))
    ret = "// Total removed tx for timeouts : " + str(removed_tx) + "\n" + ret
    write_file = open(output_with_no_unknown_tx,'w')
    write_file.write(ret)
    write_file.close()
    

states = []
preconditions = []
tool_output = "Found a counterexample"
number_to = 0
number_corral_fail = 0
number_corral_fail_with_tackvars = 0
TRACK_VARS = "trackAllVars"

def add_query_time(query_time, time_out):
    global QUERY_TYPE, query_list

    query_list.append((QUERY_TYPE, time_out, query_time))
        
sys.path.append(os.path.join(os.getcwd(), "Configs"))

if __name__ == "__main__":
    global mode, config, verbose, time_mode, txBound, QUERY_TYPE, query_list
    txBound = None
    time_out = None
    init = time.time()
    epaMode = False
    statesMode = False
    
    configFile = sys.argv[1]
    verbose = False
    basic_mode = False
    
    query_list =[] # (type, query_time) va a guardar el tipo y tiempo de cada query a verisol
    
    
    #TODO: ser consistente
    reduced = False
    reducedTrue = True
    reducedEqual = False
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-v":
            verbose = True
        if sys.argv[i] == "-b":
            basic_mode = True
        if sys.argv[i] == "-e":
            epaMode = True
        if sys.argv[i] == "-s":
            statesMode = True
        if sys.argv[i] == "-a":
            statesMode = True
            epaMode = True
        if sys.argv[i] == "-default":
            reduced = False
            reducedTrue = True
            reducedEqual = False
        if sys.argv[i] == "-rs":
            reduced = True
        if sys.argv[i] == "-rt":
            reducedTrue = False
        if sys.argv[i] == "-re":
            reducedEqual = True
        if sys.argv[i] == "-rte":
            reducedEqual = True 
            reducedTrue = False       
        if sys.argv[i] == "-ra":
            reducedTrue = False
            reducedEqual = True
            reduced = True
        if "txbound=" in sys.argv[i]:
            txBound = int(sys.argv[i].replace("txbound=","").strip())
        if "time_out=" in sys.argv[i]:
            to = sys.argv[i].replace("time_out=","").strip()
            if to == "0":
                time_out = None
            else:
                time_out = float(to)
            
    
    if epaMode:
        mode = Mode.epa
        print(configFile)
        config = __import__(configFile)
        main()

    if statesMode:
        config = __import__(configFile, level=0)
        mode = Mode.states
        main()
    
    end = time.time()
    total_time = "Total time: {}".format(str(end-init))
    total_to = "# Time Out: {}".format(str(number_to))
    total_cfail1 = "# Corral Fail without trackvars: {}".format(str(number_corral_fail))
    total_cfail2 = "# Corral Fail with trackvars: {}".format(str(number_corral_fail_with_tackvars))
    
    print(total_time)
    print(total_to)
    print(total_cfail1)
    print(total_cfail2)
    tempFileName = configFile.replace('Config','')+"-"+str(mode)+".txt"
    with open(os.path.join(SAVE_GRAPH_PATH,tempFileName), 'w') as file:
        file.write("Subject: " + tempFileName.replace(".txt", "")+"\n")
        file.write(total_time+"\n")
        file.write(total_to+"\n")
        file.write(total_cfail1+"\n")
        file.write(total_cfail2+"\n")
        
    tempFileName = configFile.replace('Config','')+"-"+str(mode)+"_query_time.csv"
    with open(os.path.join(SAVE_GRAPH_PATH,tempFileName), 'w') as file:
        file.write("Type,TO?,time(sec)\n")
        for query in query_list:
            file.write(f"{query[0]},{str(query[1])},{str(query[2])}\n")

    