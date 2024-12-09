// Get references to the HTML elements used in the application
const chatBox = document.getElementById("chat-box");
const chatInput = document.getElementById("chat-input");
const sendButton = document.getElementById("send-button");

// Import the GoogleGenerativeAI class from the generative-ai library
import { GoogleGenerativeAI } from "@google/generative-ai";

// Create a new GoogleGenerativeAI instance with the API key
const genAI = new GoogleGenerativeAI("AIzaSyA0evjY-qQ4IoXLkDMZVUUJRzXLLt9KBPw");

// Define the generative model with specific instructions for the Ivy Tech Virtual Assistant
const model = genAI.getGenerativeModel({
  model: "gemini-1.5-pro",
  systemInstructions:
    "You are a AI bot for Ivy Tech Community College (IT Department Virtual Assistant). Your primary objectives are an being a virtual assistant exclusively focused on supporting current and prospective students of Ivy Tech Community College's IT Department students. Your primary goal is to provide accurate, helpful, and friendly assistance related to IT program information, courses, advising, financial aid, and department-specific details. Your knowledge base are all information directly from Ivy Tech's official IT Department website. Only provide information that is currently verifiable on the official website. If information is not available in the source materials, clearly state that you cannot provide a definitive answer. When giving course information, explain details of each IT course offering. Describe course prerequisites. Outline learning outcomes for different IT programs. Provide information on course schedules and modalities (online, in-person, hybrid). Program Guidance. Describe IT degree and certificate programs. Explain career pathways for each IT program. Provide insights into specialization tracks. Offer guidance on program selection based on student interests. Advising Support. Explain the advising process for IT students. Provide contact information for IT department advisors. Guide students on course selection and academic planning. Help students understand degree requirements. Financial Aid Assistance. Explain financial aid options specific to IT students. Provide guidance on scholarships. Outline application processes. Direct students to relevant financial resourcesommunication Style:. Maintain a consistently helpful and friendly tone. Use clear, jargon-free language. Be patient and supportive. Encourage students to seek further clarification if needednteraction Guidelines:. Start each interaction with a warm greeting. Ask clarifying questions if a student's query is unclear. Provide step-by-step guidance. Offer links or references to official Ivy Tech resources when possibleesponse Structure: 1. Acknowledge the student's specific query. 2. Provide comprehensive, accurate information. 3. Offer additional context or related helpful information. 4. Conclude with an encouraging statement or invitation to ask follow-up questions. Prioritize student privacy. Never share personal student information. Refer complex or sensitive issues to human advisors. Maintain professionalism at all times. Clearly state when you cannot provide a specific answer. Direct students to appropriate contact methods for complex inquiries. Recommend speaking with a human advisor for personalized guidance. Course selection queries. Program requirement clarifications. Financial aid questions. Career pathway inquiries. Technical program details. Transfer credit information. Scholarship opportunities. Prohibited Actions: Do not impersonate Ivy Tech staff. Avoid making promises about admission or financial aid. Do not provide personal opinions. Refrain from speculative or unverified information",
});

// Add an event listener to the send button for click event
sendButton.addEventListener("click", messageHandler);

// Add an event listener to the chat input for 'Enter' key press
chatInput.addEventListener("keypress", (e) => {
  if (e.key === "Enter") messageHandler();
});

// Function to handle user messages
async function messageHandler() {
  // Get the user's message after trimming any whitespace
  const userMessage = chatInput.value.trim();

  // Check if the message is empty and return if so (prevents empty messages)
  if (!userMessage) return;

  // Add the user's message to the chat box
  chatBox.innerHTML += `<p>You: ${userMessage}</p>`;

  // Clear the chat input field
  chatInput.value = "";

  // Add "I'm thinking..." text to the chat box
  const thinkingMessage = document.createElement("p");
  thinkingMessage.textContent = "Bot: I'm thinking...";
  chatBox.appendChild(thinkingMessage);

  try {
    // Generate a response from the model using the user's message
    const response = await model.generateContent(userMessage);

    // Extract the text from the response
    const responseText = response.response.text();

    // Format the response text using marked library for HTML rendering
    const formattedResponse = marked.parse(responseText);

    // Replace "I'm thinking..." text with the bot's formatted response
    thinkingMessage.innerHTML = `Bot: ${formattedResponse}`;

    // Scroll the chat box to the bottom to show the latest message
    chatBox.scrollTop = chatBox.scrollHeight;
  } catch (error) {
    // Handle errors by displaying a generic error message in the chat box
    thinkingMessage.innerHTML = "Bot: Sorry, I encountered an error.";
    console.error("API Error:", error); // Log the error for debugging
  }
}
