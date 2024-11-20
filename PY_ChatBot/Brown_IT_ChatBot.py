import nltk
from nltk.chat.util import Chat, reflections
import mysql.connector
import spacy
import tkinter as tk
from tkinter.scrolledtext import ScrolledText
from PIL import Image, ImageTk
import webbrowser
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

# Fetch detailed course information
def get_course_details(course_code):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name, description, prerequisites FROM courses WHERE code = %s", (course_code,))
    course_details = cursor.fetchone()
    conn.close()
    return course_details

# Fetch faculty from the database
def get_faculty():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT name, specialization, bio FROM faculty")
    faculty = cursor.fetchall()
    conn.close()
    return faculty

# Fetch degree information from the database
def get_degree_info():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT degreecode, shortdescription, longdescription FROM degrees")
    degrees = cursor.fetchall()
    conn.close()
    return degrees

# Analyze user intent
def analyze_intent(user_input):
    doc = nlp(user_input)
    entities = {ent.label_: ent.text for ent in doc.ents}
    return entities

# Define pairs of patterns and responses
pairs = [
    [r"Hi|Hello|Hey", ["Hello! How can I assist you with the School of Information Technology today?"]],
    [r"What is Information Technology\??|What is IT\??", ["Information Technology (IT) involves the use of computers, storage, networking, and other physical devices, infrastructure, and processes to create, process, store, secure, and exchange all forms of electronic data."]],
    [r"Tell me about courses|What kind of courses do you offer\??", [f"Our courses include: {', '.join([f'{course[1]} ({course[0]})' for course in get_courses()])}. What specific course are you interested in?"]],
    [r"Tell me about faculty", [f"Our faculty includes: {', '.join([f'{faculty[0]} ({faculty[1]})' for faculty in get_faculty()])}. Would you like more details about a specific faculty member?"]],
    [r"How do I apply\??|How can I apply\??", ["You can apply online through our official website. Make sure to check the application deadlines and requirements: https://www.ivytech.edu/apply-now/"]],
    [r"What's the schedule\??|What's happening\??|What's coming up\??", ["You can find the schedule on our official website under the 'Courses' section: https://www.ivytech.edu/schedule/"]],
    [r"Goodbye|Bye|Later|Peace", ["Goodbye! Feel free to ask if you need anything else."]],
    [r"Help|I don't understand", ["Sure! You can ask me about courses, faculty, application process, schedule, or anything else related to the School of Information Technology."]],
    [r"Default response", ["I'm sorry, I didn't understand that. Can you please rephrase?"]],
    [r"What's the tuition fee\??|How much will it cost\??", ["The tuition fee details can be found here: https://www.ivytech.edu/tuition/"]],
    [r"What financial aid options are available\??", ["We offer various financial aid options including scholarships, grants, and loans. You can find more details here: https://www.ivytech.edu/financial-aid/"]],
    [r"Tell me about student services", ["Our student services include advising, career coaching, tutoring, disability support, and public safety. For more information, visit: https://www.ivytech.edu/student-services/"]],
    [r"Where can I find library resources\??", ["You can access library resources, including online libraries and research databases, through our library's website: https://www.ivytech.edu/library/"]],
    [r"What's the campus life like\??", ["Campus life includes student organizations, events, leadership training, and recreational activities. You can find more information here: https://www.ivytech.edu/campus-life/"]],
    [r"How do I get technical support\??", ["For technical support, you can contact our IT help desk or visit: https://www.ivytech.edu/technical-support/"]],
    [r"What are the academic policies\??", ["Academic policies, including grading policies, academic probation, and graduation requirements, can be found in the student handbook available here: https://www.ivytech.edu/academic-policies/"]],
    [r"Tell me about health and wellness services", ["We offer various health and wellness services including mental health support, counseling, and wellness programs. More details are available here: https://www.ivytech.edu/health-wellness/"]],
    [r"What career services are available\??", ["Our career services include job placement assistance, resume and interview workshops, and career fairs. Visit our career services page for more information: https://www.ivytech.edu/career-services/"]],
    [r"How can I transfer credits\??|Can I transfer my credits\??", ["You can transfer credits by following the transfer pathways and articulation agreements available here: https://www.ivytech.edu/transfer-credits/"]]
]

# Create chatbot
class SchoolOfITChatbot:
    def __init__(self, root):
        self.chatbot = Chat(pairs, reflections)
        self.setup_gui(root)

    def setup_gui(self, root):
        root.title("#IvyTechProud")

        # Create a frame for the top section
        top_frame = tk.Frame(root)
        top_frame.grid(row=0, column=0, columnspan=2, pady=10)

        # Load and resize robot image
        self.robot_image = Image.open("robot1.png").resize((64, 64), Image.LANCZOS)
        self.robot_photo = ImageTk.PhotoImage(self.robot_image)
        self.logo_label = tk.Label(top_frame, image=self.robot_photo)
        self.logo_label.pack(side=tk.LEFT, padx=10)

        # Add title label next to the image
        self.title_label = tk.Label(top_frame, text="School of IT Chatbot", font=("Helvetica", 16))
        self.title_label.pack(side=tk.LEFT, padx=10)
        #scrollbar
        self.text_area = ScrolledText(root, wrap='word', state='disabled', width=60, height=20)
        self.text_area.grid(row=1, column=0, columnspan=2, padx=10, pady=10)
        #configure link clicking
        self.text_area.tag_configure("link", foreground="blue", underline=True)
        self.text_area.tag_bind("link", "<Button-1>", self.open_link)
        
        self.entry = tk.Entry(root, width=50)
        self.entry.grid(row=2, column=0, padx=10, pady=10)
        self.entry.bind("<Return>", self.send_message)
        #bind return to send button click
        self.send_button = tk.Button(root, text="Send", command=self.send_message)
        self.send_button.grid(row=2, column=1, padx=10, pady=10)

    #open link fron chatbot    
    def open_link(self, event):
        index = self.text_area.index("@%d,%d" % (event.x, event.y))
        link_start = self.text_area.tag_prevrange("link", index)
        link = self.text_area.get(link_start[0], link_start[1])
        webbrowser.open_new(link)


    #sending message function    
    def send_message(self, event=None):
        user_input = self.entry.get()
        if user_input.lower() == 'exit':
            self.text_area.config(state='normal')
            self.text_area.insert(tk.END, "Goodbye!\n")
            self.text_area.config(state='disabled')
            self.entry.delete(0, tk.END)
            return
        #you: format
        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, f"YOU: {user_input}\n")
        self.text_area.config(state='disabled')
        #Bot: format
        response = self.chatbot.respond(user_input)
        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, "BOT: ", "bold") 
        self.text_area.tag_configure("bold", font=("Helvetica", 10, "bold"))

        #search for links
        words = response.split()
        for word in words:
            if word.startswith("http"):
                start_index = self.text_area.index(tk.END)
                self.text_area.insert(tk.END, word, "link")
                end_index = self.text_area.index(tk.END)
                self.text_area.tag_add("link", start_index, end_index)
            else:
                self.text_area.insert(tk.END, word)
            self.text_area.insert(tk.END, " ")

        self.text_area.insert(tk.END, "\n")
        self.text_area.config(state='disabled')

        self.entry.delete(0, tk.END)

def main():
    root = tk.Tk()
    app = SchoolOfITChatbot(root)
    root.mainloop()

if __name__ == "__main__":
    main()
