import os
import time
import datetime 
import subprocess
import platform
from statistics import mean
from tabulate import tabulate

def runCommand(command):
    st = time.time()
    if platform.system() == "Windows":
        result = subprocess.run(command.split(" "), shell = True, stdout=subprocess.PIPE)
    else:
        result = subprocess.run([command, ""], shell = True, stdout=subprocess.PIPE)
    # print(result.stdout.decode('utf-8'))
    et = time.time()
    result = et - st
    print(result)
    return result

def run(mode, params, extra=""):
    global table, command, configName, REPETICIONES, TXBOUND_END, TIME_OUT
    commandEpa = command + " " + params + " txbound="+str(TXBOUND_END) + " time_out="+str(TIME_OUT)
    modeName = mode + ("-" + extra if extra != "" else "")
    print("Modo " + modeName)
    print("Command " + commandEpa)
    results = []

    i = 1
    while i <= REPETICIONES:
        results.append(runCommand(commandEpa))
        i += 1
    
    avg = mean(results)
    print("Promedio mode: " + str(avg))
    avgEpa = str(datetime.timedelta(seconds=int(avg)))
    print(str(datetime.timedelta(seconds=int(avg))))
    
    file = os.path.join("temp", configName + "-Mode."+ mode +".txt")
    f = open(file, "r")
    initEpa = f.readline()
    finiStates = f.readline()
    functions = f.readline()
    name = configName
    statesCount = 2**int(functions) if mode == "epa" else initEpa
    
    table.append([name+"_k="+str(TXBOUND_END), modeName, avgEpa, statesCount , initEpa, finiStates, functions]) 

def config_B1():
    configs = [
    ###Benchmark1-original
    ["AssetTransferConfig",["s"]],
    ["BasicProvenanceConfig",["s"]],
    ["DefectiveComponentCounterConfig",["s"]],
    ["DigitalLockerConfig",["s"]],    
    ["FrequentFlyerRewardsCalculatorConfig",["s"]],
    ["HelloBlockchainConfig",["s"]],
    ["RefrigeratedTransportationConfig",["s"]],
    ["RoomThermostatConfig",["s"]],
    ["SimpleMarketplaceConfig",["s"]],
    ###Benchmark1-fixed
    ["AssetTransferFixedConfig",["s"]],
    ["BasicProvenanceFixedConfig",["s"]],
    ["DefectiveComponentCounterFixedConfig",["s"]],
    ["DigitalLockerFixedConfig",["s"]],
    ["HelloBlockchainFixedConfig",["s"]],
    ["RefrigeratedTransportationFixedConfig",["s"]],
    ["SimpleMarketplaceFixedConfig",["s"]],
    ]
    return configs

def config_B2():
    configs = [
        # Benchmark2-original
        ["RefundEscrowConfig", ["s"]],
        ["RefundEscrowConfig", ["e"]],
        ["RefundEscrowWithdrawConfig", ["e"]],
        ["EscrowVaultConfig", ["s"]],
        ["EscrowVaultConfig", ["e"]],
        ["EPXCrowdsaleConfig", ["s"]],
        ["EPXCrowdsaleConfig", ["e"]],
        ["EPXCrowdsaleIsCrowdsaleClosedConfig", ["e"]],
        ["CrowdfundingTime_BaseConfig", ["e"]],
        ["CrowdfundingTime_BaseBalanceConfig", ["e"]],
        ["CrowdfundingTime_BaseBalanceFixConfig", ["e"]],
        ["ValidatorAuctionConfig", ["s"]],
        ["ValidatorAuctionConfig", ["e"]],
        ["ValidatorAuction_withdrawConfig", ["e"]],
        ["SimpleAuctionConfig", ["e"]],
        ["SimpleAuctionTimeConfig", ["e"]],
        ["SimpleAuctionEndedConfig", ["e"]],
        ["SimpleAuctionHBConfig", ["s"]],
        ["AuctionConfig", ["e"]],
        ["AuctionEndedConfig", ["e"]],
        ["AuctionWithdrawConfig", ["e"]],
        ["RockPaperScissorsConfig", ["s"]],
        ["RockPaperScissorsConfig", ["e"]],
        
        # ["Crowdfunding_BaseConfig", ["e"]],    
        
        # # Benchmark2-PA
        # ["Crowdfunding_BaseConfig_models", ["s", "e"]],    
        # ["CrowdfundingTime_BaseBalanceConfigFix_states", ["s"]],
        # ["CrowdfundingTimeClaimBakersRefinementConfig", ["e"]],
        # ["CrowdfundingTimeClaimRefinementConfig", ["e"]],
        # ["CrowdfundingTimeConfig", ["e"]],
        # ["CrowdfundingTimeDonateRefinementConfig", ["e"]],
        # ["CrowdfundingTimeReentrancyConfig", ["e"]],
        # ["CrowdfundingTimeReentrancyFixedConfig", ["e"]],
        # ["CrowdfundingTimeReentrancyFixedMutexConfig", ["e"]],
    ]
    return configs

