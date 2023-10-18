import os
import networkx as nx
import pydot
import Benchmark_info

def load_dot_file(file_path):
    graph = pydot.graph_from_dot_file(file_path)[0]
    nx_graph = nx.DiGraph()

    for edge in graph.get_edge_list():
        source = edge.get_source()
        target = edge.get_destination()
        nx_graph.add_edge(source, target)

    return nx_graph

def are_dot_files_equivalent(file1, file2):
    try:
        g1 = load_dot_file(file1)
        g2 = load_dot_file(file2)
    except Exception as e:
        print(e)
        return False
    
    return nx.is_isomorphic(g1, g2)

def encontrar_nodos_no_equivalentes(grafo1, grafo2):
    nodos_no_equivalentes = []
    
    for nodo1 in grafo1.nodes:
        equivalente = False
        for nodo2 in grafo2.nodes:
            if nx.is_isomorphic(grafo1.subgraph([nodo1]), grafo2.subgraph([nodo2])):
                equivalente = True
                break
        if not equivalente:
            nodos_no_equivalentes.append(nodo1)
    
    return nodos_no_equivalentes


def differences(dot1, dot2):
    G1 = load_dot_file(dot1)
    G2 = load_dot_file(dot2)

    # nodos1 = set(G1.nodes)
    # nodos2 = set(G2.nodes)

        # Obtiene los nodos de cada grafo
    nodes1 = set(node for node in G1.nodes())
    nodes2 = set(node for node in G2.nodes())

    # Encuentra los nodos diferentes entre los dos grafos
    # diferencias1 = nodes1 - nodes2
    # diferencias2 = nodes2 - nodes1

    # print("Nodos diferentes en el primer grafo:", diferencias1)
    # print("Nodos diferentes en el segundo grafo:", diferencias2)
    nodos_diferentes = set(G1.nodes) ^ set(G2.nodes)



    # nodos_no_equivalentes = encontrar_nodos_no_equivalentes(G1, G2)
    # diferencias = nx.difference(G1, G2)
    # nodos_diferentes = nodos1.symmetric_difference(nodos2)
    # print("Nodos diferentes entre los dos grafos:")
    for nodo in nodos_diferentes:
        print(nodo)


    # Obtener los nodos que son diferentes
    # nodos_diferentes = list(diferencias.nodes)



    # Crear un mapeo de nodos entre los dos grafos
    # mapeo_nodos = {}
    # for nodo1 in G1.nodes:
    #     for nodo2 in G2.nodes:
    #         if G1.nodes[nodo1] == G2.nodes[nodo2]:
    #             mapeo_nodos[nodo1] = nodo2
                
    # diferencias = nx.difference(G1, G2)
    # nodos_diferentes = [mapeo_nodos[nodo] for nodo in diferencias.nodes]

    # print()
    # print(nodos_no_equivalentes)
    # if nodos_no_equivalentes:
    #     print("Nodos no equivalentes:")
    #     for nodo in nodos_no_equivalentes:
    #         print(nodo)
    # print()
    # print()


def diff(file1Name, file2Name):
    if not are_dot_files_equivalent(file1Name, file2Name):
        print(file1Name + " is different from " + file2Name)
        return True
        # differences(file1Name, file2Name)
    return False
# entries = os.listdir('graph/k_10/to_600/')
# for i in range(9,10):
#     for entry in entries:
#         if not entry.endswith("pdf") and not entry.endswith("txt"):
#             diff("graph/k_10/to_600/" + entry, "graph/k_{}/to_600/".format(i) + entry)

