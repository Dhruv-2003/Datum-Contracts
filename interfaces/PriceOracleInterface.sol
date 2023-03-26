// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface PriceOracleV1 {
    event requestPrice(address pricePair);

    function requestPairPrice(address pricePair) external;

    //Need to put up restrictions
    function setLatestPrice(address pairAddress, uint256 _price) external;

    //Get the latest Price
    function getLatestPrice(address pairAddress) external view returns (uint);
}
