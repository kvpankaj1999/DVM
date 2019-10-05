pragma solidity >=0.4.11 <0.7.0;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint votes;
    }

    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    uint public totalCandidates;

    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("ABC");
        addCandidate("XYZ");
    }

    function addCandidate (string memory _name) private {
        totalCandidates ++;
        candidates[totalCandidates] = Candidate(totalCandidates, _name, 0);
    }

    function vote (uint _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= totalCandidates);
        voters[msg.sender] = true;
        candidates[_candidateId].votes ++;

        emit votedEvent(_candidateId);
    }
}