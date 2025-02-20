# Voting DApp

## Overview
The **Voting DApp** is a decentralized application (DApp) built on the Ethereum blockchain using Solidity. It allows users to create, vote on, and terminate polls securely and transparently.

## Features
- **Create a Poll:** Users can create a new poll with a title, description, and a set duration.
- **Terminate a Poll:** The poll creator can terminate the poll before its scheduled end time.
- **Vote on a Poll:** Users can cast a vote on active polls (either option 1 or option 2).
- **Retrieve Active Polls:** Users can fetch a list of currently active polls.
- **Get Poll Results:** Users can view the final vote counts for a poll.

## Smart Contract Functions

### `createPoll(string _title, string _description, uint256 _durationInMinutes)`
Creates a new poll with the specified title, description, and duration.
- **_title_**: Title of the poll
- **_description_**: Description of the poll
- **_durationInMinutes_**: Duration of the poll in minutes

**Emits:** `PollCreated(pollId, title, creator)`

### `terminatePoll(uint256 _pollId)`
Terminates an active poll (only the creator can perform this action).
- **_pollId_**: ID of the poll to be terminated

**Emits:** `PollTerminated(pollId, terminatedBy)`

### `vote(uint256 _pollId, uint8 _option)`
Casts a vote on a specific poll.
- **_pollId_**: ID of the poll
- **_option_**: Voting option (1 or 2)

**Conditions:**
- The poll must exist and be active.
- The voting period must not have ended.
- The user must not have voted already.
- Only valid options (1 or 2) are accepted.

**Emits:** `VoteCast(pollId, voter, option)`

### `getActivePolls()`
Returns a list of active poll IDs.

### `getPollResults(uint256 _pollId)`
Returns the results of a specific poll.
- **Returns:** `(uint256 option1Votes, uint256 option2Votes)`

## Events
- **`PollCreated(uint256 pollId, string title, address creator)`** – Triggered when a new poll is created.
- **`PollTerminated(uint256 pollId, address terminatedBy)`** – Triggered when a poll is terminated.
- **`VoteCast(uint256 pollId, address voter, uint8 option)`** – Triggered when a user casts a vote.

