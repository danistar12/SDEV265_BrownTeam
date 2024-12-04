// Gemini API Configuration
const API_KEY = "AIzaSyA0evjY-qQ4IoXLkDMZVUUJRzXLLt9KBPw";

class ChatBot {
  constructor(apiKey) {
    this.apiKey = apiKey;
    this.initializeElements();
    this.addEventListeners();
  }

  initializeElements() {
    this.messagesContainer = document.getElementById("chat-messages");
    this.userInput = document.getElementById("user-input");
    this.sendButton = document.getElementById("send-btn");
  }

  addEventListeners() {
    this.sendButton.addEventListener("click", () => this.sendMessage());
    this.userInput.addEventListener("keypress", (e) => {
      if (e.key === "Enter") this.sendMessage();
    });
  }

  async sendMessage() {
    const userMessage = this.userInput.value.trim();
    if (!userMessage) return;

    // Display user message
    this.displayMessage(userMessage, "user-message");
    this.userInput.value = "";

    try {
      // Send to Gemini API
      const aiResponse = await this.getAIResponse(userMessage);

      // Display AI response
      this.displayMessage(aiResponse, "ai-message");
    } catch (error) {
      this.displayMessage("Sorry, I encountered an error.", "ai-message");
      console.error("API Error:", error);
    }
  }

  async getAIResponse(message) {
    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${this.apiKey}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contents: [
            {
              parts: [
                {
                  text: `You are an AI assistant for Ivy Tech Community College IT Department. ${message}`,
                },
              ],
            },
          ],
        }),
      }
    );

    const data = await response.json();
    return data.candidates[0].content.parts[0].text;
  }

  displayMessage(message, className) {
    const messageElement = document.createElement("div");
    messageElement.classList.add("message", className);
    messageElement.textContent = message;
    this.messagesContainer.appendChild(messageElement);
    this.messagesContainer.scrollTop = this.messagesContainer.scrollHeight;
  }
}

// Initialize the chatbot
document.addEventListener("DOMContentLoaded", () => {
  new ChatBot(API_KEY);
});
