import os
import re
from os.path import expanduser

fun_crowdfunding = [("Donate","D", "donate"), ("GetFunds","F", "getFunds"), ("Claim_Init","Ci", "Claim_Init"), ("Claim_End","Ce", "Claim_End"), ("t", "τ", "τ"), ("dummy_balanceGTZero", "B", "")]
FUNCTIONS = fun_crowdfunding

def replace_label(input):
    global FUNCTIONS
    pattern = r'label="(.*?)"'
    #functions = ["Donate", "GetFunds", "Claim", "Claim_A", "Claim_B", "Claim_Init", "Claim_End", "dummy_balanceGTZero", "dummy_balanceIsZero", "dummy_balanceAGTZeroAndNotB", "dummy_balanceAGTZeroAndBGTZero", "dummy_balanceBGTZeroAndNotA", "dummy_balanceAAndBZero", "\"t()", ";t()"]
    #functions = [("Donate","D"), ("GetFunds","F"), ("Claim","C"), ("dummy_balanceGTZero", "B"),("t", "τ")]
    to_append = []
    for f in FUNCTIONS:
        # Puede ser algo como label="t();" o [label="Donate();t();"
        if f[0] == "t":
            to_append.append(f[1] if "\"t()" in input or ";t();" in input else "!"+f[1])
        elif f[0] in input:
            to_append.append(f[1])
        else:
            to_append.append("!"+f[1])

    # D = "D" if "Donate" in input else "!D"
    # DA = "DA" if "Donate_A" in input else "!DA"
    # DB = "DB" if "Donate_B" in input else "!DB"
    # F = "F" if "GetFunds" in input else "!F"
    # C = "C" if "Claim" in input else "!C"
    # CA = "CA" if "Claim_A" in input else "!CA"
    # CB = "CB" if "Claim_B" in input else "!CB"
    
    # CI = "Ci" if "Claim_Init" in input else "!Ci"
    # CE = "Ce" if "Claim_End" in input else "!Ce"
    
    # # Puede ser algo como label="t();" o [label="Donate();t();"
    # T = "τ" if "\"t()" in input or ";t();" in input else "!τ"
    # BGTZ = "B" if "dummy_balanceGTZero()" in input else "!B"
    # BAG =  "B[A]>0\n& B[B]=0" if "dummy_balanceAGTZeroAndNotB()" in input else ""
    # BABG = "B[A]>0\n& B[B]>0" if "dummy_balanceAGTZeroAndBGTZero()" in input else ""
    # BBG =  "B[A]=0\n& B[B]>0" if "dummy_balanceBGTZeroAndNotA()" in input else ""
    # BAZ0 = "B[A]=0\n& B[B]=0" if "dummy_balanceAAndBZero()" in input else ""
    
    #classic
    #replaced_string = re.sub(pattern, r'label="{} & {}\\n& {}"'.format(D, F, C), input)
    
    #classic + tau
    #replaced_string = re.sub(pattern, r'label="{} & {}\\n& {} & {}"'.format(D, F, C, T), input)
    
    #classic + tau + balace
    # replaced_string = re.sub(pattern, r'label="{} & {} & {}\\n& {} & {}"'.format(D, F, C, T, BGTZ), input)
    
    #Method refinement
    #Donate
    # replaced_string = re.sub(pattern, r'label="{} & {}\\n & {} & {}\\n& {}"'.format(DA, DB, F, C, T, BGTZ), input)
    
    #claim
    # replaced_string = re.sub(pattern, r'label="{} & {} &\\n{} & {}\\n& {}"'.format(D, F, CA, CB, T), input)
    
    #claim + balance
    # replaced_string = re.sub(pattern, r'label="{} & {} &\\n{} & {} &\\n{} & {}{}{}{}{}{}"'.format(D, F, CA, CB, T, BGTZ, BAG, BABG, BBG, BAZ0), input)
    
    #Reentrancy
    # replaced_string = re.sub(pattern, r'label="{} & {} &\\n{} & {} &\\n {} & {}"'.format(D, F, CI, CE, T, BGTZ), input)
    
    label="label=\""
    for i in range(len(to_append)):
        label += f"{to_append[i]}"
        if i+1 < len(to_append):
            if i % 2 == 1:
                label += " &\\\\n"
            else:
                label += " & "
    label+="\""
    replaced_string = re.sub(pattern, label, input)
    # replaced_string = re.sub(pattern, r'label="{} & {} &\\n{} & {} &\\n {} & {}"'.format(D, F, CI, CE, T, BGTZ), input)
    
    return replaced_string

