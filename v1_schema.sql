-- Create the database schema
CREATE SCHEMA IF NOT EXISTS TimpanogosCommunityCollege;
USE TimpanogosCommunityCollege;
 
-- Create the Students table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Major VARCHAR(100),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Create the Faculty table
CREATE TABLE IF NOT EXISTS Faculty (
    FacultyID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(100),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Create the Courses table
CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    TeacherID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TeacherID) REFERENCES Faculty(FacultyID)
);
 
-- Create the Enrollment table
CREATE TABLE IF NOT EXISTS Enrollment (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
-- Create the Grades table
CREATE TABLE IF NOT EXISTS Grades (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Grade CHAR(2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
-- Create the ParkingPass table
CREATE TABLE IF NOT EXISTS ParkingPass (
    ParkingPassID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    HasPass BOOLEAN NOT NULL,
    LicensePlate VARCHAR(20) DEFAULT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
 
-- Create the Advisors table
CREATE TABLE IF NOT EXISTS Advisors (
    AdvisorID INT AUTO_INCREMENT PRIMARY KEY,
    FacultyID INT NOT NULL,
    StudentID INT NOT NULL,
    AssignedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
 
-- Create the Attendance table
CREATE TABLE IF NOT EXISTS Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    Status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
-- Create the Scholarships table
CREATE TABLE IF NOT EXISTS Scholarships (
    ScholarshipID INT AUTO_INCREMENT PRIMARY KEY,
    ScholarshipName VARCHAR(100) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    StudentID INT NOT NULL,
    AwardedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
 
-- Create the Clubs tables
CREATE TABLE IF NOT EXISTS Clubs (
    ClubID INT AUTO_INCREMENT PRIMARY KEY,
    ClubName VARCHAR(100) NOT NULL,
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE IF NOT EXISTS ClubMemberships (
    MembershipID INT AUTO_INCREMENT PRIMARY KEY,
    ClubID INT NOT NULL,
    StudentID INT NOT NULL,
    JoinedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
 
-- Create the Library tables
CREATE TABLE IF NOT EXISTS LibraryBooks (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100),
    ISBN VARCHAR(20),
    PublishedYear YEAR,
    AvailableCopies INT NOT NULL
);
 
CREATE TABLE IF NOT EXISTS BorrowedBooks (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    StudentID INT NOT NULL,
    BorrowedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DueDate DATE NOT NULL,
    ReturnedAt TIMESTAMP NULL,
    FOREIGN KEY (BookID) REFERENCES LibraryBooks(BookID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
 