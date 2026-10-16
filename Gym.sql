


-- =========================================
-- INSERT DATA INTO MEMBER
-- =========================================

INSERT INTO member VALUES
(1, 'Ahmed Mohamed', 'ahmed.mohamed@example.com', '01012345678', DATE '2025-01-10', 'Cairo');

INSERT INTO member VALUES
(2, 'Mona Ali', 'mona.ali@example.com', '01012345679', DATE '2025-02-15', 'Giza');

INSERT INTO member VALUES
(3, 'Omar Hassan', 'omar.hassan@example.com', '01012345680', DATE '2025-03-01', 'Alexandria');

INSERT INTO member VALUES
(4, 'Sara Mahmoud', 'sara.mahmoud@example.com', '01012345681', DATE '2025-04-20', 'Cairo');

INSERT INTO member VALUES
(5, 'Youssef Ibrahim', 'youssef.ibrahim@example.com', '01012345682', DATE '2025-05-05', 'Mansoura');

INSERT INTO member VALUES
(6, 'Nour Khaled', 'nour.khaled@example.com', '01012345683', DATE '2025-06-12', 'Giza');


-- =========================================
-- INSERT DATA INTO MEMBERSHIP_PLAN
-- =========================================

INSERT INTO membership_plan VALUES
(1, 'Monthly Plan', 1, 500);

INSERT INTO membership_plan VALUES
(2, 'Quarterly Plan', 3, 1350);

INSERT INTO membership_plan VALUES
(3, 'Annual Plan', 12, 4800);

INSERT INTO membership_plan VALUES
(4, 'Six Month Plan', 6, 2600);


-- =========================================
-- INSERT DATA INTO TRAINER
-- =========================================

INSERT INTO trainer VALUES
(1, 'Karim Adel', 'Weight Training', DATE '2022-03-15');

INSERT INTO trainer VALUES
(2, 'Hana Samir', 'Yoga', DATE '2021-07-01');

INSERT INTO trainer VALUES
(3, 'Mostafa Nabil', 'Cardio', DATE '2023-01-10');

INSERT INTO trainer VALUES
(4, 'Reem Tarek', 'Pilates', DATE '2024-02-20');


-- =========================================
-- INSERT DATA INTO MEMBERSHIP
-- =========================================

INSERT INTO membership VALUES
(1, 1, 3, DATE '2025-01-10', DATE '2026-01-09', 'EXPIRED');

INSERT INTO membership VALUES
(2, 2, 2, DATE '2026-08-01', DATE '2026-10-31', 'ACTIVE');

INSERT INTO membership VALUES
(3, 3, 1, DATE '2026-09-01', DATE '2026-09-30', 'EXPIRED');

INSERT INTO membership VALUES
(4, 5, 3, DATE '2026-01-01', DATE '2026-12-31', 'ACTIVE');

INSERT INTO membership VALUES
(5, 6, 2, DATE '2026-10-01', DATE '2026-12-31', 'ACTIVE');


-- =========================================
-- INSERT DATA INTO FITNESS_CLASS
-- =========================================

INSERT INTO fitness_class VALUES
(1, 'Morning Yoga', 2, 20, TIMESTAMP '2026-11-01 09:00:00');

INSERT INTO fitness_class VALUES
(2, 'Strength Training', 1, 15, TIMESTAMP '2026-11-01 11:00:00');

INSERT INTO fitness_class VALUES
(3, 'Cardio Blast', 3, 25, TIMESTAMP '2026-11-02 17:30:00');

INSERT INTO fitness_class VALUES
(4, 'Open Gym Session', NULL, 30, TIMESTAMP '2026-11-03 10:00:00');


-- =========================================
-- INSERT DATA INTO CLASS_BOOKING
-- =========================================

INSERT INTO class_booking VALUES
(1, 1, 1, DATE '2026-10-01', 'ATTENDED');

INSERT INTO class_booking VALUES
(2, 2, 1, DATE '2026-10-02', 'BOOKED');

INSERT INTO class_booking VALUES
(3, 3, 2, DATE '2026-10-03', 'ATTENDED');