def compactar_trx_mismo_estado(ret_transiciones):
    global FUNCTIONS
    def f_name(s):
        ret = s.strip().replace("label=", "").replace("]", "")
        for f in FUNCTIONS:
            if f[0] != "t":
                ret = ret.replace(f[0]+"();", f[2])
        ret = ret.replace("\"t();", "τ")
        ret = ret.replace(";t();", "τ")
        # ret = ret.replace("Donate();", "donate")
        # ret = ret.replace("Claim();", "claim")
        # ret = ret.replace("GetFunds();", "getFunds")
        # ret = ret.replace("dummy_balanceGTZero();", "")
        # ret = ret.replace("dummy_balanceIsZero();", "")
        # ret = ret.replace("dummy_balanceAGTZeroAndNotB();", "")
        # ret = ret.replace("dummy_balanceAGTZeroAndBGTZero();", "")
        # ret = ret.replace("dummy_balanceBGTZeroAndNotA();", "")
        # ret = ret.replace("dummy_balanceAAndBZero();", "")
        ret = ret.replace("();", "")
        return ret

    def new_f_name(names):
        ret = "[label=\""
        names = list(filter(lambda x: x != "\"\"", names))
        for i in range(len(names)):
            if i != 0:
                if names != "":
                    ret += "\\n"
            ret += names[i].replace("\"","")
        ret += "\"]"
        return ret

    new_txs = {}
    for txs in ret_transiciones:
        txs = txs.strip().replace(" ", "")
        tx = txs.split("[")  # S09->S09 [label=t]
        if tx[0] in new_txs:
            new_txs[tx[0]].append(f_name(tx[1]))
        else:
            new_txs[tx[0]] = [f_name(tx[1])]

    ret_transiciones.clear()
    for tx in new_txs.keys():
        if new_txs[tx] != "\"\"":
            ret_transiciones.append("{} {}".format(tx, new_f_name(new_txs[tx])))

if __name__ == "__main__":
    repo_path = os.path.join(expanduser("~"), "Repos","sosym23", "graphs")
    file_path = os.path.join(repo_path, "crowdfunding_base_time_reentrancy_fixed_mutex", "CrowdfundingTimeReentrancyFixedMutex_Mode_original.epa")
    file = open(file_path, "r", encoding="utf-8")
    lines = file.readlines()
    output = []
    line_tmp = ""
    primeras_lineas = []
    for line in lines:
        line = line.strip()
        if "Prueba" in line or "{" in line or "}" in line:
            if line_tmp != "":
                primeras_lineas.append(line_tmp)
                line_tmp = ""
            continue
        line_tmp += line
        if line[-1] != "]":
            continue
        else:
            if "->" in line_tmp:
                output.append(line_tmp)
            else:
                if not line_tmp in primeras_lineas:
                    primeras_lineas.append(line_tmp)
            line_tmp = ""
    
    # cambio el formato de los estados
    for index_linea in range(len(primeras_lineas)):
        if not "[" in primeras_lineas[index_linea]:
            continue
        estilo_circulo = ", shape=circle]"
        primeras_lineas[index_linea] = primeras_lineas[index_linea][0:-1] + estilo_circulo
        primeras_lineas[index_linea] = replace_label(primeras_lineas[index_linea])
        primeras_lineas[index_linea] = primeras_lineas[index_linea].replace("t();", "τ")
        # primeras_lineas[i] = primeras_lineas[i].replace("Claim();", "C")
        # primeras_lineas[i] = primeras_lineas[i].replace("GetFunds();", "F")
        
        
    
    compactar_trx_mismo_estado(output)
    
    output.extend(primeras_lineas)
    output.insert(0, "digraph {")
    output.append("}")
    
    ELIMINAR_NO_CONFIRMADOS = False
    
    estados_iniciales = []
    for index_linea in output:
        if "?" in index_linea:
            if ELIMINAR_NO_CONFIRMADOS:
                continue
            index_linea = index_linea.replace("]", ", color=red]")
        if "init" in index_linea:
            if "->" in index_linea:
                estados_iniciales.append(index_linea.split(" ")[0].split("->")[1])
            index_linea = "// "+index_linea
            # continue
        for s in estados_iniciales:
            if not "->"in index_linea and s in index_linea.split(" ")[0]:
                index_linea = index_linea.replace("circle","doublecircle")
                break
        if "!τ" in index_linea and "shape" in index_linea:
            index_linea = index_linea.replace("circle","square")
        print(index_linea)