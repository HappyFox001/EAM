<template>
    <div class="home-container">
      <div class="header">
        <h1>Bridging 10M Web2 users to Web3 via AI</h1>
      </div>

      <router-link v-bind:to="{name: 'download' }"><button class="get-started-btn">Get started</button></router-link>

      <div class="description">
        <h1>
          Scroll down to see how we change Ethereum interactions.
        </h1>
      </div>
    </div>
    <div class="second-section">
    <div class="content-container">
      <div class="image-box">
        <img src="../assets/figure1.svg" alt="Informative Image">
      </div>
      <div class="text-box">
        <h2>Challenges</h2>
        <p>
          Users need to understand blockchain logic, grasp the concept of decentralization, 
          and overcome the fear of the on-chain "dark forest." 
          These are not only key features of Web3 but also major barriers 
          preventing Web2 users from transitioning to Web3.
        </p>
        <button class="learn-more-btn">Learn More</button>
      </div>
    </div>
  </div>
  <div class="second-section">
    <div class="content-container">
      <div class="image-box">
        <img src="../assets/figure2.svg" alt="Informative Image">
      </div>
      <div class="text-box">
        <h2>EAM</h2>
        <p>
          EAM (Ethereum Agent Manager) is an AI-powered layer between users and Ethereum, 
          enabling one-click on-chain operations with built-in risk assessment, 
          so users can interact with Ethereum without expertise.
        </p>
        <button class="learn-more-btn">Learn More</button>
      </div>
    </div>
  </div>
  <div class="second-section">
    <div class="content-container">
      <div class="image-box section_three" >
        <img src="../assets/figure3.svg" alt="Informative Image">
      </div>
      <div class="text-box">
        <h2>What we want ?</h2>
        <p>
          We aim to bring 10M Web2 users to Ethereum by simplifying interactions and enhancing security checks.
        </p>
        <button class="learn-more-btn">Learn More</button>
      </div>
    </div>
  </div>
  <div class="explanation">
    <div class="explanation-item hidden">
      <h2>What is EAM?</h2>
      <p>EAM (Ethereum Agent Manager) is a universal AI Agent virtual machine layer built between Ethereum and users, designed to transform user needs into one-click authorized on-chain operations.
      </p>
      <a href="#" target="_blank">
        <button class="cta-button learn-more">Learn More</button>
      </a>
    </div>
    <div class="explanation-item hidden">
      <h2>Smart Instruction Generation</h2>
      <p>Using RAG (Retrieval-Augmented Generation) technology, EAM automatically matches instruction flows for different applications, making blockchain interactions more intuitive and user-friendly.
      </p>
      <a href="#" target="_blank">
        <button class="cta-button learn-more">Learn More</button>
      </a>
    </div>
    <div class="explanation-item hidden">
      <h2>AI Security Audit</h2>
      <p>EAM leverages AI models for operation risk management, preventing malicious contract calls and ensuring the safety of your blockchain transactions.
      </p>
      <a href="#" target="_blank">
        <button class="cta-button learn-more">Learn More</button>
      </a>
    </div>
    <div class="explanation-item hidden download">
      <h2 style="color: black;">One-Click Authorization</h2>
      <p style="color: black;">After user authorization, EAM can automatically execute on-chain operations, reducing complex interactions and making Web3 more accessible to everyone.</p>
      <a>
        <button class="cta-button whitepaper">Whitepaper</button>
      </a>
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
  *{
    font-family: Montserrat;
    font-weight: bold;
  }
  @keyframes purple-glow {
    0% {
      box-shadow: 0 0 15px 5px rgba(61, 109, 121, 0.4);
    }
    50% {
      box-shadow: 0 0 30px 10px rgba(23, 47, 124, 0.7);
    }
    100% {
      box-shadow: 0 0 15px 5px rgba(92, 15, 165, 0.4);
    }
  }
  
  .home-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    top:10vh;
    height: 90vh;
    background-color: #0a0a0a;
    color: white;
    text-align: center;
    position: relative;
  }
  
  .header h1 {
    font-size: 2.5vw;
    margin-bottom: 5vh;
    letter-spacing: 0.1rem;
    background: linear-gradient(90deg, rgb(34, 62, 94) 0%, rgb(80, 141, 197) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  
  .swap-box {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #1a1a1a;
    padding: 1vh 2vw;
    border-radius: 1.5rem;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.7);
    width:30%;
    height: 30%;
    animation: purple-glow 3s infinite ease-in-out;
  }
  
  .swap-input {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    width: 100%;
    margin-bottom: 2vh;
  }
  
  .input-label {
    font-size: 1.2vw;
    color: #168ddb;
    margin-bottom: 1vh;
  }
  
  .custom-select {
    width: 100%;
    padding: 1.2vh;
    font-size: 0.9vw;
    background-color: #2a2a2a;
    color: white;
    border: none;
    border-radius: 0.5rem;
    outline: none;
    appearance: none;
    position: relative;
    transition: background 0.3s ease;
  }
  
  .custom-select:hover {
    background-color: #333;
  }
  
  .custom-select::after {
    content: '';
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    border: 6px solid transparent;
    border-top-color: #168ddb;
  }

  .get-started-btn {
    background-color: #168ddb;
    color: white;
    padding: 1vh 3vw;
    font-size: 2.0vw;
    border: none;
    border-radius: 0.5rem;
    cursor: pointer;
    transition: transform 0.3s ease;
    animation: purple-glow 3s infinite ease-in-out;
  }
  
  .get-started-btn:hover {
    transform: scale(1.1);
  }
  
  .description h1{
    background: linear-gradient(90deg, rgb(34, 62, 94) 0%, rgb(80, 141, 197) 100%);
    margin-top: 3rem;
    font-size: 1.2rem;
    max-width: 400px;
    opacity: 0.85;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  
  .scroll-indicator {
    position: absolute;
    bottom: 3rem;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  
  .scroll-indicator span {
    font-size: 2.5rem;
    animation: purple-glow 1.5s infinite ease-in-out;
  }
  
  .scroll-indicator p {
    font-size: 1.1rem;
    margin-top: 0.5rem;
    opacity: 0.8;
  }
  
  .home-container::before {
    content: "";
    position: absolute;
    width: 200%;
    height: 200%;
    background: linear-gradient(130deg, rgba(128, 0, 128, 0.2), rgba(255, 0, 255, 0.3));
    top: -50%;
    left: -50%;
    animation: purple-flow 6s infinite linear;
    z-index: -1;
  }
  
  @keyframes purple-flow {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }


.second-section {
  display: flex;
  height: 90vh;
  background-color: #0a0a0a;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: left;
  padding: 0 5%;
  top:10vh;
}

.content-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  margin-top: -10vh;
}

.image-box {
  flex: 1;
  padding-right: 2rem;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.image-box img {
  max-width: 80%;
  max-height: 400px;
  width: auto;
  height: auto;
  object-fit: contain;
  border-radius: 12px;
  transition: transform 0.3s ease;
}

.image-box img:hover {
  transform: scale(1.02);
}

.section_three{
  width:1vw;
}

.text-box {
  flex: 1;
  padding-left: 2rem;
  margin-left: -5vw;
}

.text-box h2 {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.text-box p {
  font-size: 1.2rem;
  line-height: 1.5;
}

.learn-more-btn {
  background-color: #168ddb;
  color: white;
  padding: 0.8rem 2rem;
  margin-top: 1.5rem;
  border: none;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: transform 0.3s ease;
  animation: purple-glow 3s infinite ease-in-out;
}

.learn-more-btn:hover {
  transform: scale(1.1);
}

.explanation {
  display: flex;
  flex-direction: column; /* Change to column layout for smaller screens */
  background-color: #0a0a0a;
  padding-bottom: 1vh;
  height: 90vh; /* Remove fixed height */
}

.explanation-item {
  display: flex; 
  flex-direction: column; 
  justify-content: space-between;
  margin-top: 5vh; /* Adjust margin using vh */
  width: 100%; /* Full width on smaller screens */
  background-color: #0a0a0a;
  text-align: center;
  border-bottom: 1px solid #444; /* Change border to bottom for column layout */
  padding: 1vh 1vw; /* Adjust padding for better spacing */
  color: #fff;
  position: relative;
  box-sizing: border-box;
}

.explanation-item:last-child {
  border-bottom: none; 
}

.hidden {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.6s ease, transform 0.6s ease;
}

.explanation-item.visible {
  opacity: 1;
  transform: translateY(0);
}

.explanation-item h2 {
  font-size: 1.5vw; /* Responsive font size */
  margin-bottom: 2vh; 
  color: #fff;
}

.learn-more, .whitepaper {
  background: #a24dff;
  border: none;
  color: #0a0a0a;
  padding: 1vh 2vw; /* Adjust padding for better spacing */
  font-size: 1vw; /* Responsive font size */
  cursor: pointer;
  transition: background 0.3s ease;
  text-transform: uppercase;
  margin-top: auto;
  margin-bottom: 1vh;
}

.whitepaper {
  background-color: #0a0a0a;
  color: white;
}

.learn-more:hover, .whitepaper:hover {
  background: #fff;
  color: #4dc7ff;
}

.download {
  background-color: #168ddb;
  color: #0a0a0a;
}

.explanation-item p {
  font-size: 1.0vw; /* Responsive font size */
  color: #a1a1a1;
  margin: 1vh 0 2vh; /* Adjust margin using vh */
  line-height: 1.5;
  text-align: left;
}

@media (min-width: 769px) {
  .explanation {
    flex-direction: row; /* Change to row layout for larger screens */
    height: 88vh; /* Set height for larger screens */
  }

  .explanation-item {
    width: 25%; /* Set width for row layout */
    border-right: 0.11vh solid #444; /* Change border to right for row layout */
    border-bottom: none; /* Remove bottom border for row layout */
  }

  .explanation-item:last-child {
    border-right: none; 
  }
}
.cta-button {
  background: linear-gradient(45deg, #245868, #180775);
  border: none;
  color: #fff;
  padding: 1.5vh 4vw; /* Adjust padding for better spacing */
  font-size: 1.2vw; /* Responsive font size */
  letter-spacing: 1.5px;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.4s ease;
  position: relative;
  box-shadow: 0 8px 15px rgba(53, 118, 172, 0.6);
  border-radius: 50px;
  z-index: 1;
  overflow: hidden;
}

.cta-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 0;
  height: 100%;
  background: rgba(255, 255, 255, 0.2);
  transition: width 0.4s ease;
  z-index: -1;
}

.cta-button:hover::before {
  width: 100%;
}

.cta-button:hover {
  color: #0a0a0a;
  box-shadow: 0 8px 30px rgba(206, 16, 196, 0.8);
  transform: translateY(-5px);
}

</style>
<script>
export default {
mounted() {
    // 在 mounted 钩子中调用 Intersection Observer 的设置函数，确保在每次导航时初始化
    this.setupIntersectionObserver();
  },
methods: {
    setupIntersectionObserver() {
      const items = document.querySelectorAll('.explanation-item');
      const thresholds = [0.25, 0.5, 0.75, 0.95];
      const delay = 100;

      // 在设置观察者之前重置可见性为 hidden
      items.forEach(item => item.classList.remove('visible'));

      // 创建一个新的 Intersection Observer
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              const ratio = entry.intersectionRatio;

              // 根据当前的曝光率显示多少项
              for (let i = 0; i < thresholds.length; i++) {
                if (ratio >= thresholds[i]) {
                  this.showItemsWithDelay(items, i + 1);
                }
              }
            }
          });
        },
        {
          threshold: thresholds,
        }
      );

      // 观察要显示的元素
      observer.observe(document.querySelector('.explanation'));
    },
    showItemsWithDelay(items, count) {
      for (let i = 0; i < items.length; i++) {
        if (i < count) {
          setTimeout(() => {
            items[i].classList.add('visible');
          }, i * 100);
        } else {
          items[i].classList.remove('visible');
        }
      }
    }
}
}
</script>