INSERT INTO class_booking VALUES
(4, 1, 2, DATE '2026-10-04', 'CANCELLED');

INSERT INTO class_booking VALUES
(5, 5, 3, DATE '2026-10-05', 'BOOKED');

INSERT INTO class_booking VALUES
(6, 6, 1, DATE '2026-10-06', 'NO_SHOW');


-- =========================================
-- INSERT DATA INTO PAYMENT
-- =========================================

INSERT INTO payment
(payment_id, membership_id, payment_date, amount, payment_method, papyment_status)
VALUES
(1, 1, DATE '2025-01-10', 4800, 'CARD', 'COMPLETED');

INSERT INTO payment
(payment_id, membership_id, payment_date, amount, payment_method, papyment_status)
VALUES
(2, 2, DATE '2026-08-01', 1350, 'CASH', 'COMPLETED');

INSERT INTO payment
(payment_id, membership_id, payment_date, amount, payment_method, papyment_status)
VALUES
(3, 3, DATE '2026-09-01', 500, 'WALLET', 'PENDING');

INSERT INTO payment
(payment_id, membership_id, payment_date, amount, payment_method, papyment_status)
VALUES
(4, 4, DATE '2026-01-01', 4800, 'CARD', 'FAILED');

INSERT INTO payment
(payment_id, membership_id, payment_date, amount, payment_method, papyment_status)
VALUES
(5, 1, DATE '2025-01-12', 200, 'CASH', 'COMPLETED');

COMMIT;

CREATE TABLE member (
    member_id NUMBER (10) PRIMARY KEY,
    full_name VARCHAR2 (100) NOT NULL,
    email VARCHAR2 (150) UNIQUE NOT NULL,
    phone VARCHAR2 (15) UNIQUE NOT NULL,
    join_date DATE DEFAULT SYSDATE NOT NULL,
    city VARCHAR2 (50) NOT NULL
)

CREATE TABLE membership_plan (
    plan_id NUMBER (10) PRIMARY KEY,
    plan_name VARCHAR2 (100) NOT NULL UNIQUE,
    dutation_months NUMBER (5) NOT NULL CHECK (dutation_months > 0),
    price NUMBER (10,2) NOT NULL CHECK (price > 0)
)

CREATE TABLE membership (
    membership_id NUMBER (10) PRIMARY KEY,
    member_id NUMBER (10) REFERENCES member(member_id),
    plan_id NUMBER (10) REFERENCES membership_plan(plan_id),
    start_date DATE NOT NULL,
    end_date DATE,
    membership_status VARCHAR2 (20) NOT NULL
)

CREATE TABLE trainer (
    trainer_id NUMBER (10) PRIMARY KEY,
    full_name VARCHAR2 (100) NOT NULL,
    specialization VARCHAR2 (100) NOT NULL,
    hire_date DATE DEFAULT SYSDATE NOT NULL
)

CREATE TABLE fitness_class (
    class_id NUMBER (10) PRIMARY KEY,
    class_name VARCHAR2 (100) NOT NULL,
    trainer_id NUMBER (10) REFERENCES trainer(trainer_id),
    capacity NUMBER (5) NOT NULL CHECK (capacity > 0),
    scheduled_at TIMESTAMP NOT NULL 
)

CREATE TABLE class_booking (
    booking_id NUMBER (10) PRIMARY KEY,
    member_id NUMBER (10) REFERENCES member(member_id),
    class_id NUMBER (10) REFERENCES fitness_class(class_id),
    booking_date DATE DEFAULT SYSDATE NOT NULL,
    attendance_status VARCHAR2 (50) NOT NULL
)

CREATE TABLE payment (
    payment_id NUMBER (10) PRIMARY KEY,
    membership_id NUMBER (10) REFERENCES membership(membership_id),
    payment_date DATE DEFAULT SYSDATE NOT NULL,
    amount NUMBER (10) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR2 (50) NOT NULL,
    papyment_status VARCHAR2 (50) NOT NULL
)

-- Query 1

SELECT s.membership_id, m.full_name, p.plan_name, s.start_date, s.membership_status
FROM membership s 
JOIN member m
ON s.member_id = m.member_id
JOIN membership_plan p
ON p.plan_id = s.plan_id
ORDER BY membership_id;

