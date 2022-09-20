pragma solidity >=0.4.25 <0.9.0;
pragma experimental ABIEncoderV2;
//import "hardhat/console.sol";

contract SimpleMarketplace{
    enum StateType { 
      ItemAvailable,
      OfferPlaced,
      Accepted
    }

    address public InstanceOwner;
    string public Description;
    int public AskingPrice;
    StateType public StateEnum;
    int256[][] result;

    address public InstanceBuyer;
    int public OfferPrice;

    constructor(string memory description, int price, address sender) public
    {
        InstanceOwner = sender;
        AskingPrice = price;
        Description = description;
        StateEnum = StateType.ItemAvailable;
    }

    function MakeOffer(int offerPrice) public
    {
        if (offerPrice == 0)
        {
            revert();
        }

        if (StateEnum != StateType.ItemAvailable)
        {
            revert();
        }
        
        if (InstanceOwner == msg.sender)
        {
            revert();
        }

        InstanceBuyer = msg.sender;
        OfferPrice = offerPrice;
        StateEnum = StateType.OfferPlaced;
    }

    function Reject() public
    {
        if ( StateEnum != StateType.OfferPlaced )
        {
            revert();
        }

        if (InstanceOwner != msg.sender)
        {
            revert();
        }

       //InstanceBuyer = 0x0;
        StateEnum = StateType.ItemAvailable;
    }

    function AcceptOffer() public
    {
        if ( StateEnum != StateType.OfferPlaced )
        {
            revert();
        }

        if ( msg.sender != InstanceOwner )
        {
            revert();
        }

        StateEnum = StateType.Accepted;
    }

    // // Estados: {makeOffer}, {acceptOffer}, {rejectOffer}, {acceptOffer, rejectOffer}, {makeOffer, acceptOffer}, {makeOffer, rejectOffer}

    // // {makeOffer}: state == 0 && state != 1
    // // {acceptOffer}: state == 1 && state != 1 &&  state != 0
    // // {rejectOffer}: state == 1 && state != 1  && state != 0
    // // {acceptOffer, rejectOffer}: state == 1 && state != 0
    // // {makeOffer, acceptOffer}: state == 0 && state == 1 && state != 1
    // // {makeOffer, rejectOffer}: state == 0 && state == 1 && state != 1
    // // {makeOffer, acceptOffer, rejectOffer}: state == 0 && state == 1
    // // {}: state != 0 && state != 1

    // //Pres:
    // // MakeOffer: offerPrice !=0, state = 0, Instance Owner != msg.sender
    // // AcceptOffer: Instance Owner == msg.sender, state = 1
    // // Reject offer: state = 1, Instance Owner == msg.sender
    // function SimpleMarket(int offerPrice) external payable {
        
    //     int256[] memory states = new int256[](3);
    //     states[0] = 1;
    //     states[1] = 2;
    //     states[2] = 3;

    //     int256[] memory states2 = new int256[](3);
    //     states2[0] = 1;
    //     states2[1] = 2;
    //     states2[2] = 3;

    //     uint countComnbinations = 2 ** 3;

    //     result = new int256[][](countComnbinations);

    //     //combinations(states, states2, uint(0));
    //     //console.log("Termine");
    //     //result = [[1,0,0], [1,2,0], [0,2,0], [1,0,3], [1,2,3], [0,2,3], [0,0,3], [0,0,0]];
    //     int256[] memory state0 = new int256[](3);
    //     state0[0] = 0;
    //     state0[1] = 0;
    //     state0[2] = 0;

    //     int256[] memory state1 = new int256[](3);
    //     state1[0] = 1;
    //     state1[1] = 0;
    //     state1[2] = 0;

    //     int256[] memory state2 = new int256[](3);
    //     state2[0] = 1;
    //     state2[1] = 2;
    //     state2[2] = 0;

    //     int256[] memory state3 = new int256[](3);
    //     state3[0] = 0;
    //     state3[1] = 2;
    //     state3[2] = 0;

    //     int256[] memory state4 = new int256[](3);
    //     state4[0] = 1;
    //     state4[1] = 0;
    //     state4[2] = 3;

    //     int256[] memory state5 = new int256[](3);
    //     state5[0] = 1;
    //     state5[1] = 2;
    //     state5[2] = 3;

    //     int256[] memory state6 = new int256[](3);
    //     state6[0] = 0;
    //     state6[1] = 2;
    //     state6[2] = 3;

    //     int256[] memory state7 = new int256[](3);
    //     state7[0] = 0;
    //     state7[1] = 0;
    //     state7[2] = 3;


    //     result[0] = state0;
    //     result[1] = state1;
    //     result[2] = state2;
    //     result[3] = state3;
    //     result[4] = state4;
    //     result[5] = state5;
    //     result[6] = state6;
    //     result[7] = state7;


    //     // Transicion incorrecta
    //     // require(checkPreconditions(state6));
    //     // AcceptOffer();
    //     // assert(!checkPreconditions(state6));
        
    //     // Transicion correcta
    //     // require(checkPreconditions(state6));
    //     // Reject();
    //     // assert(!checkPreconditions(state1));

    //     // require(checkPreconditions(state1));
    //     // MakeOffer(20);
    //     // assert(!checkPreconditions(state6));

    //     require(checkPreconditions(state1));
    //     MakeOffer(0);
    //     assert(!checkPreconditions(state6));
        
    //     //assert(false);
    //     // Prueba p = Prueba(address(0x0000000000000000000000000000000000000000));
    //     // p.recursion(1);
    //     // assert(false);
    //     //p.combinations(states, states2, uint(0));
    //     //assert(false);
        
    //     // for (uint i = 0; i < result.length; i++) {
    //     //     //console.log("Resultado", i);
    //     //     // for (uint y = 0; y < result[i].length; y++) {
    //     //     //     //uint z = uint(result[i][y]);
    //     //     //     //console.log(z);
    //     //     // }

    //     //     bool prev= StateEnum == StateType.ItemAvailable;
    //     //     require( checkPreconditions(result[i]));
    //     //     // Hacer una acción del estado
    //     //     for (uint i = 0; i < result.length; i++) {
    //     //         assert(!checkPreconditions(result[i]));
    //     //     }
    //     // }

    //     // Estoy en {makeOffer}
    //     // makeOffer_MakeOffer(offerPrice);
    //     // makeOffer_RejectOffer(offerPrice);
    //     // makeOffer_AcceptOffer(offerPrice);

    //     // Estoy en {acceptOffer, rejectOffer}
    //     // acceptOffer_AcceptOffer();
    //     // acceptOffer_MakeOffer(offerPrice);
    //     // acceptOffer_RejectOffer();
    //     // rejectOffer_MakeOffer(offerPrice);
    //     // rejectOffer_RejectOffer();
    //     // rejectOffer_AcceptOffer();
    // }

    function recursion(int num) private {
        if (num == 0) {
            assert(false);
            return;
        }
        recursion(num - 1);
    }

    // function combinations(int256[] memory list , int256[] memory left, uint256 number) private returns (int[][] memory) {

    //     //console.log("Length first", left.length);
    //     //console.log("Number", number);
    //     if (left.length == 0) {
    //         return result;
    //     }
    //     uint256 count = number;       
    //     for (uint i = 0; i < 2 ** number; i++) {
    //         int[] memory partialResult = new int[](list.length);
    //         if (i != 2 ** number - 1) {
    //             for (uint y = 0; y < number; y++) {
    //                 partialResult[y] = result[i][y];
    //             }
    //         }
    //         partialResult[number] = left[0];
    //         result[2 ** number - 1 + i] = partialResult; 
    //     }
    //     int[] memory leftNew = new int[](left.length - 1);
        
    //     for (uint z = 1; z < left.length; z++) {
    //         leftNew[z-1] = left[z];
    //     }
    //     //console.log("Length", leftNew.length);
    //     uint256 numberNew = number + 1;
    //     //console.log("ACA", numberNew);
    //     combinations(list, leftNew, uint(numberNew));
    // } 

    function checkPreconditions(int[] memory combination) public view returns (bool) {
        bool resultBool = true;
        if (ifPresent(combination, 1)) {
            resultBool = resultBool && StateEnum == StateType.ItemAvailable;
        } else {
            resultBool = resultBool && StateEnum != StateType.ItemAvailable;
        }

        if (ifPresent(combination, 2)) {
            resultBool = resultBool && StateEnum == StateType.OfferPlaced;
        } else {
            resultBool = resultBool && StateEnum != StateType.OfferPlaced;
        }

        if (ifPresent(combination, 3)) {
            resultBool = resultBool && StateEnum == StateType.OfferPlaced;
        } else {
            resultBool = resultBool && StateEnum != StateType.OfferPlaced;
        }
        require(resultBool);
        return resultBool;
    }

    function ifPresent(int[] memory combination, int num) public view returns(bool) {
        uint arrayLength = combination.length;
        for (uint i=0; i<arrayLength; i++) {
            if(combination[i] == num){
                return true;
            }
        }
        return false;
    }

    function rejectOffer_MakeOffer(int offerPrice) private {
        // Estoy en el estado RejectOffer y quiero ver si puedo hacer MakeOffer
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        require(predA && prA);
        
        Reject();
        bool rb = StateEnum == StateType.ItemAvailable && offerPrice != 0;
        assert(!rb);
        // Falla entonces, existe transición
    }

    function rejectOffer_RejectOffer() private {
        // Estoy en el estado RejectOffer y quiero ver si puedo hacer RejectOffer.
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        //require(predA && prA);

        Reject();
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // No Falla entonces, no existe transición
    }

    function rejectOffer_AcceptOffer() private {
        // Estoy en el estado RejectOffer y quiero ver si puedo hacer AcceptOffer.
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        require(predA && prA);

        Reject();
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // No Falla entonces, no existe transición
    }

    function acceptOffer_AcceptOffer() private {
        // Estoy en el estado AcceptOffer y quiero ver si puedo hacer AcceptOffer.
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        require(predA && prA);
        
        AcceptOffer();
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // No Falla entonces, no existe transición
    }

    function acceptOffer_MakeOffer(int offerPrice) private {
        // Estoy en el estado AcceptOffer y quiero ver si puedo hacer MakeOffer.
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        require(predA && prA);

        AcceptOffer();
        bool rb = offerPrice != 0 && StateEnum == StateType.ItemAvailable;
        assert(!rb);
        // No Falla entonces, no existe transición
    }

    function acceptOffer_RejectOffer() private {
        // Estoy en el estado AcceptOffer y quiero ver si puedo hacer RejectOffer.
        bool predA = StateEnum == StateType.OfferPlaced;
        bool prA = msg.sender == InstanceOwner;
        require(predA && prA);

        AcceptOffer();
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // NoFalla entonces, no existe transición
    } 

    function makeOffer_MakeOffer(int offerPrice) private returns (bool) {
        // Estoy en el estado MakeOffer y quiero ver si puedo hacer MakeOffer.
        bool predA = StateEnum == StateType.ItemAvailable;
        bool prA = offerPrice != 0 && msg.sender != InstanceOwner;
        require(predA && prA);

        MakeOffer(offerPrice);
        bool rb = offerPrice != 0 && StateEnum == StateType.ItemAvailable;
        assert(!rb);
        // No Falla entonces, no existe transición
    }

    function makeOffer_RejectOffer(int offerPrice) private returns (bool) {
        // Estoy en el estado MakeOffer y quiero ver si puedo hacer rejectOffer.
        bool predA = StateEnum == StateType.ItemAvailable;
        bool prA = offerPrice != 0 && msg.sender != InstanceOwner;
        require(predA && prA);

        MakeOffer(offerPrice);
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // Falla entonces existe transición
    }

    function makeOffer_AcceptOffer(int offerPrice) private {
        // Estoy en el estado MakeOffer y quiero ver si puedo hacer acceptOffer.
        bool predA = StateEnum == StateType.ItemAvailable;
        bool prA = offerPrice != 0 && msg.sender != InstanceOwner;
        require(predA && prA);
        
        MakeOffer(offerPrice);
        bool rb = StateEnum == StateType.OfferPlaced;
        assert(!rb);
        // Falla entonces existe transición
    }  
}

contract Prueba {
    int256[][] result;

    function recursion(int num) public {
        if (num == 0) {
            //assert(true);
            return;
        }
        recursion(num - 1);
    }

    function combinations(int256[] memory list , int256[] memory left, uint256 number) public returns (int[][] memory) {

        //console.log("Length first", left.length);
        //console.log("Number", number);
        if (left.length == 0) {
            return result;
        }
        uint256 count = number;       
        for (uint i = 0; i < 2 ** number; i++) {
            int[] memory partialResult = new int[](list.length);
            if (i != 2 ** number - 1) {
                for (uint y = 0; y < number; y++) {
                    partialResult[y] = result[i][y];
                }
            }
            partialResult[number] = left[0];
            result[2 ** number - 1 + i] = partialResult; 
        }
        int[] memory leftNew = new int[](left.length - 1);
        
        for (uint z = 1; z < left.length; z++) {
            leftNew[z-1] = left[z];
        }
        //console.log("Length", leftNew.length);
        uint256 numberNew = number + 1;
        //console.log("ACA", numberNew);
        combinations(list, leftNew, uint(numberNew));
    }
}