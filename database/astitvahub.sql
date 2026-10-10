-- =========================================================
-- ASTITVAHUB – STUDENT DIGITAL PROFILE DATABASE SCHEMA
-- =========================================================

SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS `astitvahub`;
CREATE DATABASE `astitvahub` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `astitvahub`;

-- 1. USERS TABLE (Authentication credentials)
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `role` VARCHAR(20) DEFAULT 'STUDENT',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. STUDENTS TABLE (Core profile details)
CREATE TABLE `students` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL UNIQUE,
    `student_id` VARCHAR(50) NOT NULL UNIQUE,
    `full_name` VARCHAR(150) NOT NULL,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `phone` VARCHAR(20) DEFAULT '',
    `college_name` VARCHAR(255) DEFAULT '',
    `course` VARCHAR(150) DEFAULT '',
    `year` VARCHAR(50) DEFAULT '',
    `semester` VARCHAR(50) DEFAULT '',
    `location` VARCHAR(150) DEFAULT '',
    `about_me` TEXT,
    `skills` TEXT,
    `profile_photo` VARCHAR(255) DEFAULT '',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_student_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. PROJECTS TABLE (Student portfolio projects)
CREATE TABLE `projects` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT NOT NULL,
    `project_name` VARCHAR(200) NOT NULL,
    `description` TEXT,
    `technologies_used` VARCHAR(255) DEFAULT '',
    `github_url` VARCHAR(255) DEFAULT '',
    `live_demo_url` VARCHAR(255) DEFAULT '',
    `project_image` VARCHAR(255) DEFAULT '',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_project_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. CERTIFICATES TABLE (Student certifications)
CREATE TABLE `certificates` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT NOT NULL,
    `certificate_name` VARCHAR(200) NOT NULL,
    `issuing_organization` VARCHAR(200) DEFAULT '',
    `issue_date` DATE DEFAULT NULL,
    `certificate_id_code` VARCHAR(100) DEFAULT '',
    `certificate_url` VARCHAR(255) DEFAULT '',
    `certificate_file` VARCHAR(255) DEFAULT '',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_certificate_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. ACHIEVEMENTS TABLE (Student achievements & awards)
CREATE TABLE `achievements` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT NOT NULL,
    `achievement_name` VARCHAR(200) NOT NULL,
    `description` TEXT,
    `organization` VARCHAR(200) DEFAULT '',
    `achievement_date` DATE DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_achievement_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. SOCIAL LINKS TABLE (Student social & professional handles)
CREATE TABLE `social_links` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT NOT NULL,
    `platform_name` VARCHAR(50) NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_social_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- DEMO DATA SEEDING (Demo Student: Pratik Rajbhar - STU001)
-- Default Password: password123 (SHA-256: ef92b778ba7158759a4011a3447f92858b79370d97036d0b677045b4618e5603)
-- =========================================================

INSERT INTO `users` (`id`, `email`, `password_hash`, `role`) VALUES
(1, 'pratik@astitvahub.com', 'ef92b778ba7158759a4011a3447f92858b79370d97036d0b677045b4618e5603', 'STUDENT');

INSERT INTO `students` (`id`, `user_id`, `student_id`, `full_name`, `email`, `phone`, `college_name`, `course`, `year`, `semester`, `location`, `about_me`, `skills`, `profile_photo`) VALUES
(1, 1, 'STU001', 'Pratik Rajbhar', 'pratik@astitvahub.com', '+919876543210', 'Mumbai Institute of Technology', 'B.Sc. Computer Science', '2nd Year', 'Semester 4', 'Mumbai, Maharashtra', 'Passionate 2nd-year Computer Science student interested in full-stack Java web application development, cloud architectures, and open-source software development.', 'Java, Servlets, JSP, JDBC, MySQL, HTML5, CSS3, JavaScript, Git, Python', 'uploads/profile/demo_avatar.png');

INSERT INTO `projects` (`id`, `student_id`, `project_name`, `description`, `technologies_used`, `github_url`, `live_demo_url`, `project_image`) VALUES
(1, 1, 'AstitvaHub – Student Digital Profile', 'A complete production-style Java web application where students build and manage their verified digital profile with QR codes and dynamic VCF contact exports.', 'Java, Servlets, JSP, JDBC, MySQL, ZXing', 'https://github.com/pratikrajbhar/astitvahub', 'https://astitvahub.demo.com', 'uploads/projects/demo_project1.png'),
(2, 1, 'AI Facial Recognition Attendance System', 'Automated student attendance tracking system leveraging computer vision for quick multi-face recognition and attendance logging.', 'Python, OpenCV, SQLite, Tkinter', 'https://github.com/pratikrajbhar/facial-attendance', 'https://github.com/pratikrajbhar/facial-attendance', 'uploads/projects/demo_project2.png');

INSERT INTO `certificates` (`id`, `student_id`, `certificate_name`, `issuing_organization`, `issue_date`, `certificate_id_code`, `certificate_url`, `certificate_file`) VALUES
(1, 1, 'Java SE 17 Certified Developer', 'Oracle University', '2025-06-15', 'ORCL-JAV-99882', 'https://oracle.com/verify/ORCL-JAV-99882', 'uploads/certificates/demo_cert1.pdf'),
(2, 1, 'Full-Stack Web Development Mastery', 'Coursera / Meta', '2025-01-20', 'META-WEB-44512', 'https://coursera.org/verify/META-WEB-44512', 'uploads/certificates/demo_cert2.pdf');

INSERT INTO `achievements` (`id`, `student_id`, `achievement_name`, `description`, `organization`, `achievement_date`) VALUES
(1, 1, '1st Place Winner - State Hackathon 2025', 'Built an emergency aid dispatch system in 36 hours competing against 40+ college teams.', 'TechFest India', '2025-08-10'),
(2, 1, 'Dean\'s Academic Excellence Award', 'Awarded for maintaining top 1% GPA in Computer Science Department for 3 consecutive semesters.', 'Mumbai Institute of Technology', '2025-03-01');

INSERT INTO `social_links` (`id`, `student_id`, `platform_name`, `url`) VALUES
(1, 1, 'GitHub', 'https://github.com/pratikrajbhar'),
(2, 1, 'LinkedIn', 'https://linkedin.com/in/pratikrajbhar'),
(3, 1, 'Portfolio', 'https://pratikrajbhar.dev');

SET FOREIGN_KEY_CHECKS = 1;
