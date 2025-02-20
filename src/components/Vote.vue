<template>
    <div class="vote-container">
        <div class="poll-card">
            <h2 class="poll-title">Vote on Poll</h2>
            <div class="poll-info">
                <h3 class="poll-subtitle">{{ poll.title }}</h3>
                <p class="poll-description">{{ poll.description }}</p>
            </div>
            <div class="button-group">
                <button class="vote-button" @click="castVote(1)">Option 1</button>
                <button class="vote-button" @click="castVote(2)">Option 2</button>
            </div>
        </div>
    </div>
</template>

<script>
import Web3 from "web3";
import contractABI from "../contracts/contractABI.json";
const contractAddress = "YOUR_CONTRACT_ADDRESS";

export default {
    data() {
        return {
            pollId: null,
            poll: {},
        };
    },
    async mounted() {
        this.pollId = this.$route.params.pollId;

        const web3 = new Web3(window.ethereum);
        const contract = new web3.eth.Contract(contractABI, contractAddress);

        const pollData = await contract.methods.polls(this.pollId).call();

        this.poll = { title: pollData.title, description: pollData.description };
    },
    methods: {
        async castVote(option) {
            const web3 = new Web3(window.ethereum);
            const accounts = await web3.eth.getAccounts();

            const contract = new web3.eth.Contract(contractABI, contractAddress);

            await contract.methods.vote(this.pollId, option).send({ from: accounts[0] });

            alert("Vote cast successfully!");
            this.$router.push("/home");
        },
    },
};
</script>

<style scoped>
.vote-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 50vh;
}

.poll-card {
    background-color: #f4f4f4;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 400px;
    align-items: center;
}
.poll-title{
    margin-bottom: 10px;
}
.poll-info {
    margin-bottom: 20px;
}
.button-group{
    display: flex;
    justify-content: space-around;
}
.vote-button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.vote-button:hover {
    background-color: #367c38;
}

.poll-subtitle {
    font-weight: bold;
    margin-bottom: 5px;
}

.poll-description {
    color: #555;
    margin-bottom: 10px;
}
</style>