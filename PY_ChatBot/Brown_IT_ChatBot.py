import nltk
from nltk.chat.util import Chat, reflections
import mysql.connector
import spacy
import tkinter as tk
from tkinter import messagebox

# Load spaCy model
nlp = spacy.load("en_core_web_sm")

# Connect to MySQL database
def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="DaniStar!12",
        database="School_of_IT"
    )

# Fetch courses from the database
def get_courses():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT code, name, description FROM courses")
    courses = cursor.fetchall()
    conn.close()
    return courses

# Fetch faculty from the database
def get_faculty():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name, specialization, bio FROM faculty")
    faculty = cursor.fetchall()
    conn.close()
    return faculty

# Define pairs of patterns and responses
pairs = [
    [r"Hi|Hello|Hey", ["Hello! How can I assist you with the School of Information Technology today?"]],
    [r"What is Information Technology?", ["Information Technology (IT) involves the use of computers, storage, networking, and other physical devices, infrastructure, and processes to create, process, store, secure, and exchange all forms of electronic data."]],
    [r"Tell me about courses", [f"Our courses include: {', '.join([f'{course[1]} ({course[0]})' for course in get_courses()])}. What specific course are you interested in?"]],
    [r"Tell me about faculty", [f"Our faculty includes: {', '.join([f'{faculty[0]} ({faculty[1]})' for faculty in get_faculty()])}. Would you like more details about a specific faculty member?"]],
    [r"How do I apply?", ["You can apply online through our official website. Make sure to check the application deadlines and requirements."]],
    [r"What's the schedule?", ["You can find the schedule on our official website under the 'Courses' section. Are you looking for a specific course schedule?"]],
    [r"Goodbye|Bye", ["Goodbye! Feel free to ask if you need anything else."]],
    [r"Help", ["Sure! You can ask me about courses, faculty, application process, schedule, or anything else related to the School of Information Technology."]],
    [r"Default response", ["I'm sorry, I didn't understand that. Can you please rephrase?"]]
]

# Create chatbot
class SchoolOfITChatbot:
    def __init__(self, root):
        self.chatbot = Chat(pairs, reflections)
        self.setup_gui(root)

    def setup_gui(self, root):
        root.title("School of IT Chatbot")

        self.text_area = tk.Text(root, wrap='word', state='disabled', width=60, height=20)
        self.text_area.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

        self.entry = tk.Entry(root, width=50)
        self.entry.grid(row=1, column=0, padx=10, pady=10)

        self.send_button = tk.Button(root, text="Send", command=self.send_message)
        self.send_button.grid(row=1, column=1, padx=10, pady=10)

    def send_message(self):
        user_input = self.entry.get()
        if user_input.lower() == 'exit':
            self.text_area.config(state='normal')
            self.text_area.insert(tk.END, "Goodbye!\n")
            self.text_area.config(state='disabled')
            self.entry.delete(0, tk.END)
            return

        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, f"You: {user_input}\n")
        self.text_area.config(state='disabled')

        response = self.chatbot.respond(user_input)
        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, f"Bot: {response}\n")
        self.text_area.config(state='disabled')

        self.entry.delete(0, tk.END)

def main():
    root = tk.Tk()
    app = SchoolOfITChatbot(root)
    root.mainloop()

if __name__ == "__main__":
    main()
