-- Drop the existing database and create a new one
DROP DATABASE IF EXISTS `School_of_IT`;
CREATE DATABASE `School_of_IT`;
USE `School_of_IT`;

-- Create the programs table
CREATE TABLE programs (
    code VARCHAR(4) PRIMARY KEY,
    description VARCHAR(40),
    shortdescription VARCHAR(150),
    longdescription TEXT
);

-- Create the degrees table
CREATE TABLE degrees (
    degreecode VARCHAR(10) PRIMARY KEY,
    shortdescription VARCHAR(40),
    longdescription TEXT
);

-- Create the courses table with additional information
CREATE TABLE courses (
    code VARCHAR(7) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    syllabus TEXT,
    prerequisites VARCHAR(100),
    registration_details TEXT
);

-- Create the faculty table
CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    title VARCHAR(20),
    specialization VARCHAR(70),
    bio TEXT
);

-- Adding indexes for better performance
CREATE INDEX idx_course_name ON courses(name);
CREATE INDEX idx_faculty_name ON faculty(name);

-- Insert data into programs table
INSERT INTO programs (code, description, shortdescription, longdescription)
VALUES
('CLDT', 'Cloud Technologies', 'Covers essential internet-based platforms such as Amazon Web Services (AWS) and Microsoft Azure.', CONCAT(
    'Cloud refers to the software and services that run on the Internet, instead of locally on your computer. Today, the very websites', CHAR(13), CHAR(10),
    'you visit, the photos you take on your phone, the data you access to register for courses or to buy those household items online', CHAR(13), CHAR(10),
    'is likely stored in "the Cloud." No, the Cloud is not a group of fluffy cumulous shapes in the sky.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'The Cloud is composed of a network of servers that compose the internet. Fortune 500 companies across the United States and', CHAR(13), CHAR(10),
    'globally are investing billions of dollars to adopt Cloud platforms as part of their digital transformation. In fact, Gartner, the world’s', CHAR(13), CHAR(10),
    'leading research and advisory company, forecasts that global spend for Cloud in 2021 will exceed $308 billion dollars. This', CHAR(13), CHAR(10),
    'growth is eclipsed by the lack of Cloud talent in industry.  The Ivy Tech Cloud Technologies program is dedicated to provide', CHAR(13), CHAR(10),
    'students with the skills required to meet the growing demand for Cloud talent. Students will develop foundational skills in system', CHAR(13), CHAR(10),
    'administration that will translate to a wide variety of business scenarios.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'Our graduates are skilled in developing and maintaining multi-user computer systems for business, from small organizations to', CHAR(13), CHAR(10),
    'large enterprises. Students will learn how to unpack complex problems and systems and learn how modern organizations are', CHAR(13), CHAR(10),
    'dealing with ever changing infrastructure. Students will learn about popular Cloud platforms such as Amazon Web Services', CHAR(13), CHAR(10),
    '(AWS) and Microsoft Azure.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'Additionally, as a Cloud Technologies major you have the opportunity to earn the CompTIA A+, Security+, and Network+, A Cloud', CHAR(13), CHAR(10),
    'Practitioner, and AWS Solutions Architect certifications. These certifications are currency to help you land a great job in Cloud', CHAR(13), CHAR(10),
    'while being exposed to groundbreaking technologies, attacking the issues facing Fortune 500 companies and small businesses', CHAR(13), CHAR(10),
    'alike.')),
('CSCI', 'Computer Science', 'Provides foundational knowledge in programming, software development, and critical thinking for various organizations.', CONCAT(
    'The career field of computer science has consistently ranked toward the top in job satisfaction and salary over the last 20 years.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'Computer Science is an exciting field that explores the limits of what computers can accomplish. It also spans many restraints', CHAR(13), CHAR(10),
    'and sectors of our economy, including science and research, industry, business and military. Coursework can include', CHAR(13), CHAR(10),
    'implementing and understanding properties of algorithms as well as discussing the social content of computing. This includes', CHAR(13), CHAR(10),
    'the history and evolution of machines, social impact of computers, and the code of ethics. A computer scientist can expect to', CHAR(13), CHAR(10),
    'enjoy a good salary, steady work, and opportunities to advance. Students in the computer science program should be ones that', CHAR(13), CHAR(10),
    'enjoy math, science, problem solving as well as new challenges.')),
