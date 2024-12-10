import nltk
from nltk.chat.util import Chat, reflections
import mysql.connector
import spacy
import tkinter as tk
from tkinter.scrolledtext import ScrolledText
from PIL import Image, ImageTk
import webbrowser, re
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
intents = {
    "greeting": ["Hello! How can I assist you with the School of Information Technology today?"],
    "information_technology": ["Information Technology (IT) involves the use of computers, storage, networking, and other physical devices, infrastructure, and processes to create, process, store, secure, and exchange all forms of electronic data."],
    "courses": [f"Our courses include: {', '.join([f'{course[1]} ({course[0]})' for course in get_courses()])}. What specific course are you interested in?"],
    "faculty": [f"Our faculty includes: {', '.join([f'{faculty[0]} ({faculty[1]})' for faculty in get_faculty()])}. Would you like more details about a specific faculty member?"],
    "apply": ["You can apply online through our official website. Make sure to check the application deadlines and requirements: https://www.ivytech.edu/apply-now/"],
    "schedule": ["You can find the schedule on our official website under the 'Courses' section: https://www.ivytech.edu/schedule/"],
    "tuition_fee": ["The tuition fee details can be found here: https://www.ivytech.edu/tuition/"],
    "financial_aid": ["We offer various financial aid options including scholarships, grants, and loans. You can find more details here: https://www.ivytech.edu/financial-aid/"],
    "student_services": ["Our student services include advising, career coaching, tutoring, disability support, and public safety. For more information, visit: https://www.ivytech.edu/student-services/"],
    "library_resources": ["You can access library resources, including online libraries and research databases, through our library's website: https://www.ivytech.edu/library/"],
    "campus_life": ["Campus life includes student organizations, events, leadership training, and recreational activities. You can find more information here: https://www.ivytech.edu/campus-life/"],
    "technical_support": ["For technical support, you can contact our IT help desk or visit: https://www.ivytech.edu/technical-support/"],
    "academic_policies": ["Academic policies, including grading policies, academic probation, and graduation requirements, can be found in the student handbook available here: https://www.ivytech.edu/academic-policies/"],
    "health_wellness": ["We offer various health and wellness services including mental health support, counseling, and wellness programs. More details are available here: https://www.ivytech.edu/health-wellness/"],
    "career_services": ["Our career services include job placement assistance, resume and interview workshops, and career fairs. Visit our career services page for more information: https://www.ivytech.edu/career-services/"],
    "transfer_credits": ["You can transfer credits by following the transfer pathways and articulation agreements available here: https://www.ivytech.edu/transfer-credits/"],
    "programming_languages": ["Our IT courses cover various programming languages including Python, Java, C++, and JavaScript."],
    "online_courses": ["Yes, we offer a variety of online courses. You can find more information on our online course offerings here: https://www.ivytech.edu/online/"],
    "campus_tour": ["Yes, you can schedule a campus tour through our admissions office or visit: https://www.ivytech.edu/campus-tours/"],
    "student_email": ["You can access your student email through the student portal. Instructions are available here: https://www.ivytech.edu/student-email/"],
    "internship_opportunities": ["Internship opportunities are available through our career services. You can find more information here: https://www.ivytech.edu/internships/"],
    "student_organizations": ["You can join student organizations by visiting our student life page and contacting the organization you're interested in: https://www.ivytech.edu/student-organizations/"],
    "study_abroad": ["Yes, we offer study abroad programs. You can find more information here: https://www.ivytech.edu/study-abroad/"],
    "learning_management_system": ["You can access the learning management system (LMS) through the student portal. Instructions are available here: https://www.ivytech.edu/lms/"],
    "academic_calendar": ["The academic calendar is available on our website here: https://www.ivytech.edu/academic-calendar/"],
    "request_transcripts": ["You can request your transcripts through the registrar's office or online here: https://www.ivytech.edu/transcripts/"],
    "it_certifications": ["Yes, we offer various IT certifications. You can find more information here: https://www.ivytech.edu/it-certifications/"],
    "student_portal": ["You can access the student portal here: https://www.ivytech.edu/student-portal/"],
    "graduation_information": ["Information about graduation, including requirements and ceremony details, can be found here: https://www.ivytech.edu/graduation/"]
}