def get_alloy_subjects(subjects, benchmark):
    solidityabstractor_subjects_b1 = ["AssetTransferFixed", "AssetTransfer", "BasicProvenanceFixed", "BasicProvenance", "DefectiveComponentCounterFixed", "DefectiveComponentCounter", "DigitalLockerFixed", "DigitalLocker", "FrequentFlyerRewardsCalculator", "HelloBlockchainFixed", "HelloBlockchain", "RefrigeratedTransportationFixed", "RefrigeratedTransportation", "RoomThermostat", "SimpleMarketplaceFixed", "SimpleMarketplace"]
    alloy_subjects_b1 = ["AssetTransfer_fixed", "AssetTransfer_original", "BasicProvenance_fixed", "BasicProvenance_original", "DefectiveComponentCounter_fixed", "DefectiveComponentCounter_original", "DigitalLocker_fixed", "DigitalLocker_original", "FrequentFlyerRewardsCalculator_original", "HelloBlockchain_fixed", "HelloBlockchain_original", "RefrigeratedTransportation_fixed", "RefrigeratedTransportation_original", "RoomThermostat_original", "SimpleMarketplace_fixed", "SimpleMarketplace_original"]
    
    solidityabstractor_subjects_b2 = ["RefundEscrow_Mode.states", "RefundEscrow_Mode.epa", "RefundEscrowWithdraw_Mode.epa", "EscrowVault_Mode.states", "EscrowVault_Mode.epa", "EPXCrowdsale_Mode.states", "EPXCrowdsale_Mode.epa", "EPXCrowdsaleIsCrowdsaleClosed_Mode.epa", "CrowdfundingTime_Base_Mode.epa", "CrowdfundingTime_BaseBalance_Mode.epa", "CrowdfundingTime_BaseBalanceFix_Mode.epa", "ValidatorAuction_Mode.states", "ValidatorAuction_Mode.epa", "ValidatorAuction_withdraw_Mode.epa", "SimpleAuction_Mode.epa", "SimpleAuctionTime_Mode.epa", "SimpleAuctionEnded_Mode.epa", "SimpleAuctionHB_Mode.states", "Auction_Mode.epa", "AuctionEnded_Mode.epa", "AuctionWithdraw_Mode.epa", "RockPaperScissors_Mode.states", "RockPaperScissors_Mode.epa"]
    alloy_subjects_b2 =              ["RefundEscrow", "RefundEscrow_EPA", "RefundEscrow_withdrawA", "EscrowVault", "EscrowVault_EPA", "EPXCrowdsale", "EPXCrowdsale_EPA", "EPXCrowdsale_EPA_isCrowdSaleClosed", "CrowdfundingTime_Base", "CrowdfundingTime_BaseBalance", "CrowdfundingTime_BaseBalanceFix", "ValidatorAuction", "ValidatorAuction_EPA", "ValidatorAuction_WithdrawA+NotA", "SimpleAuction_EPA", "SimpleAuction_EPA_time", "SimpleAuction+Ended", "SimpleAuction+Ended+highestBidder", "Auction_EPA", "Auction_EPA+predicateEnded", "Auction_EPA_withdrawA", "RockPaperScissors+predicateOneWinner", "RockPaperScissors_EPA"]
    
    to_find_verisol = []
    to_find_alloy = []
    if benchmark == "B1":
        to_find_verisol = solidityabstractor_subjects_b1
        to_find_alloy = alloy_subjects_b1
    elif benchmark == "B2":
        to_find_verisol = solidityabstractor_subjects_b2
        to_find_alloy = alloy_subjects_b2
    else:
        print("solo benchmark B1 o B2!")
        exit(1)
    ret = []
    for i in range(len(subjects)):
        for j in range(len(to_find_verisol)):
            if subjects[i] == to_find_verisol[j]:
                ret.append(to_find_alloy[j])
    return ret
    
