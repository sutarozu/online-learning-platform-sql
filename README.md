# Online Learning Platform: SQL Analytics Project

A PostgreSQL project that models an online course platform (think Udemy or Coursera) and uses it to practice analytical SQL, from basic joins to window functions, recursive CTEs, cohort analysis, and database objects such as views, triggers, and functions.

> **Status:** 🚧 In progress. See the [Roadmap](#roadmap) for what is done so far.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Database Schema](#database-schema)
- [Dataset](#dataset)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)
- [Key Insights](#key-insights)
- [Author](#author)

---

## Project Overview

The goal of this project is to answer realistic business questions for an e-learning platform, such as:

- Which course categories generate the most revenue, and which have the highest refund rate?
- How far do students get through a course, and where do they drop off?
- Which students are the most active learners?
- Who are the top referrers, once indirect referrals are counted?
- How healthy is the data, and how can the database enforce its own rules?

## Tech Stack

- **Database:** PostgreSQL 16
- **Tools:** psql, pgAdmin or DBeaver (any PostgreSQL client works)
- **Version control:** Git and GitHub

## Database Schema

The database has **8 tables**. Two of them use composite primary keys, and two are self-referencing.

| Table | Description | Primary Key | Foreign Keys |
|---|---|---|---|
| `categories` | Course categories (hierarchical) | `category_id` | `parent_category_id` → `categories` |
| `instructors` | Course instructors | `instructor_id` | none |
| `courses` | Courses offered on the platform | `course_id` | `category_id` → `categories`, `instructor_id` → `instructors` |
| `students` | Registered students | `student_id` | `referred_by` → `students` |
| `enrollments` | A student enrolling in a course | `enrollment_id` | `student_id` → `students`, `course_id` → `courses` |
| `lessons` | Lessons inside a course | `(course_id, lesson_no)` | `course_id` → `courses` |
| `lesson_progress` | Which lessons each student completed | `(student_id, course_id, lesson_no)` | `student_id` → `students`, `(course_id, lesson_no)` → `lessons` |
| `reviews` | Ratings and reviews of enrollments | `review_id` | `enrollment_id` → `enrollments` |

**Design highlights**

- **Composite primary keys** on `lessons` (2 columns) and `lesson_progress` (3 columns).
- **Composite foreign key** from `lesson_progress` to `lessons`.
- **Self-referencing foreign keys** on `categories` (category tree) and `students` (referral chain).
- **Constraints:** `CHECK` on `level`, `price`, `status`, and `rating`; `UNIQUE` on `(student_id, course_id)` to prevent duplicate enrollments.

### Entity Relationship Diagram

<!-- Replace with your own diagram, e.g. exported from dbdiagram.io -->
![ERD](docs/erd.png)

## Dataset

The dataset is synthetic and was generated for this project.

| Table | Rows |
|---|---|
| categories | 12 |
| instructors | 25 |
| courses | 34 |
| students | 300 |
| enrollments | 1,012 |
| lessons | 290 |
| lesson_progress | 5,724 |
| reviews | 370 |

The data intentionally contains some real-world imperfections (for example missing or inconsistent values) so that data quality checks are part of the analysis.

## Getting Started

### Prerequisites

- PostgreSQL 14 or newer
- A SQL client (psql, pgAdmin, or DBeaver)

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/online-learning-platform-sql.git
cd online-learning-platform-sql

# 2. Create a database
createdb learning_platform

# 3. Create the tables
psql -d learning_platform -f sql/01_schema/01_schema.sql

# 4. Load the data
psql -d learning_platform -f sql/02_data/02_data.sql
```

Then run any query file from the `sql/` folder, for example:

```bash
psql -d learning_platform -f sql/03_basic_queries/03_basic.sql
```

## Project Structure

```
online-learning-platform-sql/
├── README.md
├── .gitignore
├── docs/
│   ├── erd.png
│   └── data_dictionary.md
├── sql/
│   ├── 01_schema/              # CREATE TABLE statements
│   ├── 02_data/                # INSERT statements
│   ├── 03_basic_queries/       # Joins, aggregation, window functions
│   ├── 04_advanced_queries/    # Recursive CTEs, funnel, cohort, streaks
│   └── 05_database_objects/    # Views, indexes, functions, triggers, transactions
└── results/
    ├── screenshots/
    └── insights.md
```

## Roadmap

- [x] Database schema
- [x] Seed data
- [ ] Level 1: Fundamentals (joins, filtering, aggregation)
- [ ] Level 2: Window functions
- [ ] Level 3: CTEs and recursive CTEs
- [ ] Level 4: Business analysis (funnel, cohort retention, learning streaks)
- [ ] Level 5: Data quality and database objects (views, indexes, functions, triggers, transactions)
- [ ] Final: one-page KPI dashboard query

## Key Insights

_To be added as the analysis progresses. Each finding will be summarized in [`results/insights.md`](results/insights.md)._

## Skills Demonstrated

- Relational database design (normalization, composite keys, constraints)
- Advanced SQL: window functions, CTEs, recursive queries, pivoting
- Business analytics: funnel analysis, cohort retention, revenue trends
- Data quality auditing
- Database programming: views, materialized views, functions, triggers, transactions
- Query performance tuning with `EXPLAIN ANALYZE`

## Author

**Your Name**

- GitHub: [@your-username](https://github.com/your-username)
- LinkedIn: [your-profile](https://www.linkedin.com/in/your-profile)
