pragma solidity ^0.5.10;

contract RefrigeratedTransportation {
    //Set of States
    enum StateType { Created, InTransit, Completed, OutOfCompliance}
    enum SensorType { None, Humidity, Temperature }

    //List of properties
    StateType State;
    address Owner;
    address InitiatingCounterparty;
    address Counterparty;
    address PreviousCounterparty;
    address Device;
    address SupplyChainOwner;
    address SupplyChainObserver;
    int MinHumidity;
    int MaxHumidity;
    int MinTemperature;
    int MaxTemperature;
    SensorType ComplianceSensorType;
    int ComplianceSensorReading;
    bool ComplianceStatus;
    enum ComplianceDetailEnum {NA, HumidityOutOfRange, TemperatureOutOfRange}
    ComplianceDetailEnum ComplianceDetail;
    int LastSensorUpdateTimestamp;
    bool initialized = false;


    constructor() public {
    }

    function constructor_f(address device, address supplyChainOwner, address supplyChainObserver, int minHumidity, int maxHumidity, int minTemperature, int maxTemperature) public
    {
        require(!initialized);
        initialized = true;
        ComplianceStatus = true;
        ComplianceSensorReading = -1;
        InitiatingCounterparty = msg.sender;
        Owner = InitiatingCounterparty;
        Counterparty = InitiatingCounterparty;
        Device = device;
        SupplyChainOwner = supplyChainOwner;
        SupplyChainObserver = supplyChainObserver;
        MinHumidity = minHumidity;
        MaxHumidity = maxHumidity;
        MinTemperature = minTemperature;
        MaxTemperature = maxTemperature;
        State = StateType.Created;
        ComplianceDetail = ComplianceDetailEnum.NA;
    }

    function IngestTelemetry(int humidity, int temperature, int timestamp) public
    {
        require(initialized);
        // Separately check for states and sender 
        // to avoid not checking for state when the sender is the device
        // because of the logical OR
        if ( State == StateType.Completed )
        {
            revert();
        }

        if ( State == StateType.OutOfCompliance )
        {
            revert();
        }

        if (Device != msg.sender)
        {
            revert();
        }

        LastSensorUpdateTimestamp = timestamp;

        if (humidity > MaxHumidity || humidity < MinHumidity)
        {
            ComplianceSensorType = SensorType.Humidity;
            ComplianceSensorReading = humidity;
            ComplianceDetail = ComplianceDetailEnum.HumidityOutOfRange;
            ComplianceStatus = false;
        }
        else if (temperature > MaxTemperature || temperature < MinTemperature)
        {
            ComplianceSensorType = SensorType.Temperature;
            ComplianceSensorReading = temperature;
            ComplianceDetail = ComplianceDetailEnum.TemperatureOutOfRange;
            ComplianceStatus = false;
        }

        if (ComplianceStatus == false)
        {
            State = StateType.OutOfCompliance;
        }
    }

    function TransferResponsibility(address newCounterparty) public
    {
        require(initialized);
        // keep the state checking, message sender, and device checks separate
        // to not get cloberred by the order of evaluation for logical OR
        if ( State == StateType.Completed )
        {
            revert();
        }

        if ( State == StateType.OutOfCompliance )
        {
            revert();
        }

        if ( InitiatingCounterparty != msg.sender && Counterparty != msg.sender )
        {
            revert();
        }

        if ( newCounterparty == Device )
        {
            revert();
        }

        if (State == StateType.Created)
        {
            State = StateType.InTransit;
        }

        PreviousCounterparty = Counterparty;
        Counterparty = newCounterparty;

    }

    function Complete() public
    {
        require(initialized);
        // keep the state checking, message sender, and device checks separate
        // to not get cloberred by the order of evaluation for logical OR
        if ( State == StateType.Completed )
        {
            revert();
        }

        if ( State == StateType.OutOfCompliance )
        {
            revert();
        }

        if (Owner != msg.sender && SupplyChainOwner != msg.sender)
        {
            revert();
        }

        //Fix: Add precondition
        if ( State == StateType.Created )
        {
            revert();
        }

        State = StateType.Completed;
        PreviousCounterparty = Counterparty;
        Counterparty = address(0x0);
    }

    // function blue_query_constructor(address device, address supplyChainOwner, address supplyChainObserver, int minHumidity, int maxHumidity, int minTemperature, int maxTemperature) public {
    //     require(!initialized);

    //     constructor_f(device, supplyChainOwner, supplyChainObserver, minHumidity, maxHumidity, minTemperature, maxTemperature);

    //     bool pre_IngestTelemetry = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
    //     bool pre_TransferResponsibility = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
    //     bool pre_Complete = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance && State != StateType.Created);


    //     // pre_IngestTelemetry && transferResponsibility && !complete
    //     bool Q = pre_IngestTelemetry && pre_TransferResponsibility && !pre_Complete;
    //     assert(Q);
    // }

    function blue_query_s1_a_s4(int humidity, int temperature, int timestamp) public {
        bool pre_IngestTelemetry = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
        bool pre_TransferResponsibility = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
        bool pre_Complete = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance && State != StateType.Created);

        // pre_IngestTelemetry && transferResponsibility && !complete
        bool S1 = pre_IngestTelemetry && pre_TransferResponsibility && !pre_Complete;
        require(S1);


        IngestTelemetry(humidity, temperature, timestamp);

        bool pre_IngestTelemetry2 = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
        bool pre_TransferResponsibility2 = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance);
        bool pre_Complete2 = initialized && (State != StateType.Completed && State != StateType.OutOfCompliance && State != StateType.Created);


        // pre_IngestTelemetry && transferResponsibility && !complete
        S1 = pre_IngestTelemetry2 && pre_TransferResponsibility2 && !pre_Complete2;
        require(!S1);

        // !pre_IngestTelemetry && !transferResponsibility && !complete
        bool S4 = !pre_IngestTelemetry2 && !pre_TransferResponsibility2 && !pre_Complete2;
        assert(S4);

    }
}