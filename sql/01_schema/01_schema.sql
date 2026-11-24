-- =====================================================
-- PROJECT : Online Learning Platform (PostgreSQL)
-- FILE    : 01_schema.sql
-- =====================================================

DROP TABLE IF EXISTS reviews         CASCADE;
DROP TABLE IF EXISTS lesson_progress CASCADE;
DROP TABLE IF EXISTS lessons         CASCADE;
DROP TABLE IF EXISTS enrollments     CASCADE;
DROP TABLE IF EXISTS students        CASCADE;
DROP TABLE IF EXISTS courses         CASCADE;
DROP TABLE IF EXISTS instructors     CASCADE;
DROP TABLE IF EXISTS categories      CASCADE;

CREATE TABLE categories (
    category_id        INT PRIMARY KEY,
    category_name      VARCHAR(60) NOT NULL,
    parent_category_id INT REFERENCES categories(category_id)
);

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    full_name     VARCHAR(80) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    country       VARCHAR(40),
    joined_date   DATE
);

CREATE TABLE courses (
    course_id      INT PRIMARY KEY,
    title          VARCHAR(120) NOT NULL,
    category_id    INT REFERENCES categories(category_id),
    instructor_id  INT REFERENCES instructors(instructor_id),
    level          VARCHAR(15) CHECK (level IN ('Beginner','Intermediate','Advanced')),
    price          NUMERIC(10,0) CHECK (price >= 0),
    published_date DATE,
    is_active      BOOLEAN DEFAULT TRUE
);

CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    full_name   VARCHAR(80) NOT NULL,
    email       VARCHAR(100),
    city        VARCHAR(40),
    signup_date DATE,
    referred_by INT REFERENCES students(student_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id    INT NOT NULL REFERENCES students(student_id),
    course_id     INT NOT NULL REFERENCES courses(course_id),
    enroll_date   DATE NOT NULL,
    price_paid    NUMERIC(10,0),
    status        VARCHAR(10) CHECK (status IN ('active','completed','refunded')),
    UNIQUE (student_id, course_id)
);

CREATE TABLE lessons (
    course_id        INT REFERENCES courses(course_id) ON DELETE CASCADE,
    lesson_no        INT,
    lesson_title     VARCHAR(120),
    duration_minutes INT,
    PRIMARY KEY (course_id, lesson_no)
);

CREATE TABLE lesson_progress (
    student_id    INT REFERENCES students(student_id),
    course_id     INT,
    lesson_no     INT,
    completed_at  TIMESTAMP,
    watch_seconds INT,
    PRIMARY KEY (student_id, course_id, lesson_no),
    FOREIGN KEY (course_id, lesson_no) REFERENCES lessons(course_id, lesson_no)
);

CREATE TABLE reviews (
    review_id     INT PRIMARY KEY,
    enrollment_id INT UNIQUE REFERENCES enrollments(enrollment_id),
    rating        INT CHECK (rating BETWEEN 1 AND 5),
    review_text   TEXT,
    review_date   DATE
);
