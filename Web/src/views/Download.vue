<template>
  <div class="container">
    <div class="left">
      <img src="../assets/app.svg" height="60vh" alt="app" />
    </div>
    <div class="right">
      <p>
        Ethereum Agent Manager is an AI-powered tool 
        that enables seamless one-click on-chain operations with built-in risk assessment.
        Download now to interact with Ethereum effortlessly and securely.
      </p>
      <button class="download-btn">Download</button>
    </div>
  </div>
</template>

<style scoped>
@font-face {
  font-family: 'Montserrat';
  src: url('../assets/fonts/Montserrat/Montserrat-Italic-VariableFont_wght.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}

* {
  font-family: Montserrat;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4rem;
  width: 100%;
  height: 100vh;
  padding: 2rem;
  background-color: #0a0a0a;
}

.left {
  flex: 1;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  max-width: 40%;
}

.left img {
  width: auto;
  max-width: 400px;
  height: 60vh;
  object-fit: contain;
}

.right {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 2rem;
  max-width: 55%;
  padding: 2rem;
}

.right p {
  color: #ffffff;
  font-size: 1.5rem;
  line-height: 1.6;
  margin: 0;
  opacity: 0.9;
}

.download-btn {
  background: linear-gradient(135deg, #3498db, #2980b9);
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.2rem;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  width: fit-content;
  font-weight: 600;
}

.download-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
}

.download-btn:active {
  transform: translateY(0);
}

@media (max-width: 1024px) {
  .container {
    flex-direction: column;
    gap: 2rem;
  }

  .left,
  .right {
    max-width: 100%;
    justify-content: center;
    text-align: center;
  }

  .right {
    align-items: center;
  }

  .right p {
    font-size: 1.2rem;
  }
}
</style>
