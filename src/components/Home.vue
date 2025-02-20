<template>
  <div class="home-wrapper">
    <!-- Header Section -->
    <header class="home-header">
      <h1 class="home-title">Active Polls</h1>
      <button @click="$router.push('/create-poll')" class="create-poll-button">
        + Create Poll
      </button>
    </header>

    <!-- Poll Cards Grid -->
    <div class="poll-grid">
      <div v-for="poll in polls" :key="poll.id" class="poll-card">
        <h2 class="poll-title">{{ poll.title }}</h2>
        <p class="poll-description">{{ poll.description }}</p>
        <button @click="vote(poll.id)" class="vote-button">Vote Now</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      polls: [
        { id: 1, title: "Poll Title #1", description: "Description of Poll #1" },
        { id: 2, title: "Poll Title #2", description: "Description of Poll #2" },
        { id: 3, title: "Poll Title #3", description: "Description of Poll #3" },
      ],
    };
  },
  methods: {
    vote(pollId) {
      this.$router.push(`/vote/${pollId}`);
    },
  },
};
</script>

<style scoped>
/* Home Page Styles */
.home-wrapper {
  padding: 20px;
  background-color: #f9fafb; /* Light Gray Background */
  min-height: 100vh;
}

.home-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.home-title {
  font-size: 2.5rem;
  font-weight: bold;
  color: #111827; /* Dark Gray */
}

.create-poll-button {
  padding: 10px 20px;
  background-color: #4f46e5; /* Indigo Blue */
  color: white;
  font-size: 1rem;
  border-radius: 8px;
}

.create-poll-button:hover {
  background-color: #4338ca; /* Darker Indigo */
}

/* Poll Grid Layout */
.poll-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

/* Poll Card Styles */
.poll-card {
  background-color: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.poll-title {
  font-size: 1.5rem;
  font-weight: bold;
}

.poll-description {
  margin-top: 10px;
}

.vote-button {
  margin-top: 15px;
}

</style>
