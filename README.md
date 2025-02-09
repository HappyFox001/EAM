# EAM (Ethereum Agent Manager)

## Something about us

When I was young, I always dreamed to become a super hero that can change the world. And now, AI is the biggesr hero in the world.So we build Ethereum Agent Manager named EAM.We want to bring 10M Web2 users to Ethereum by simplifying interactions and enhancing security checks.We think it's not only a dream, it's a reality that can change the world.

## Overview

EAM is an innovative AI-powered middleware layer built between Ethereum and users, designed to revolutionize Web3 adoption. By leveraging advanced AI language capabilities, EAM aims to onboard the next 10M users into the Web3 ecosystem by making Ethereum interactions intuitive and secure.

## Quick Start

### Build Your Self

```bash
cd charlotte
flutter pub get
flutter run
```

### Get App

[Web Page](https://happyfox001.github.io/EAM)

⚠️ App still not working,waiting for interface alignment

**EAM consists of three main components:**

- Charlotte: Frontend Application built with Flutter for cross-platform compatibility, intuitive user interface, and natural language interactions.

- AI Backend: Developed with Python language, optimized for performance and security, and integrated with Charlotte.

- Security Check Model: Designed to check the security of user transactions and contracts, ensuring that users are protected from common Web3 vulnerabilities.

## Mission

Our mission is to bridge the gap between traditional users and Web3 technology by providing an intelligent, secure, and user-friendly interface that transforms natural language inputs into Ethereum operations.

## Architecture

![EAM Architecture](./Web/src/assets/figure2.svg)

EAM consists of three main components:

### 1. Charlotte

```mermaid
graph TD
    A[Charlotte App] --> B[UI Layer]
    A --> C[Business Logic Layer]
    A --> D[Blockchain Layer]

    B --> B1[Welcome Screen]
    B --> B2[Chat Interface]
    B --> B3[Wallet UI]
    B --> B4[Transaction Preview]

    C --> C1[Natural Language Processing]
    C --> C2[Wallet Management]
    C --> C3[Transaction Handler]

    D --> D1[Web3 Connection]
    D --> D2[Smart Contract Interface]
    D --> D3[Transaction Signing]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#bfb,stroke:#333,stroke-width:2px
    style D fill:#fbb,stroke:#333,stroke-width:2px
```

- Built with Flutter for cross-platform compatibility
- Intuitive user interface for natural language interactions
- Supports both text and voice inputs
- Real-time transaction preview and confirmation
- Wallet integration and management

### 2. AI Backend

```mermaid
graph TD
    A[AI Backend] --> B[Language Processing]
    A --> C[Knowledge System]
    A --> D[Command System]

    B --> B1[NLP Engine]
    B --> B2[Intent Analysis]
    B --> B3[Multi-language Support]

    C --> C1[RAG System]
    C --> C2[Knowledge Base]
    C --> C3[Chain Protocols]

    D --> D1[Command Generator]
    D --> D2[JSON Formatter]
    D --> D3[Chain Adapter]

    style A fill:#f96,stroke:#333,stroke-width:2px
    style B fill:#9cf,stroke:#333,stroke-width:2px
    style C fill:#9fc,stroke:#333,stroke-width:2px
    style D fill:#f9c,stroke:#333,stroke-width:2px
```

- Advanced Natural Language Processing for understanding user intentions
- RAG (Retrieval-Augmented Generation) system for accurate command matching
- Smart command generation and optimization
- Standardized JSON output format for blockchain operations
- Multi-chain support and protocol adaptation

### 3. Security Check Model

```mermaid
graph TD
    A[Security Check] --> B[Contract Analysis]
    A --> C[Transaction Safety]
    A --> D[User Protection]

    B --> B1[Static Analysis]
    B --> B2[Risk Assessment]
    B --> B3[Vulnerability Scanner]

    C --> C1[Real-time Validator]
    C --> C2[Gas Analyzer]
    C --> C3[Behavior Monitor]

    D --> D1[Scam Detection]
    D --> D2[Safety Rules]
    D --> D3[Alert System]

    style A fill:#f66,stroke:#333,stroke-width:2px
    style B fill:#6f6,stroke:#333,stroke-width:2px
    style C fill:#66f,stroke:#333,stroke-width:2px
    style D fill:#f6f,stroke:#333,stroke-width:2px
```

- AI-powered smart contract risk assessment
- Real-time transaction analysis and validation
- Malicious contract detection
- Gas optimization recommendations
- User protection against common Web3 vulnerabilities

## Workflow

```mermaid
graph TD
    A[User Input] -->|Natural Language| B[Charlotte]
    B -->|Request| C[AI Backend]
    C -->|Command Generation| D[Security Check]
    D -->|Validation| E[Smart Contract Interaction]
    E -->|Confirmation| F[Transaction Execution]
    F -->|Result| B
```

## Key Features

- **Natural Language Interface**: Interact with Ethereum using everyday language
- **Intelligent Command Generation**: Automatic conversion of user intentions into Ethereum operations
- **Security First**: Built-in security checks and risk assessment
- **Multi-Protocol Support**: Compatible with various DeFi protocols and Web3 applications
- **User-Friendly**: Simplified transaction flow with clear confirmations
- **AI-Powered Protection**: Advanced security measures to protect users from scams and errors

## Core Team Members

| Name       | Role | Background                                |
| ---------- | ---- | ----------------------------------------- |
| Qian Zhang | CEO  | Blockchain Engineer、Researcher in 6block |
| Junjie Shi | CTO  | AI engineer and blockchain expert         |

## Related Papers

1. **Realhybrid: A Hybrid Blockchain Consensus with Node-Level Switching**
   - *Authors*: Hao Yang, Jing Chen*, Chun Kit SZE, Meng Jia, Ruiying Du, Kun He
   - *Conference*: USENIX ATC
   - *Status*: Submitted

2. **Catching Large-Scale DeFi Security Threats via Graph-Transformer Language Mode**
   - *Authors*: Wei Ma, Chun Kit SZE (co-first author), Jiaxi Qiu, Cong Wu*, Jing Chen, Lingxiao Jiang, Shangqing Liu, Yang Liu, Xiang Yang
   - *Journal*: IEEE TIFS
   - *Status*: Submitted

## Related technologies

- ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
- ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
- ![Ethereum](https://img.shields.io/badge/Ethereum-3C3C3D?style=flat&logo=ethereum&logoColor=white)
- ![AI](https://img.shields.io/badge/AI-FFC57D?style=flat&logo=ai&logoColor=white)
- ![Web3](https://img.shields.io/badge/Web3-34A85A?style=flat&logo=web3&logoColor=white)

## Future Development

- Multi-chain support expansion
- Advanced AI model iterations
- Enhanced security features
- Integration with more DeFi protocols(As Demo,we only have time to support Uniswap V3 and Lido)

## What we want to achieve

We want to make Ethereum more accessible to Web2 users by solving some of the key challenges in the current ecosystem, such as understanding user needs and ensuring security.We want to make Web3 become the future of the world.
