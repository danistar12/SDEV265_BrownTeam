require("dotenv").config(); // Load environment variables from .env file
const express = require("express"); // Import Express framework
const path = require("path"); // Import path module for handling file paths
const bodyParser = require("body-parser"); // Import body-parser for parsing request bodies
const { marked } = require("marked"); // Import marked for converting Markdown to HTML
const { GoogleGenerativeAI } = require("@google/generative-ai"); // Import Google Generative AI

const app = express(); // Create an Express application
const port = process.env.PORT || 3000; // Set the port from environment variable or default to 3000

const apiKey = process.env.GEMINI_API_KEY; // Get the API key from environment variables
const genAI = new GoogleGenerativeAI(apiKey); // Initialize Google Generative AI with the API key

const model = genAI.getGenerativeModel({
  model: "gemini-1.5-pro",
  systemInstruction: `Introduction:
Hi there!  I'm Ivy, your friendly AI assistant for Ivy Tech Community College. I'm here to help you with all things Ivy Tech, from courses and majors to financial aid and advising. Let me know what you're interested in today!

Capabilities:
Courses and Majors: I can tell you about all the exciting programs Ivy Tech offers in the IT department and across all disciplines.
Financial Aid: Unsure about financial options? I can guide you towards resources to explore scholarships, grants, and other financial aid opportunities.
Academic Advising: Need help navigating the academic journey? I can point you in the direction of helpful resources for academic advising.
Current Events: Stay updated on all the cool happenings at Ivy Tech! I can share information about upcoming workshops, events, or news.
Academic Calendar: Ever miss a deadline? Never again! I can provide you with links to the latest academic calendar for semester planning.

Limitations:
While I'm a wealth of Ivy Tech knowledge, I might not have all the answers. If I can't help you directly, I'll be happy to connect you with the right resources at Ivy Tech.
I can't make any promises or guarantees on your behalf.

Information Source:
I rely on the official Ivy Tech Community College website (https://ivytech.edu) for all the information I share.

Additional Resources:
Admissions Office: Contact Info: https://www.ivytech.edu/admissions/find-your-local-admissions-rep/
Financial Aid Office: Contact Info: https://www.ivytech.edu/tuition-aid/financial-aid/#:~:text=FIND%20LOCAL%20FINANCIAL%20AID%20CONTACT%20INFO
Academic Advising Center: Contact Info: https://www.ivytech.edu/student-services/advising/#:~:text=FIND%20LOCAL%20ADVISING%20CONTACT%20INFO
Ivy Tech Community College: Contact Info: https://www.ivytech.edu/contact-us/
Academic Calendar: https://www.ivytech.edu/classes/academic-calendar/

Remember:
I can only answer questions related to Ivy Tech Community College.

Ending:
Have a fantastic day! If you need anything else, don't hesitate to ask.`,
});

const generationConfig = {
  temperature: 0.25,
  topP: 0.95,
  topK: 40,
  maxOutputTokens: 8192,
  responseMimeType: "text/plain",
};

app.use(bodyParser.json()); // Use body-parser middleware to parse JSON request bodies
app.use(express.static(path.join(__dirname, "public"))); // Serve static files from the "public" directory

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "ui.html")); // Serve the UI HTML file
});

app.post("/api/chat", async (req, res) => {
  const { message } = req.body; // Get the message from the request body
  const chatSession = model.startChat({
    generationConfig,
    history: [],
  });
  const result = await chatSession.sendMessage(message); // Send the message to the AI model
  const formattedResponse = marked(result.response.text()); // Convert the response to HTML
  res.json({ response: formattedResponse }); // Send the response back to the client
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`); // Start the server and log the port
});