def get_response(user_input):
    entities = analyze_intent(user_input)
    
    # Check for greetings
    if re.search(r"\b(hi|hello|hey)\b", user_input.lower()):
        return intents["greeting"][0]
    
    # Check for other intents
    if "information technology" in user_input.lower() or "it" in user_input.lower():
        return intents["information_technology"][0]
    elif "courses" in user_input.lower():
        return intents["courses"][0]
    elif "faculty" in user_input.lower():
        return intents["faculty"][0]
    elif "apply" in user_input.lower():
        return intents["apply"][0]
    elif "schedule" in user_input.lower():
        return intents["schedule"][0]
    elif "tuition fee" in user_input.lower() or "cost" in user_input.lower():
        return intents["tuition_fee"][0]
    elif "financial aid" in user_input.lower():
        return intents["financial_aid"][0]
    elif "student services" in user_input.lower():
        return intents["student_services"][0]
    elif "library resources" in user_input.lower():
        return intents["library_resources"][0]
    elif "campus life" in user_input.lower():
        return intents["campus_life"][0]
    elif "technical support" in user_input.lower():
        return intents["technical_support"][0]
    elif "academic policies" in user_input.lower():
        return intents["academic_policies"][0]
    elif "health and wellness" in user_input.lower():
        return intents["health_wellness"][0]
    elif "career services" in user_input.lower():
        return intents["career_services"][0]
    elif "transfer credits" in user_input.lower():
        return intents["transfer_credits"][0]
    elif "programming languages" in user_input.lower():
        return intents["programming_languages"][0]
    elif "online courses" in user_input.lower():
        return intents["online_courses"][0]
    elif "campus tour" in user_input.lower():
        return intents["campus_tour"][0]
    elif "student email" in user_input.lower():
        return intents["student_email"][0]
    elif "internship opportunities" in user_input.lower():
        return intents["internship_opportunities"][0]
    elif "student organizations" in user_input.lower():
        return intents["student_organizations"][0]
    elif "study abroad" in user_input.lower():
        return intents["study_abroad"][0]
    elif "learning management system" in user_input.lower():
        return intents["learning_management_system"][0]
    elif "academic calendar" in user_input.lower():
        return intents["academic_calendar"][0]
    elif "request transcripts" in user_input.lower():
        return intents["request_transcripts"][0]
    elif "it certifications" in user_input.lower():
        return intents["it_certifications"][0]
    elif "student portal" in user_input.lower():
        return intents["student_portal"][0]
    elif "graduation information" in user_input.lower():
        return intents["graduation_information"][0]
    else:
        return "I'm sorry, I didn't understand that. Can you please rephrase?"
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
    [r"How can I transfer credits\??|Can I transfer my credits\??", ["You can transfer credits by following the transfer pathways and articulation agreements available here: https://www.ivytech.edu/transfer-credits/"]],
    [r"What programming languages will I learn\??", ["Our IT courses cover various programming languages including Python, Java, C++, and JavaScript."]],
    [r"Are there any online courses available\??", ["Yes, we offer a variety of online courses. You can find more information on our online course offerings here: https://www.ivytech.edu/online/"]],
    [r"Can I get a tour of the campus\??", ["Yes, you can schedule a campus tour through our admissions office or visit: https://www.ivytech.edu/campus-tours/"]],
    [r"How do I access my student email\??", ["You can access your student email through the student portal. Instructions are available here: https://www.ivytech.edu/student-email/"]],
    [r"Where can I find internship opportunities\??", ["Internship opportunities are available through our career services. You can find more information here: https://www.ivytech.edu/internships/"]],
    [r"How do I join student organizations\??", ["You can join student organizations by visiting our student life page and contacting the organization you're interested in: https://www.ivytech.edu/student-organizations/"]],
    [r"Are there any study abroad programs\??", ["Yes, we offer study abroad programs. You can find more information here: https://www.ivytech.edu/study-abroad/"]],
    [r"How do I access the learning management system\??", ["You can access the learning management system (LMS) through the student portal. Instructions are available here: https://www.ivytech.edu/lms/"]],
    [r"Where can I find the academic calendar\??", ["The academic calendar is available on our website here: https://www.ivytech.edu/academic-calendar/"]],
    [r"How do I request my transcripts\??", ["You can request your transcripts through the registrar's office or online here: https://www.ivytech.edu/transcripts/"]],
    [r"Are there any IT certifications available\??", ["Yes, we offer various IT certifications. You can find more information here: https://www.ivytech.edu/it-certifications/"]],
    [r"How do I access the student portal\??", ["You can access the student portal here: https://www.ivytech.edu/student-portal/"]],
    [r"Where can I find information about graduation\??", ["Information about graduation, including requirements and ceremony details, can be found here: https://www.ivytech.edu/graduation/"]]
]

