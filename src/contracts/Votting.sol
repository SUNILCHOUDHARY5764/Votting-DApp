// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingDApp {
    struct Poll {
        uint256 id;
        string title;
        string description;
        address creator;
        uint256 startTime;
        uint256 endTime;
        bool isActive;
        mapping(address => bool) hasVoted;
        uint256 votesForOption1;
        uint256 votesForOption2;
    }

    uint256 public pollCount = 0;
    mapping(uint256 => Poll) public polls;

    event PollCreated(uint256 pollId, string title, address creator);
    event PollTerminated(uint256 pollId, address terminatedBy);
    event VoteCast(uint256 pollId, address voter, uint8 option);

    modifier onlyCreator(uint256 pollId) {
        require(polls[pollId].creator == msg.sender, "Not the poll creator");
        _;
    }

    modifier pollExists(uint256 pollId) {
        require(polls[pollId].id == pollId, "Poll does not exist");
        _;
    }

    modifier pollIsActive(uint256 pollId) {
        require(polls[pollId].isActive, "Poll is not active");
        _;
    }

    function createPoll(
        string memory _title,
        string memory _description,
        uint256 _durationInMinutes
    ) public {
        require(_durationInMinutes > 0, "Duration must be greater than 0");
        
        Poll storage newPoll = polls[pollCount];
        newPoll.id = pollCount;
        newPoll.title = _title;
        newPoll.description = _description;
        newPoll.creator = msg.sender;
        newPoll.startTime = block.timestamp;
        newPoll.endTime = block.timestamp + (_durationInMinutes * 1 minutes);
        newPoll.isActive = true;
        emit PollCreated(pollCount, _title, msg.sender);
        pollCount++;
    }

    function terminatePoll(uint256 _pollId) public onlyCreator(_pollId) pollExists(_pollId) {
        polls[_pollId].isActive = false;
        emit PollTerminated(_pollId, msg.sender);
    }

    function vote(uint256 _pollId, uint8 _option) public pollExists(_pollId) pollIsActive(_pollId) {
        require(block.timestamp <= polls[_pollId].endTime, "Voting period has ended");
        require(!polls[_pollId].hasVoted[msg.sender], "You have already voted");
        require(_option == 1 || _option == 2, "Invalid voting option");
        if (_option == 1) {
            polls[_pollId].votesForOption1++;
        } else if (_option == 2) {
            polls[_pollId].votesForOption2++;
        }
        polls[_pollId].hasVoted[msg.sender] = true;
        emit VoteCast(_pollId, msg.sender, _option);
    }

    function getActivePolls() public view returns (uint256[] memory) {
        uint256[] memory activePollIds = new uint256[](pollCount);
        uint256 counter = 0;

        for (uint256 i = 0; i < pollCount; i++) {
            if (polls[i].isActive && block.timestamp <= polls[i].endTime) {
                activePollIds[counter] = i;
                counter++;
            }
        }

        return activePollIds;
    }

    function getPollResults(uint256 _pollId) public view pollExists(_pollId) returns (uint256 option1Votes, uint256 option2Votes) {
        return (polls[_pollId].votesForOption1, polls[_pollId].votesForOption2);
    }
}
