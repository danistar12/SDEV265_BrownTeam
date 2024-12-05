const chatBox = document.getElementById("chat-box");
const chatInput = document.getElementById("chat-input");
const sendButton = document.getElementById("send-button");
const API_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyA0evjY-qQ4IoXLkDMZVUUJRzXLLt9KBPw`;

sendButton.addEventListener("click", messageHandler);
chatInput.addEventListener("keypress", (e) => {
  if (e.key === "Enter") messageHandler();
});

async function getAIResponse(userMessage) {
  try {
    const response = await fetch(API_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        contents: [
          {
            parts: [{ text: userMessage }],
          },
        ],
      }),
    });

    const data = await response.json();
    return data.candidates[0].content.parts[0].text;
  } catch (error) {
    console.error("Detailed Error:", error);
    return "Sorry, I'm unable to process your request right now.";
  }
}

async function messageHandler() {
  const userMessage = chatInput.value.trim();
  if (!userMessage) return;

  chatBox.innerHTML += `<p>You: ${userMessage}</p>`;
  chatInput.value = "";

  try {
    const aiResponse = await getAIResponse(userMessage);
    chatBox.innerHTML += `<p>Bot: ${aiResponse}</p>`;
    chatBox.scrollTop = chatBox.scrollHeight;
  } catch (error) {
    chatBox.innerHTML += "<p>Bot: Sorry, I encountered an error.</p>";
    console.error("API Error:", error);
  }
}
