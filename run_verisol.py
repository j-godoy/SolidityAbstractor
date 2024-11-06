import os
import subprocess
import time
import psutil

#VeriSol D:\Documentos\Git\SolidityAbstractor\output3\OutputTemp3.sol Reentrance /txBound:8 /noPrf /ignoreMethod:vc0x0x0@Reentrance /ignoreMethod:vc0x0x1@Reentrance /ignoreMethod:vc0x0x4@Reentrance /ignoreMethod:vc0x1x0@Reentrance /ignoreMethod:vc0x1x1@Reentrance /ignoreMethod:vc0x1x4@Reentrance /ignoreMethod:vc0x2x0@Reentrance /ignoreMethod:vc0x2x1@Reentrance /ignoreMethod:vc0x2x4@Reentrance /ignoreMethod:vc0x3x0@Reentrance /ignoreMethod:vc0x3x1@Reentrance /ignoreMethod:vc0x3x4@Reentrance /ignoreMethod:vc0x4x0@Reentrance /ignoreMethod:vc0x4x1@Reentrance /ignoreMethod:vc0x4x4@Reentrance /ignoreMethod:vc0x5x1@Reentrance /ignoreMethod:vc0x5x4@Reentrance /ignoreMethod:vc0x6x0@Reentrance /ignoreMethod:vc0x6x1@Reentrance /ignoreMethod:vc0x6x4@Reentrance /ignoreMethod:vc0x7x0@Reentrance /ignoreMethod:vc0x7x1@Reentrance /ignoreMethod:vc0x7x4@Reentrance /ignoreMethod:vc0x8x0@Reentrance /ignoreMethod:vc0x8x1@Reentrance /ignoreMethod:vc0x8x4@Reentrance /ignoreMethod:vc0x9x0@Reentrance /ignoreMethod:vc0x9x1@Reentrance /ignoreMethod:vc0x9x4@Reentrance ' desde folder 'D:\Documentos\Git\SolidityAbstractor\output3
# contract_path = os.path.join("ReentranceReentrancy.sol")
# contract_name = "Reentrance"
# final_directory = os.path.join("Contracts")
contract_path = os.path.join("OutputTemp3.sol")
contract_name = "Reentrance"
final_directory = os.path.join("output3")
bound = 8
time_out = 1200
verisol_ignore_methods = "/ignoreMethod:vc0x0x0@Reentrance /ignoreMethod:vc0x0x1@Reentrance /ignoreMethod:vc0x0x4@Reentrance /ignoreMethod:vc0x1x0@Reentrance /ignoreMethod:vc0x1x1@Reentrance /ignoreMethod:vc0x1x4@Reentrance /ignoreMethod:vc0x2x0@Reentrance /ignoreMethod:vc0x2x1@Reentrance /ignoreMethod:vc0x2x4@Reentrance /ignoreMethod:vc0x3x0@Reentrance /ignoreMethod:vc0x3x1@Reentrance /ignoreMethod:vc0x3x4@Reentrance /ignoreMethod:vc0x4x0@Reentrance /ignoreMethod:vc0x4x1@Reentrance /ignoreMethod:vc0x4x4@Reentrance /ignoreMethod:vc0x5x1@Reentrance /ignoreMethod:vc0x5x4@Reentrance /ignoreMethod:vc0x6x0@Reentrance /ignoreMethod:vc0x6x1@Reentrance /ignoreMethod:vc0x6x4@Reentrance /ignoreMethod:vc0x7x0@Reentrance /ignoreMethod:vc0x7x1@Reentrance /ignoreMethod:vc0x7x4@Reentrance /ignoreMethod:vc0x8x0@Reentrance /ignoreMethod:vc0x8x1@Reentrance /ignoreMethod:vc0x8x4@Reentrance /ignoreMethod:vc0x9x0@Reentrance /ignoreMethod:vc0x9x1@Reentrance /ignoreMethod:vc0x9x4@Reentrance"
command = f"VeriSol {contract_path} {contract_name} /txBound:{bound} /noPrf {verisol_ignore_methods}"

init = time.time()
try:
    print("now: ", time.strftime("%H:%M:%S", time.localtime()))
    print("Running command: '", command, "'\n in directory: ", final_directory)
    proc = subprocess.Popen(command.split(" "), stdout=subprocess.PIPE, cwd=final_directory)
    result = proc.communicate(timeout=time_out)
    output_verisol = str(result[0].decode('utf-8'))
    print(output_verisol)

except Exception as e:
    print("Error: ", e)
    # process = psutil.Process(proc.pid)
    # for proc in process.children(recursive=True):
    #     proc.kill()
    # process.kill()
    # process.wait(2) # wait for killing subprocess
    
end = time.time()

elapsed_time = end - init
minutes, seconds = divmod(elapsed_time, 60)
print(f"Time: {int(minutes)} minutes and {seconds:.2f} seconds")