<template>
  <div class="login-wrapper">
    <div class="login-box">
      <h1 class="login-title">Voting DApp</h1>
      <h2 class="login-des">Login to your account</h2>
      <button @click="connectWallet" class="login-button">Connect Wallet</button>
      <p v-if="account" class="login-account">
        Connected Account: <span>{{ account }}</span>
      </p>
    </div>
  </div>
</template>

<script>
import Web3 from "web3";

export default {
  data() {
    return {
      account: null,
    };
  },
  methods: {
    async connectWallet() {
      if (window.ethereum) {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const accounts = await web3.eth.getAccounts();
        this.account = accounts[0];
        this.$router.push("/home");
      } else {
        alert("Please install MetaMask!");
      }
    },
  },
};
</script>

<style scoped>
/* Login Page Styles */
.login-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 97vh;
  border-radius: 12px;
  background: linear-gradient(to bottom right, #4f46e5, #6b7280);
}

.login-box {
  background-color: white;
  border-radius: 12px;
  padding: 30px;
  box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
}

.login-title {
  font-size: 2.5rem;
  color: #2c3e50;
  text-align: center;
}

.login-des {
  font-family: monospace;
  font-size: 1.2rem;
  color: #2c3e50;
  text-align: center;
}

.login-button {
  width: 100%;
  padding: 15px;
  background-color: #4f46e5; /* Indigo Blue */
  color: white;
  border-radius: 8px;
  font-size: 1.2rem;
}

.login-button:hover {
  background-color: #4338ca; /* Darker Indigo */
}

.login-account {
  margin-top: 20px;
  text-align: center;
}
</style>
