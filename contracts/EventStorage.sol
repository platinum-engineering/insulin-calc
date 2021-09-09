// SPDX-License-Identifier: MIT
// Insulin calculator storage. Platinum devTeam.

pragma solidity ^0.8.6;

contract EventStorage {

    
    struct Insulin {
        string insulinType;
        uint256 duration;
    }

    string public version;
    Insulin[] public INSULINS; 
    // Insulin[2] public INSULINS = [
    //     Insulin('Novorapid', 180 ),
    //     Insulin('Humuline',  300 )
    // ];

    mapping(address => Insulin[]) internal personalInsulins;


    event MeasureRecord (
        address indexed sender,
        uint256 timestamp,          //Unix timestamp
        uint256 glucose,       //Current blood glucose reading
        uint256 carbs, //Estimated carbohydrate intake
        uint256 units,     //Units of insulin the app has calculated for you
        Insulin insulinType // lookup table with insulin name (string) and duration in minutes 
    );

    constructor (string memory _version) {
        version = _version;
        INSULINS.push(Insulin('Novorapid', 180 ));
        INSULINS.push(Insulin('Humuline',  300 ));
    }

    function bolus (
        uint256 _timestamp,          //Unix timestamp
        uint256 _glucose,       //Current blood glucose reading
        uint256 _carbs, //Estimated carbohydrate intake
        uint256 _units,     //Units of insulin the app has calculated for you
        uint256 _insulinIndex // index from lookup table with insulin name (string) and duration in seconds 
         
    ) 
        external 
    {
        require(_timestamp > 0, "Cant be zero");
        //TODO
        //add more checks if need like above;
        if  (personalInsulins[msg.sender].length == 0) {
            emit MeasureRecord (
                msg.sender,
                _timestamp,
                _glucose,
                _carbs,
                _units,
                INSULINS[_insulinIndex]
            );
        } else {
            emit MeasureRecord (
                msg.sender,
                _timestamp,
                _glucose,
                _carbs,
                _units,
                personalInsulins[msg.sender][_insulinIndex]
            );
        }
    }

    function addInsulin(string memory _insulin, uint256 _seconds) external {
        Insulin[] storage ins = personalInsulins[msg.sender];
        ins.push(Insulin(_insulin, _seconds));
    }

    function removeInsulin(uint256 _id) external {
        Insulin[] memory insOld = personalInsulins[msg.sender];
        //We need recreate all array due https://docs.soliditylang.org/en/v0.8.6/types.html#delete
        delete personalInsulins[msg.sender];
        for (uint256 i = 0; i < insOld.length; i++) {
            if (i != _id) {
               personalInsulins[msg.sender].push(insOld[i]); 
            }
        }
    }

    function getInsulins(address _user) public view returns (Insulin[] memory insulins) {
        if  (personalInsulins[msg.sender].length == 0) {
            return INSULINS;
        } else {
            return personalInsulins[msg.sender];
        }
    }

    // function getPersonalInsulins(address user) public view returns(string[] memory persIns) {
    //     return personalInsulins[user];
    // }

    // function getAllInsulins() public view returns (string[] memory allIns) {
    //     uint256 allArraysLength = INSULINS.length + personalInsulins[msg.sender].length;
    //     //Due https://docs.soliditylang.org/en/v0.8.6/types.html#allocating-memory-arrays
    //     string[] memory result  = new string[](allArraysLength);
    //     for (uint256 i = 0; i < INSULINS.length; i++) {
    //         result[i] = INSULINS[i];
    //     }
    //     //add spersonal array
    //     for (uint256 i = 0; i < personalInsulins[msg.sender].length; i++) {
    //         result[i + INSULINS.length] = personalInsulins[msg.sender][i];
    //     }
    //     return result;

    // }
}
