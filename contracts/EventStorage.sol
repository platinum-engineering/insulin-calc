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
        uint256 bloodGlucose,       //Current blood glucose reading
        uint256 carbohydrateIntake, //Estimated carbohydrate intake
        uint256 unitsOfInsulin,     //Units of insulin the app has calculated for you
        Insulin insulinType // lookup table with insulin name (string) and duration in minutes 
    );

    constructor (string memory _version) {
        version = _version;
    }

    function writeMeasure (
        uint256 _timestamp,          //Unix timestamp
        uint256 _bloodGlucose,       //Current blood glucose reading
        uint256 _carbohydrateIntake, //Estimated carbohydrate intake
        uint256 _unitsOfInsulin,     //Units of insulin the app has calculated for you
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
            _bloodGlucose,
            _carbohydrateIntake,
            _unitsOfInsulin,
            _insulinType
        );

    }
}