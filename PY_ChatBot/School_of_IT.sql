DROP DATABASE IF EXISTS `School_of_IT`;
CREATE DATABASE `School_of_IT`;
USE `School_of_IT`;

CREATE TABLE programs (
    code VARCHAR(4) PRIMARY KEY,
    description VARCHAR(40),
    shortdescription VARCHAR(150),
    longdescription TEXT
);

CREATE TABLE degrees (
    degreecode VARCHAR(10) PRIMARY KEY,
    shortdescription VARCHAR(40),
    longdescription TEXT
);

CREATE TABLE courses (
    code VARCHAR(7) PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    title VARCHAR(20),
    specialization VARCHAR(70),
    bio TEXT
);

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
('DATA', 'Data Analytics', 'Teaches essential skills for extracting and analyzing data using tools like data mining and statistical analysis.', ''),
('INFM', 'Informatics', 'Focuses on applying IT to solve problems in various fields, covering information management, data analysis, and technology in business.', ''),
('ITSP', 'Information Technology Support', 'Trains students to provide technical support, system maintenance, and customer service for IT help desk roles.', ''),
('NETI', 'Network Infrastructure', 'Provides training in designing, implementing, and managing computer networks.', ''),
('SDEV', 'Software Development', 'Focuses on developing software skills, covering areas like web development, databases, and mobile applications.', '');

INSERT INTO courses (code, description)
VALUES
('SDEV140', 'Introduction to programming using Python.'),
('NETI101', 'Fundamentals of computer networking.');

INSERT INTO faculty (name, title, specialization, bio)
VALUES
('Mr. Patrick Benner', 'Dean', 'Server Administration', 'Mr. Benner has 13 years of experience at Ivy Tech with specializations in Networking and Server Administration'),
('Dr. Steve Carver', 'Department Chair', 'Computer Science and Software Engineering', 'Dr. Carver has 22 years of experience at Ivy Tech with specializations in Machine Learning, AI, and Quantum Information Science'),
('Mr. Zach Hamby', 'Department Chair', 'Cloud Technologies, Full-Stack Development and Gaming Technologies', 'Mr. Hamby specializes in various development frameworks'),
('Mr. Anthony Ford', 'Faculty', 'Cyber Security', 'Mr. Ford specializes in Information Security, Intrusion Detection, and Data Encryption / Decryption'),
('Mr. Henry Davis', 'Faculty', 'Server Administration and Network Infrastructure', 'Mr. Davis specializes in Virtual Machining and Distributed Systems'),
('Mrs. Dilara Askarova', 'Faculty', 'Database Management Systems', 'Mrs. Askarova specializes in Data Analytics and Database languages of MS Access, SQL, and Oracle'),
('Mrs. Keneisha Etheridge', 'Faculty', 'Computer Science and Software Development', 'Mrs. Etheridge specializes in SDLC Methods of Agile and Waterfall, Python, and C++'),
('Mrs. Nakia Williams', 'Faculty', 'Informatics and Software Development', 'Mrs. Williams specializes in Computing Logic and Data Information Science');