('CSIA', 'Cyber Security / Information Assurance','A nationally recognized program focusing on securing computers, networks, and critical infrastructure.', CONCAT(
    'Ivy Tech Community College created the Center for Cyber Security to meet the demands for high-quality cyber security', CHAR(13), CHAR(10),
    'education and training. Through our nationally recognized center, Ivy Tech students receive the education and training they', CHAR(13), CHAR(10),
    'need for jobs that secure our community, state and nation’s computers, networks and critical infrastructure.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'The program will build the foundationto identify and fix computer security attacks. The material covered in the program is', CHAR(13), CHAR(10),
    'designed for students with, advanced computer or currently working in the computer industry. Cyber Security is a', CHAR(13), CHAR(10), 
    'degree that can be applied to many facets of the student’s life, from personal to work experiences. There is a growing need for', CHAR(13), CHAR(10),
    'stronger Cyber Security with the increasing media attention.', CHAR(13), CHAR(10),
    CHAR(13), CHAR(10),
    'The quality of Ivy Tech’s programs is recognized by several governmental entities, attesting to the quality of the curriculum,', CHAR(13), CHAR(10),
    'instruction and administrative support.')),
('DATA', 'Data Analytics', 'Teaches essential skills for extracting and analyzing data using tools like data mining and statistical analysis.', CONCAT(
    'Data Analytics involves examining raw data sets in order to find trends and answer questions. It is a crucial field as it helps', CHAR(13), CHAR(10),
    'businesses make informed decisions by providing insights that lead to action. Students in this program learn about data', CHAR(13), CHAR(10),
    'collection, processing, and analysis using various tools and techniques. This includes understanding the principles of statistics,', CHAR(13), CHAR(10),
    'machine learning, and data visualization. The knowledge and skills gained from this program are applicable in a wide range of', CHAR(13), CHAR(10),
    'industries, making graduates highly valuable and versatile in the job market.')),
('INFM', 'Informatics', 'Focuses on applying IT to solve problems in various fields, covering information management, data analysis, and technology in business.', CONCAT(
    'Informatics is the study of how people interact with information and technology. This interdisciplinary field combines aspects', CHAR(13), CHAR(10),
    'of computer science, information science, and social science to address complex problems in various domains such as healthcare,', CHAR(13), CHAR(10),
    'business, and environmental science. The program equips students with skills in data management, system design, and user', CHAR(13), CHAR(10),
    'experience to effectively create and manage information systems that meet the needs of different stakeholders. Students will', CHAR(13), CHAR(10),
    'learn how to leverage technology to improve processes, make data-driven decisions, and enhance human-computer interactions.')),
('ITSP', 'Information Technology Support', 'Trains students to provide technical support, system maintenance, and customer service for IT help desk roles.', CONCAT(
    'Information Technology Support is critical for maintaining the technology infrastructure of an organization. This program', CHAR(13), CHAR(10),
    'prepares students to handle a variety of technical issues, from troubleshooting hardware and software problems to providing', CHAR(13), CHAR(10),
    'customer service and support. Students will gain hands-on experience with common IT tools and technologies, learning how to', CHAR(13), CHAR(10),
    'diagnose and resolve technical issues quickly and efficiently. The curriculum also covers essential skills such as communication,', CHAR(13), CHAR(10),
    'teamwork, and problem-solving, which are crucial for success in IT support roles.')),
('NETI', 'Network Infrastructure', 'Provides training in designing, implementing, and managing computer networks.', CONCAT(
    'Network Infrastructure involves the hardware and software resources that enable network connectivity, communication, and', CHAR(13), CHAR(10),
    'management of an enterprise network. This program covers the fundamentals of network design, implementation, and', CHAR(13), CHAR(10),
    'maintenance, including topics such as routing, switching, and network security. Students will learn how to build and manage', CHAR(13), CHAR(10),
    'robust and secure networks that meet the needs of modern businesses. The skills gained in this program are essential for network', CHAR(13), CHAR(10),
    'administrators, engineers, and other IT professionals responsible for ensuring the reliability and performance of network', CHAR(13), CHAR(10),
    'systems.')),
