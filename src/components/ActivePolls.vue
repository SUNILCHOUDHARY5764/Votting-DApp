<template>
    <div>
      <h2>Active Polls</h2>
      <ul v-if="polls.length > 0">
        <li v-for="poll in polls" :key="poll.id">
          {{ poll.title }} - {{ poll.description }}
          <button @click="vote(poll.id)">Vote</button>
        </li>
      </ul>
      <p v-else>No active polls available.</p>
    </div>
  </template>
  
  <script>
  import Web3 from "web3";
  import contractABI from "../contracts/contractABI.json"; // Replace with your ABI
  
  const contractAddress = "YOUR_CONTRACT_ADDRESS";
  
  export default {
    data() {
      return {
        polls: [],
      };
    },
    async mounted() {
      const web3 = new Web3(window.ethereum);
      const contract = new web3.eth.Contract(contractABI, contractAddress);
      
      const activePollIds = await contract.methods.getActivePolls().call();
      
      for (const id of activePollIds) {
        const poll = await contract.methods.polls(id).call();
        this.polls.push({ id, title: poll.title, description: poll.description });
      }
    },
    methods: {
      vote(pollId) {
        this.$router.push(`/vote/${pollId}`);
      },
    },
  };
  </script>
  