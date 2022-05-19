INSERT INTO developers (first_name, last_name,age, sex, skills_id) VALUES 
('Harry', 'Harryson', 35, 'male',1),
('Harry', 'Harryson', 35, 'male',7),
('Jack', 'Sparrow', 28, 'male',2),
('Jack', 'Sparrow', 28, 'male',8),
('Julia', 'Petterson', 30, 'female',3),
('Julia', 'Petterson', 30, 'female',8),
('Mary', 'Poppins', 40, 'female',4),
('Tom', 'Soyer', 18, 'male',5),
('Andrew', 'Smith', 50, 'male',6);

INSERT INTO skills (branch, level) VALUES
('Java', 'Junior'),
('Java', 'Middle'),
('Java', 'Senior'),
('C++', 'Junior'),
('C++', 'Middle'),
('C++', 'Senior'),
('JavaScript', 'Junior'),
('JavaScript', 'Middle'),
('JavaScript', 'Senior');

INSERT INTO projects(name, descriptions) VALUES
('My house', 'application for payment of utilities'),
('Our city', 'application for communication with the city authorities'),
('Travel', 'application about interesting travels'),
('Traffic schedule', 'schedule of urban and suburban transport'),
('Hot party', 'organization of parties and banquets'),
('Holiday', 'organization of children_s holidays')

INSERT INTO projects_developers(projects_id, developers_id) VALUES
(1,1),
(1,3),
(2,5),
(2,7),
(2,2),
(3,6),
(3,4),
(3,8),
(4,6),
(4,8),
(5,2),
(6,2),
(6,9);

INSERT INTO companies (name,country) VALUES
('UBD','Germany'),
('Optima','Ukraine'),
('Maximus','Poland'),
('Plast', 'Ukraine');

INSERT INTO companies_developers(companies_id, developers_id) VALUES
(1,1),
(1,4),
(2,2),
(2,6),
(2,5),
(3,3),
(3,8),
(3,2),
(4,6),
(4,8),
(4,1);

INSERT INTO customers (name,description) VALUES
('Kolos','children_s health resort'),
('JEO Ltd','management company'),
('VMR','Vinnytsia City Council'),
('TOM-VOYAG', 'travel agency'),
('Bomba-Tur', 'tour operator');

INSERT INTO projects_customers(projects_id, customers_id) VALUES
(1,1),
(1,2),
(2,2),
(2,3),
(3,3),
(4,3),
(4,4),
(5,4),
(6,5),
(6,1);


-- Отримати список всіх чоловіків
SELECT *
FROM developers
WHERE sex = 'male';


-- Отримати список працівників, що працюють у конкретному відділу
SELECT developers.*
FROM developers
JOIN projects_developers ON developers.id = projects_developers.developers_id
WHERE projects_id = 2;

-- Вивести відділ з максимальною кількістю працівників
SELECT *
FROM projects
WHERE id IN (
  SELECT projects_id
  FROM projects_developers
  GROUP BY projects_id
  ORDER BY count(developers_id) DESC
  LIMIT 1
); -- реалізація, яка не врахує ситуації, коли є відділи з однаковою максимальною кількістю працівників


SELECT *
FROM projects
WHERE id IN (
    SELECT projects_id
    FROM projects_developers
    GROUP BY projects_id
    HAVING count(developers_id) IN (
        SELECT count(developers_id)
        FROM projects_developers
        GROUP BY projects_id
        ORDER BY count(developers_id) DESC
        LIMIT 1
    )
); -- корректна реалізація

-- Вибрати людей, які не працюють у жодному відділі або працюють у двох і більше відділах
-- Працівники, які ніде не працюють
SELECT *, 'Free'
FROM developers
WHERE id NOT IN (
     SELECT developers_id FROM projects_developers
)

UNION

-- Працівники, які працюють в 2+ відділах
SELECT *, '2+ projects'
FROM developers
WHERE id IN (
    SELECT developers_id
    FROM projects_developers
    GROUP BY developers_id
    HAVING count(projects_id) >= 2
);

-- Знайти всіх працівників, у яких у імені або у прізвищі є буква y
SELECT *
FROM developers
WHERE LOWER(first_name) LIKE '%d%' OR LOWER(last_name) LIKE '%y%';


