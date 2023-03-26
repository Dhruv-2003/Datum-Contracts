// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

interface OptimisticOracleV3 {
    enum Status {
        Asserted,
        SettleRequested,
        Settled
    }

    struct AssertionRequest {
        bytes32 assertionId;
        bytes assertedClaim;
        address requester;
        bool result;
        Status currentStatus;
    }

    event assertTruth(
        uint assertId,
        address requester,
        bytes claim,
        uint timestamp
    );

    event settleRequest(uint assertId, uint timestamp);

    function assertTruthWithDefaults(
        bytes memory claim
    ) external returns (uint assertId);

    // called by the Oracle
    function setAssertionId(uint assertId, bytes32 assertionId) external;

    // called by user/ client
    function settleAssertion(uint assertId) external;

    // called by the oracle
    function setAssertResult(uint assertId, bool assertResult) external;

    function getAssertionResult(uint assertId) external view returns (bool);

    function getAssertion(
        uint assertId
    ) external view returns (AssertionRequest memory);
}