def rename_configs(config):
    configs = []
    for c in config:
        mode = "e" if c.endswith("epa") else "s"
        configs.append([c.replace("_Mode.epa", "Config").replace("_Mode.states", "Config"), mode])
    return configs

table = [['Config', 'Mode' ,'Time', 'Inital pre count' , 'Pre count after true', 'Reduce Pr count', 'Functions count']]
cofigs = []
command = ""
configName = ""
REPETICIONES = 1
TXBOUND_INIT = 4
TXBOUND_END = 4 #Include
TIME_OUT = 300

def main(subjects_config, repeticiones=1, txbound_init=4, txbound_end=4, timeout=300):
    global table, command, configName, REPETICIONES, TXBOUND_END, TIME_OUT
    configs = rename_configs(subjects_config)
    REPETICIONES = repeticiones
    TXBOUND_INIT = txbound_init
    TXBOUND_END = txbound_end
    TIME_OUT = timeout
    init = time.time()

    all_names_ok = True
    for config in configs:
        configName = config[0]
        if not os.path.exists(os.path.join("Configs", configName+".py")):
            print("No existe el archivo: "+ configName)
            all_names_ok = False

    if not all_names_ok:
        exit(1)

    for config in configs:
        configName = config[0]
        modes = config[1]
        print("Corriendo " + configName)
        command = "python .\SolidityAbstractor.py " + configName + " -b"

        upper_bound = TXBOUND_END
        for curr_txBound in range(TXBOUND_INIT, upper_bound+1):
            TXBOUND_END = curr_txBound
            for mode in modes:
                if mode == "e":
                    run("epa", "-e")
                    # run("epa", "-e -rt", "noReduceTrue")
                    # run("epa", "-e -re", "noReduceEqual")
                    # run("epa", "-e -rte", "noReduceTrueEqual")
                    # run("epa", "-e -rs", "noReduceStates")
                    # run("epa", "-e -ra", "noReduceAll")
                if mode == "s":
                    run("states", "-s")
            
                # now = str(datetime.datetime.now()).replace(":","-")
                # with open('Tiempos-'+ now +'.txt', 'w') as outputfile:
                #     print(tabulate(table, headers='firstrow', tablefmt='simple'), file=outputfile)
                # if mode == "e":
                #     run("epa", "-e -rs", "noReduceStates")
            
                # now = str(datetime.datetime.now()).replace(":","-")
                # with open('Tiempos-'+ now +'.txt', 'w') as outputfile:
                #     print(tabulate(table, headers='firstrow', tablefmt='simple'), file=outputfile)

                # if mode == "e":
                #     run("epa", "-e -ra", "noReduceAll")
        
            
    now = str(datetime.datetime.now()).replace(":","-")
    with open('Tiempos-'+ now +'.txt', 'w') as outputfile:
        print(tabulate(table, headers='firstrow', tablefmt='simple'), file=outputfile)
                
    end = time.time()
    print("Tiempo total: " + str(end - init) + "segs")

# main(config_B2(), REPETICIONES, 4, 4, 300)