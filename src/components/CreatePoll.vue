<template>
  <div class="create-poll-wrapper">
    <div class="create-poll-container">
      <h1 class="create-poll-title">Create a New Poll</h1>
      <form @submit.prevent="createPoll" class="create-poll-form">
        <!-- Poll Title -->
        <div class="form-group">
          <label for="title" class="form-label">Poll Title</label>
          <input
            type="text"
            id="title"
            v-model="title"
            placeholder="Enter poll title"
            class="form-input"
            required
          />
        </div>

        <!-- Poll Description -->
        <div class="form-group">
          <label for="description" class="form-label">Poll Description</label>
          <textarea
            id="description"
            v-model="description"
            placeholder="Enter poll description"
            class="form-textarea"
            required
          ></textarea>
        </div>

        <!-- Poll Duration -->
        <div class="form-group">
          <label for="duration" class="form-label">Poll Duration (in minutes)</label>
          <input
            type="number"
            id="duration"
            v-model.number="duration"
            placeholder="Enter duration in minutes"
            class="form-input"
            required
          />
        </div>

        <!-- Submit Button -->
        <button type="submit" class="submit-button">Create Poll</button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      title: "",
      description: "",
      duration: null,
    };
  },
  methods: {
    createPoll() {
      if (this.title && this.description && this.duration) {
        alert("Poll created successfully!");
        this.$router.push("/home");
      } else {
        alert("Please fill in all fields.");
      }
    },
  },
};
</script>

<style scoped>
/* Wrapper Styles */
.create-poll-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: linear-gradient(to bottom right, #f3f4f6, #e5e7eb);
}

/* Container Styles */
.create-poll-container {
  background-color: white;
  width: 100%;
  max-width: 500px;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.1);
}

/* Title Styles */
.create-poll-title {
  font-size: 2rem;
  font-weight: bold;
  color: #111827; /* Dark Gray */
  text-align: center;
  margin-bottom: 20px;
}

/* Form Styles */
.create-poll-form {
  display: flex;
  flex-direction: column;
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  font-size: 1rem;
  font-weight: bold;
  color: #4b5563; /* Medium Gray */
}

.form-input,
.form-textarea {
  width: 100%;
  padding: 10px;
  border-radius: 8px;
  border: none;
  background-color: #f9fafb; /* Light Gray */
}

.form-input::placeholder,
.form-textarea::placeholder {
  color: #9ca3af; /* Placeholder Gray */
}

.form-input:hover,
.form-textarea:hover {
  background-color: #f3f4f6; /* Slightly Darker Gray */
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border: solid #4f46e5; /* Indigo Blue Focus Border */
}

/* Button Styles */
.submit-button {
  width: auto;
}

</style>
