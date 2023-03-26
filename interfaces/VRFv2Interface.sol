// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface VRFOracleV2 {
    enum Status {
        Requested,
        Fulfilled
    }

    struct VRFRequests {
        uint256 requestId;
        uint256 paid; // amount paid in link
        bool fulfilled; // whether the request has been successfully fulfilled
        uint256[] randomWords;
        uint numWords;
        Status currentStatus;
    }

    event randomnessRequested(
        uint vrfId,
        uint numWords,
        uint requestConfirmations
    );

    event randomnessFulfilled(uint vrfId);

    // By Client
    function requestRandomness(
        uint numWords,
        uint requestConfirmations
    ) external payable returns (uint vrfId);

    // By Oracle
    function setRequestData(
        uint vrfId,
        uint requestId,
        uint paidAmount
    ) external;

    // By Oracle
    function fulfillRandomness(
        uint vrfId,
        uint256[] memory _randomWords
    ) external;

    function getRandomness(uint vrfId) external view returns (uint256[] memory);
}