def get_diff(solidityabstractor_subjects, benchmark, k, timeout):
    path_solidityabstractor = f"C:\\Users\\JavierGodoy\\Repos\\SolidityAbstractor\\graph\\k_{k}\\to_{timeout}"
    path_alloy = f"C:\\Users\\JavierGodoy\\Repos\\sosym23\\models_alloy\\{benchmark}\\"
    cant_dif = 0
    subjects_diff = []

    alloy_subjects = get_alloy_subjects(solidityabstractor_subjects, benchmark)
    if len(alloy_subjects) != len(solidityabstractor_subjects):
        print("Diferente cantidad de subjects alloy y solidityabstractor")
        exit(1)
    for i in range(len(alloy_subjects)):
        if solidityabstractor_subjects[i].endswith("_Mode.states") or solidityabstractor_subjects[i].endswith("_Mode.epa"):
            solidityabstractor_dot = os.path.join(path_solidityabstractor, solidityabstractor_subjects[i])
        else:
            print(f"agregar modo states o epa al subject '{solidityabstractor_subjects[i]}'")
            # file_dot = os.path.join(path_solidityabstractor,solidityabstractor_subjects[i]+"_Mode.states")
            # solidityabstractor_dot = file_dot if os.path.exists(file_dot) else file_dot.replace("_Mode.states","_Mode.epa")
            
        alloy_dot = os.path.join(path_alloy,alloy_subjects[i],alloy_subjects[i]+"_reachable.dot")
        if not os.path.exists(alloy_dot) or not os.path.exists(solidityabstractor_dot):
            if not os.path.exists(alloy_dot):
                print(f"NO EXISTE ARCHIVO ALLOY {alloy_dot}")
            if not os.path.exists(solidityabstractor_dot):
                print(f"NO EXISTE ARCHIVO VERISOL {solidityabstractor_dot}")
        else:
            ret = diff(solidityabstractor_dot, alloy_dot)
            if ret:
                subjects_diff.append(solidityabstractor_subjects[i])
                cant_dif += 1
    print("total diff: "+ str(cant_dif))
    print("diffs: ")
    print(subjects_diff)
    return subjects_diff

subjects = ["RefundEscrow_Mode.states", "RefundEscrow_Mode.epa", "RefundEscrowWithdraw_Mode.epa", "EscrowVault_Mode.states", "EscrowVault_Mode.epa", "EPXCrowdsale_Mode.states", "EPXCrowdsale_Mode.epa", "EPXCrowdsaleIsCrowdsaleClosed_Mode.epa", "CrowdfundingTime_Base_Mode.epa", "CrowdfundingTime_BaseBalance_Mode.epa", "CrowdfundingTime_BaseBalanceFix_Mode.epa", "ValidatorAuction_Mode.states", "ValidatorAuction_Mode.epa", "ValidatorAuction_withdraw_Mode.epa", "SimpleAuction_Mode.epa", "SimpleAuctionTime_Mode.epa", "SimpleAuctionEnded_Mode.epa", "SimpleAuctionHB_Mode.states", "Auction_Mode.epa", "AuctionEnded_Mode.epa", "AuctionWithdraw_Mode.epa", "RockPaperScissors_Mode.states", "RockPaperScissors_Mode.epa"]
Benchmark = "B2"
total_diff_antes = len(subjects)
total_diff_despues = len(subjects)
k_parameter = 4
time_out = 600
first = True
cant_iguales_consecutivas = 0
while (len(subjects)>0 and total_diff_despues <= total_diff_antes and cant_iguales_consecutivas<2) or first:
    if not first:
        k_parameter *= 2
        if total_diff_antes == total_diff_despues:
            cant_iguales_consecutivas += 1
        else:
            cant_iguales_consecutivas = 0
    total_diff_antes = total_diff_despues
    total_subjects = len(subjects)
    Benchmark_info.main(subjects, 1, k_parameter, k_parameter, time_out)
    first = False
    subjects = get_diff(subjects, Benchmark, k_parameter, time_out)
    total_diff_despues = len(subjects)
    tempFileName = "diff_result_"+Benchmark+".txt"
    with open(os.path.join(tempFileName), 'a+') as file:
        if first:
            file.write(f"Benchmark: {Benchmark}\n")
            file.write(f"time out: {time_out}\n")
        file.write(f"k: {k_parameter}\n")
        file.write(f"total diff: {total_diff_despues} de un total de {total_subjects}\n")
        file.write("subjects diferentes:\n")
        file.write(str(subjects)+"\n\n")
        file.close()