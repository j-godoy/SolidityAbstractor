Work in progress...
# Solidity Abstractor
This tool generates an abstraction (finite state machine) known as EPA (Enabledness Preserving Abstraction). This is useful for validation.

How to run:

```
python3 SolidityAbstractor.py [contract_name] [mode] [info_level] [optim_params] [timeout] [bound]
```
where
- contract_name: name of the config file in /config folder. Example: HelloBlockchainConfig
- mode: "-e" for EPA and "-s" for states.
- info_level: "-v" for verbose and "-b" for basic info.
- optim_params: "-default" for default parameters.
- time_out: "time_out=n", n=seconds
- bound: "txbound=n", n=max transaction bound for Verisol

It requires that the corresponding Solidity contract is in the /contract folder and its config file in the /config folder.

### Requirements:
- VeriSol: You can download this from: https://github.com/microsoft/verisol/blob/master/INSTALL.md
- Add VeriSol to path (home/user/.dot/...)
- pip install graphviz
- pip install numpy
- pip install psutil
- run the SolidiAbstractor.py with some basic example. If it works fine, then:
    - remove VeriSol: dotnet remove verisol
    - install a fork version of Verisol running:
        - git clone https://github.com/j-godoy/verisol.git
        - cd verisol/
        -  dotnet build Sources\VeriSol.sln
        - dotnet tool install VeriSol --version 0.1.5-alpha --global --add-source path/to/repo/verisol/nupkg/
