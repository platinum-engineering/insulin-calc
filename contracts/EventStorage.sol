// SPDX-License-Identifier: MIT
// Insulin calculator storage. Platinum devTeam.

pragma solidity ^0.8.6;

contract EventStorage {

    string public version;

    struct Insulin {
        string insulinType;
        uint256 duration;
    }

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
    }

    function bolus (
        uint256 _timestamp,          //Unix timestamp
        uint256 _glucose,       //Current blood glucose reading
        uint256 _carbs, //Estimated carbohydrate intake
        uint256 _units,     //Units of insulin the app has calculated for you
        Insulin calldata _insulinType // lookup table with insulin name (string) and duration in minutes 
         
    ) 
        external 
    {
        require(_timestamp > 0, "Cant be zero");
        //TODO
        //add more checks if need like above;

        emit MeasureRecord (
            msg.sender,
            _timestamp,
            _glucose,
            _carbs,
            _units,
            _insulinType
        );

    }
}