('SDEV', 'Software Development', 'Focuses on developing software skills, covering areas like web development, databases, and mobile applications.', CONCAT(
    'Software Development is a dynamic and ever-evolving field that involves creating and maintaining software applications.', CHAR(13), CHAR(10),
    'This program provides a comprehensive understanding of the software development lifecycle, from requirement analysis and', CHAR(13), CHAR(10),
    'design to coding, testing, and deployment. Students will learn various programming languages, development frameworks,', CHAR(13), CHAR(10),
    'and tools used in the industry. The curriculum also emphasizes best practices in software engineering, such as version control,', CHAR(13), CHAR(10),
    'agile methodologies, and project management. Graduates of this program will be well-equipped to pursue careers as software', CHAR(13), CHAR(10),
    'developers, web developers, mobile app developers, and more. They will be prepared to tackle complex software challenges and', CHAR(13), CHAR(10),
    'contribute to innovative projects across various sectors including technology, finance, healthcare, and entertainment.', CHAR(13), CHAR(10),
    'The program also fosters strong problem-solving skills and encourages continuous learning to stay abreast of emerging technologies and trends in the software development industry.'
));

-- Complete list of courses
INSERT INTO courses (code, name, description, prerequisites)
VALUES
('CSCI101', 'Computer Science I', 'Introduction to the fundamental concepts of computer science.', 'None'),
('SDEV140', 'Introduction to Software Development', 'Introduction to the basics of software development.', 'None'),
('CSCI179', 'Computer Science Bridging Course', 'A bridging course for students to transition into computer science.', 'None'),
('CSCI201', 'Computer Science II', 'Continuation of Computer Science I, focusing on advanced topics.', 'CSCI101'),
('CSCI105', 'Discrete Logic for Computers', 'Study of discrete mathematics and logic as applied to computer science.', 'None'),
('CSCI202', 'Data Structures', 'Introduction to data structures and their applications.', 'CSCI101'),
('CSCI210', 'Database Systems', 'Fundamentals of database design and implementation.', 'None'),
('INFM109', 'Informatics Fundamentals', 'Introduction to the basic concepts of informatics.', 'None'),
('SDEV120', 'Computing Logic', 'Introduction to the principles of computing logic.', 'None'),
('SDEV265', 'Systems/Software Analysis and Projects', 'Comprehensive study of systems and software analysis through projects.', 'SDEV140'),
('DBMS110', 'Introduction to Data Analytics', 'Introduction to the fundamental concepts and techniques of data analytics.', 'None'),
('DBMS130', 'Data Management using Structured Query Language', 'Fundamentals of data management using SQL.', 'None'),
('DBMS160', 'Data Visualization and Analysis', 'Techniques for visualizing and analyzing data.', 'None'),
('DBMS260', 'Advanced Data Analytics', 'Advanced techniques and methods in data analytics.', 'DBMS110'),
('CPIN239', 'Systems Analysis and Design', 'Study of methodologies and techniques for systems analysis and design.', 'None'),
('CPIN269', 'Information Technology Project Management', 'Principles and practices of project management in IT.', 'None'),
('CPIN270', 'Workforce Preparation: Comptia Project + Certification', 'Preparation for CompTIA Project+ certification.', 'None'),
('CPIN279', 'Information Technology Capstone', 'Capstone course integrating knowledge from IT curriculum.', 'None'),
('CPIN280', 'Computing and Informatics CO-OP/Internship/Externship', 'Practical experience in computing and informatics through internships or externships.', 'None'),
('CPIN288', 'Advanced Special Topics in Computing and Informatics', 'Advanced topics in computing and informatics.', 'None'),
('CSIA105', 'Introduction to Cyber Security/Information Assurance', 'Introduction to the principles and practices of cybersecurity and information assurance.', 'None'),
('CSIA106', 'Workforce Preparation: CompTIA Security+ Certification', 'Preparation for CompTIA Security+ certification.', 'None'),
('CSIA115', 'Cyber Ops', 'Operations and strategies in cybersecurity.', 'None'),
('CSIA135', 'Digital Forensics', 'Principles and practices of digital forensics.', 'None'),
('CSIA210', 'Network Protocol Analysis', 'Analysis of network protocols.', 'None'),
('CSIA215', 'Perimeter Defense', 'Strategies and techniques for network perimeter defense.', 'None'),
('CSIA225', 'Ethical Hacking', 'Principles and techniques of ethical hacking.', 'None'),
('CSIA235', 'Advanced Digital Forensics', 'Advanced topics in digital forensics.', 'None'),
('CSIA245', 'Cryptography/Secure Coding Theory and Application', 'Principles and practices of cryptography and secure coding.', 'None'),
('CSIA260', 'Business Continuity in an Information World', 'Strategies for business continuity in IT.', 'None'),
('DBMSXXX', 'Data Analytics Elective', 'Elective course in the field of data analytics.', 'None'),
('DBMS230', 'Microsoft T-SQL Development', 'Development using Microsoft T-SQL.', 'None'),
('DBMS235', 'Oracle PL/SQL Development', 'Development using Oracle PL/SQL.', 'None'),
('INFM209', 'Informatics and Human-Computer Interaction', 'Principles of informatics and human-computer interaction.', 'None'),
('INFM219', 'Business Intelligence and Reporting', 'Introduction to business intelligence and reporting tools and techniques.', 'None'),
('INFM260', 'Salesforce Administration', 'Administration of Salesforce CRM.', 'None'),
('INFM261', 'Workforce Preparation: Salesforce Administrator Certification', 'Preparation for Salesforce Administrator certification.', 'None'),
('NETI101', 'Fundamentals of Networking', 'Fundamentals of computer networking.', 'Basic Computer Knowledge'),
('NETI104', 'Introduction to Networking', 'Basics of computer networking.', 'None'),
('NETI109', 'Networking I', 'Introduction to networking concepts and practices.', 'None'),
('NETI114', 'Workforce Preparation: CompTIA Network+ Certification', 'Preparation for CompTIA Network+ certification.', 'None'),
('NETI119', 'Networking II', 'Intermediate networking concepts and practices.', 'NETI109'),
('NETI120', 'Infrastructure Design - Logical and Physical', 'Designing logical and physical network infrastructure.', 'None'),
('NETI209', 'Networking III', 'Advanced networking concepts and practices.', 'NETI119'),
('NETI210', 'Network Security', 'Principles and practices of network security.', 'NETI109'),
('NETI216', 'Workforce Preparation: Interconnecting Cisco Networking Devices Part 2 (ICND2) Certification', 'Preparation for ICND2 certification.', 'None'),
('NETI217', 'Workforce Preparation: Cisco Certified Network Associate (CCNA) Certification', 'Preparation for CCNA certification.', 'None'),
('NETI218', 'Cisco Certified Network Associate v7 Bridging Content', 'Bridging content for CCNA v7 certification.', 'None'),
('NETI219', 'Workforce Preparation: Cisco Certified Network Associate (CCNA) Certification', 'Preparation for CCNA certification.', 'None'),
('NETI245', 'Voice over Internet Protocol', 'Principles and practices of VoIP.', 'None'),
('NETI250', 'Wireless LAN Networking', 'Principles and practices of wireless LAN networking.', 'None'),
('SDEV200', 'Software Development with Java', 'Introduction to software development with Java.', 'None'),
('SDEV210', 'Software Development using Visual Basic in the .NET Framework', 'Introduction to software development using Visual Basic in the .NET framework.', 'None'),
('SDEV220', 'Software Development Using Python', 'Software development principles and practices using Python.', 'None'),
('SDEV230', 'Software Development using C++', 'Introduction to software development using C++.', 'None'),
('SDEV240', 'Software Development Using C#', 'Introduction to software development using C#.', 'None'),
('SDEV245', 'Security and Secure Coding', 'Principles and practices of security and secure coding.', 'None'),
('SDEV248', 'Advanced Simulation and Game Design', 'Advanced topics in simulation and game design.', 'None'),
('SDEV250', 'Client-Side Scripting Languages and Tools', 'Introduction to client-side scripting languages and tools.', 'None'),
('SDEV253', 'Server-Side Scripting Languages and Tools', 'Introduction to server-side scripting languages and tools.', 'None'),
('SDEV255', 'Web Application Development', 'Principles and practices of web application development.', 'None'),
('SDEV257', 'Hybrid Apps and Frameworks', 'Development of hybrid applications and frameworks.', 'None'),
('SDEV260', 'iOS Swift Application Development', 'Introduction to iOS application development using Swift.', 'None'),
('SDEV264', 'Mobile Application Development', 'Principles and practices of mobile application development.', 'None'),
('SDEV265', 'Systems/Software Analysis and Projects', 'Comprehensive study of systems and software analysis through projects.', 'SDEV140'),
('SDEV266', 'Advanced iOS Swift Application Development', 'Advanced topics in iOS application development using Swift.', 'SDEV260'),
('SDEV268', 'Algorithms and Design Patterns', 'Introduction to algorithms and design patterns.', 'None'),
('SDEV270', 'Software Development Certification', 'Preparation for software development certification exams.', 'None'),
('SDEV271', 'Java Certification', 'Preparation for Java certification.', 'None'),
('SDEV272', 'Python Certification', 'Preparation for Python certification.', 'None'),
('SDEV273', 'C++ Certification', 'Preparation for C++ certification.', 'None'),
('SDEV274', 'C# Certification', 'Preparation for C# certification.', 'None'),
('SDEV275', 'Web Development Certification', 'Preparation for web development certification.', 'None'),
('SDEV276', 'Android App Development Certification', 'Preparation for Android app development certification.', 'None'),
('SDEV285', 'Advanced Special Topics in Software Development', 'Advanced topics in software development.', 'None'),
('SDEV143', 'Git Version Control Systems', 'Introduction to version control systems using Git.', 'None'),
('SDEV148', 'Introduction to Game Development', 'Introduction to game development principles and practices.', 'None'),
('SDEV153', 'Website Development', 'Fundamentals of website development.', 'None'),
('SDEV155', 'Content Management Systems', 'Introduction to content management systems.', 'None'),
('SVAD111', 'Linux and Virtualization Tech', 'Introduction to Linux and virtualization technologies.', 'None'),
('SVAD211', 'Virtualization and Storage', 'Principles and practices of virtualization and storage technologies.', 'None'),
('SVAD216', 'Linux Administration II', 'Advanced topics in Linux administration.', 'SVAD111');

