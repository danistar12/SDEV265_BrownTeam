document
  .getElementById("chat-form")
  .addEventListener("submit", async function (e) {
    e.preventDefault();
    const userInput = document.getElementById("user-input");
    const chatbox = document.getElementById("chatbox");

    const userMessageEl = document.createElement("div");
    userMessageEl.innerHTML = `
                <p style="text-align: right; margin-bottom: 10px;">
                    <strong>You:</strong> ${userInput.value}
                </p>
            `;
    chatbox.appendChild(userMessageEl);

    const response = await fetch("/api/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ message: userInput.value }),
    });
    const data = await response.json();

    const botMessageEl = document.createElement("div");
    botMessageEl.innerHTML = `
                <p style="text-align: left; margin-bottom: 10px;">
                    <strong>Chatbot:</strong> ${data.response}
                </p>
            `;
    chatbox.appendChild(botMessageEl);

    chatbox.scrollTop = chatbox.scrollHeight;
    userInput.value = "";
  });
