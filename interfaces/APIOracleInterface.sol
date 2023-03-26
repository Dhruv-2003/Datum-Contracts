// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

interface APIOracleInterface is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    struct APIRequest {
        Chainlink.Request req;
        bytes32 requestId;
        uint result;
    }

    event buildRequest(bytes32 jobId, uint timeStamp);

    event requestSent(Chainlink.Request req, uint apiId, uint timeStamp);

    function buildAPIRequest(
        bytes32 jobId
    ) external view returns (Chainlink.Request memory req);

    function requestBuildReq(bytes32 jobId) external;

    // By Oracle
    function completeRequestBuild(
        bytes32 jobId,
        Chainlink.Request memory req
    ) external;

    // By Client
    function sendRequest(
        Chainlink.Request memory req
    ) external payable returns (uint apiId);

    // By Oracle
    function setRequestData(uint apiId, bytes32 requestId) external;

    // By Oracle
    function fulfillRequest(uint apiId, uint result) external;

    // by Client
    function getRequestData(
        uint apiId
    ) external view returns (APIRequest memory _request);

    // by Client
    function getRequestResult(uint apiId) external view returns (uint);
}