# Create chatbot
class SchoolOfITChatbot:
    def __init__(self, root):
        self.chatbot = Chat(pairs, reflections)
        self.setup_gui(root)

    def setup_gui(self, root):
        root.title("School of IT Chatbot")
        root.configure(background="#006648")

        # Create a frame for the top section
        top_frame = tk.Frame(root, bg="#006648")
        top_frame.grid(row=0, column=0, columnspan=2, pady=10)

        # Load and resize Ivy Tech logo image
        self.logo_image = Image.open("ivy_tech_logo.png").resize((450, 128), Image.LANCZOS)
        self.logo_photo = ImageTk.PhotoImage(self.logo_image)
        self.logo_label = tk.Label(top_frame, image=self.logo_photo, bg="#006648")
        self.logo_label.pack(side=tk.LEFT, padx=10)

        # Create a scrolled text widget for the chat display
        self.text_area = ScrolledText(root, wrap='word', state='disabled', width=60, height=20, bg="#ffffff", fg="#000000")
        self.text_area.grid(row=1, column=0, columnspan=2, padx=10, pady=10)
       # Configure tags for user and bot messages
        self.text_area.tag_configure("user", background="#d1e7dd", foreground="#000000", lmargin1=10, lmargin2=10, rmargin=10, spacing1=5, spacing3=5)
        self.text_area.tag_configure("bot", background="#006648", foreground="#ffffff", lmargin1=10, lmargin2=10, rmargin=10, spacing1=5, spacing3=5)
        #configure link clicking
        self.text_area.tag_configure("link", foreground="blue", underline=True)
        self.text_area.tag_bind("link", "<Button-1>", self.open_link)
        #configure an entry for user input
        self.entry = tk.Entry(root, width=50, bg="#ffffff", fg="#000000")
        self.entry.grid(row=2, column=0, padx=10, pady=10)
        self.entry.bind("<Return>", self.send_message)
        #bind return to send button click
        self.send_button = tk.Button(root, text="Send", command=self.send_message, bg="#4CAF50", fg="#ffffff")
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
            self.text_area.insert(tk.END, "Goodbye!\n", "user")
            self.text_area.config(state='disabled')
            self.entry.delete(0, tk.END)
            return

        # You: format
        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, f"YOU: {user_input}\n", "user")
        self.text_area.config(state='disabled')

        # Bot: format
        response = get_response(user_input)
        self.text_area.config(state='normal')
        self.text_area.insert(tk.END, f"BOT: {response}\n", "bot")
        self.text_area.config(state='disabled')
        self.entry.delete(0, tk.END)
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
    root.grid_rowconfigure(0, weight=1)
    root.grid_columnconfigure(0, weight=1)
    root.mainloop()

if __name__ == "__main__":
    main()