-- Insert data into degrees table 
INSERT INTO degrees (degreecode, shortdescription, longdescription) 
VALUES 
('AAS', 'Associate of Applied Science', 'An academic degree that emphasizes practical, hands-on training in a specific field, preparing students directly for employment in technical or skilled occupations.'),
('AS', 'Associate of Science', 'An academic degree that provides a broad foundation in science and general education, preparing students for transfer to a four-year university or for entry-level positions in various scientific and technical fields.');
-- Insert data into faculty table
INSERT INTO faculty (name, title, specialization, bio)
VALUES
('Mr. Patrick Benner', 'Dean', 'Server Administration', 'Mr. Benner has 13 years of experience at Ivy Tech with specializations in Networking and Server Administration.'),
('Dr. Steve Carver', 'Department Chair', 'Computer Science and Software Engineering', 'Dr. Carver has 22 years of experience at Ivy Tech with specializations in Machine Learning, AI, and Quantum Information Science.'),
('Mr. Zach Hamby', 'Department Chair', 'Cloud Technologies, Full-Stack Development and Gaming Technologies', 'Mr. Hamby specializes in various development frameworks.'),
('Mr. Anthony Ford', 'Faculty', 'Cyber Security', 'Mr. Ford specializes in Information Security, Intrusion Detection, and Data Encryption / Decryption.'),
('Mr. Henry Davis', 'Faculty', 'Server Administration and Network Infrastructure', 'Mr. Davis specializes in Virtual Machining and Distributed Systems.'),
('Mrs. Dilara Askarova', 'Faculty', 'Database Management Systems', 'Mrs. Askarova specializes in Data Analytics and Database languages of MS Access, SQL, and Oracle.'),
('Mrs. Keneisha Etheridge', 'Faculty', 'Computer Science and Software Development', 'Mrs. Etheridge specializes in SDLC Methods of Agile and Waterfall, Python, and C++.'),
('Mrs. Nakia Williams', 'Faculty', 'Informatics and Software Development', 'Mrs. Williams specializes in Computing Logic and Data Information Science.');
