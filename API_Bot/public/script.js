document
  .getElementById("chat-form")
  .addEventListener("submit", async function (e) {
    e.preventDefault(); // Prevent the default form submission
    const userInput = document.getElementById("user-input"); // Get the user input element
    const chatbox = document.getElementById("chatbox"); // Get the chatbox element

    // Create a new div for the user message
    const userMessageEl = document.createElement("div");
    userMessageEl.innerHTML = `
                <p style="text-align: right; margin-bottom: 10px;">
                    <strong>You:</strong> ${userInput.value}
                </p>
            `;
    chatbox.appendChild(userMessageEl); // Append the user message to the chatbox

    // Send the user input to the server and get the response
    const response = await fetch("/api/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ message: userInput.value }), // Send the user input as JSON
    });
    const data = await response.json(); // Parse the JSON response

    // Create a new div for the bot response
    const botMessageEl = document.createElement("div");
    botMessageEl.innerHTML = `
                <p style="text-align: left; margin-bottom: 10px;">
                    <strong>Chatbot:</strong> ${data.response}
                </p>
            `;
    chatbox.appendChild(botMessageEl); // Append the bot response to the chatbox

    chatbox.scrollTop = chatbox.scrollHeight; // Scroll to the bottom of the chatbox
    userInput.value = ""; // Clear the user input field
  });
