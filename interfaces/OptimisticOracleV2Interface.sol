// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface OptimisticOracleV2 {
    enum Status {
        Requested,
        SettleRequested,
        Settled
    }

    // Store the Req data
    struct ooRequest {
        bytes32 identifier;
        bytes ancillaryData;
        address bondCurrencyAddress;
        uint256 reward;
        uint livenessTime;
        uint256 requestTime;
        address requester;
        int256 result;
        Status currentStatus;
    }

    event requestCreated(
        uint256 requestId,
        bytes32 identifier,
        bytes ancillaryData,
        uint256 requestTime,
        address requester
    );

    event settleOORequest(uint256 requestId, uint256 timestamp);

    event resultAdded(uint256 requestId, int result, uint256 timestamp);

    // We can hardCode bond , reward & time to avoide complications
    function requestData(
        bytes32 identifier,
        bytes memory ancillaryData,
        address bondCurrencyAddress,
        uint256 rewardAmount,
        uint livenessTime
    ) external returns (uint requestId);

    // called by the request creator
    function settleRequest(uint requestId) external;

    // called by the Oracle
    function setRequestResult(uint requestId, int result) external;

    function getRequestResult(uint requestId) external view returns (int);

    function getRequest(
        uint requestId
    ) external view returns (ooRequest memory);
}
