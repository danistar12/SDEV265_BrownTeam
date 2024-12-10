# Ivy Tech AI Chatbot

This is a NodeJS AI chatbot using Google Gemini 1.5 Pro to assist with information related to Ivy Tech Community College.

## Navigation

- [Home](#ivy-tech-ai-chatbot)
- [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Project Structure](#project-structure)
- [Authors](#authors)

## Authors

- Divya Rasania
- Syntiche Tshimanga
- Danielle Lloyd
- Ashley Torres

## Setup

### Prerequisites

**Node.js**: Make sure you have Node.js installed. You can download it from [nodejs.org](https://nodejs.org/).

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/danistar12/SDEV265_BrownTeam.git
   cd SDEV265_BrownTeam/API_Bot
   ```
2. **Install dependencies**:
   ```bash
   npm install
   ```
3. **Setup your Google Gemini API key:**:

   - Create a new file named `.env` in the `API_Bot` directory.
   - Go to the [Google AI Studio](https://aistudio.google.com/app/apikey) page and create your API Key.
   - Add the following line to the `.env` file, replacing `YOUR_API_KEY` with your Google Gemini API key.

   ```
   GEMINI_API_KEY=YOUR_API_KEY
   ```

4. **Start the server**:
   ```bash
   npm start
   ```
5. **Open the chatbot in your browser**:
   ```
   http://localhost:3000
   ```
6. **Ask your questions**

### Project Structure

- `server.js:` Sets up an Express server to serve the HTML file and handle chatbot interactions.
- `public/ui.html:` Provides the chat interface for user interaction.
- `public/style.css:` Contains the CSS styling for the chat interface.
- `public/script.js:` Contains the JavaScript to handle user input and display chatbot responses.
- `.env:` Contains environment variables, including the Google Gemini API key.