-- Query 2

SELECT m.member_id, m.full_name, m.phone, s.membership_id, s.start_date
FROM member m
LEFT JOIN membership s
ON s.member_id = m.member_id
ORDER BY member_id;

-- Query 3

SELECT c.class_id, c.class_name, c.scheduled_at, b.booking_date, b.attendance_status 
FROM class_booking b
RIGHT JOIN fitness_class c 
ON c.class_id = b.class_id
ORDER BY class_id;

-- Query 4

SELECT t.trainer_id, t.full_name, t.specialization, c.class_name
FROM trainer t
LEFT JOIN fitness_class c
ON c.trainer_id = t.trainer_id
ORDER BY trainer_id;

-- Query 5

SELECT p.plan_name, COUNT(m.membership_id) AS "MemberShips Count", AVG(p.price) AS AVG_price
FROM membership_plan p 
join membership m
ON m.plan_id = p.plan_id
GROUP BY plan_name
ORDER BY AVG_price DESC;

-- Query 6

SELECT m.full_name, COUNT(b.booking_id) AS Booking_Count
FROM member m 
LEFT JOIN class_booking b
ON b.member_id = m.member_id
GROUP BY m.member_id, m.full_name
ORDER BY Booking_Count DESC, m.full_name;

-- Query 7

SELECT mp.plan_name, SUM(p.amount) AS revenue
FROM payment p
JOIN membership m
ON p.membership_id = m.membership_id
JOIN membership_plan mp
ON m.plan_id = mp.plan_id
WHERE p.papyment_status = 'COMPLETED'
GROUP BY mp.plan_id , mp.plan_name
ORDER BY revenue DESC;

-- Query 8

SELECT c.class_name, COUNT(b.booking_id) AS book_count
FROM fitness_class c
LEFT JOIN class_booking b
ON b.class_id = c.class_id
GROUP BY c.class_id , c.class_name
ORDER BY book_count DESC;

-- Query 9

SELECT membership_id, 
CASE
    WHEN membership_status = 'ACTIVE' THEN 'Active Membership'
    WHEN membership_status = 'EXPIRED' THEN 'Expired Membership'
    WHEN membership_status = 'PENDING' THEN 'Pending Membership'
    ELSE 'Unknown'
END AS status
FROM membership
ORDER BY membership_id;

-- Query 10

SELECT full_name, NVL(phone , NVL(email , 'No contact details')) AS contact
FROM member
ORDER BY member_id;

SELECT full_name, COALESCE(phone , email , 'No contact details') AS contact
FROM member
ORDER BY member_id;

-- Query 11

SELECT m.membership_id, NVL(SUM(p.amount) , 0) AS "total_amount"
FROM payment p
RIGHT JOIN membership m
ON p.membership_id = m.membership_id
GROUP BY m.membership_id;

-- Query 12

SELECT t.full_name AS "Trainer Name", COUNT(f.class_id) AS class_count
FROM trainer t
LEFT JOIN fitness_class f
ON f.trainer_id = t.trainer_id
GROUP BY t.trainer_id, t.full_name
ORDER BY class_count DESC;

-- Query 13

SELECT payment_id, membership_id, payment_method, amount, payment_date, 
CASE
    WHEN papyment_status = 'COMPLETED' THEN 'Completed'
    WHEN papyment_status = 'PENDING' THEN 'Pending'
    WHEN papyment_status = 'FAILED' THEN 'Not completed'
END AS status
FROM payment p
ORDER BY payment_date DESC;

-- Query 14

SELECT payment_method, SUM(amount), AVG(amount), MIN(amount), MAX(amount), COUNT(*) 
FROM payment p
GROUP BY payment_method;

-- Query 15

SELECT m.full_name, COUNT(p.payment_id) AS payments_count, SUM(p.amount) AS Total_amount
FROM membership s
JOIN payment p
ON p.membership_id = s.membership_id
JOIN member m
ON s.member_id = m.member_id
HAVING payments_count >= 2
GROUP BY m.member_id, m.full_name
ORDER BY Total_amount DESC;





