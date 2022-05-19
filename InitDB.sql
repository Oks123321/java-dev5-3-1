CREATE TABLE projects (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(200),
	descriptions VARCHAR (200),
	developers_id BIGINT
);

CREATE TABLE developers (
    id IDENTITY PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
	age INTEGER,
	sex VARCHAR(10),
	skills_id BIGINT
);

ALTER TABLE developers
ADD CONSTRAINT sex_enum_values
CHECK (sex IN ('male', 'female', 'unknown'));

ALTER TABLE developers
ALTER COLUMN sex VARCHAR(10) NOT NULL;

CREATE TABLE projects_developers (
    developers_id BIGINT NOT NULL,
    projects_id BIGINT NOT NULL,
    PRIMARY KEY (developers_id, projects_id),
    FOREIGN KEY(developers_id) REFERENCES developers(id),
    FOREIGN KEY (projects_id) REFERENCES projects(id)
);


CREATE TABLE companies (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(200),
    country VARCHAR(150)
);


-- 
ALTER TABLE projects 
ADD CONSTRAINT companies_id_fk 
FOREIGN KEY(companies_id) 
REFERENCES companies(id);
--
ALTER TABLE projects
ALTER COLUMN companies_id BIGINT NOT NULL;
 


CREATE TABLE companies_developers (
    developers_id BIGINT NOT NULL,
    companies_id BIGINT NOT NULL,
    PRIMARY KEY (developers_id, companies_id),
    FOREIGN KEY(developers_id) REFERENCES developers(id),
    FOREIGN KEY (companies_id) REFERENCES companies(id)
);

CREATE TABLE skills (
    id IDENTITY PRIMARY KEY,
    branch VARCHAR(200),
    level VARCHAR(150)
);

CREATE TABLE customers (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(200),
    description VARCHAR(150)
);

CREATE TABLE projects_customers (
    projects_id BIGINT NOT NULL,
	customers_id BIGINT NOT NULL,
    PRIMARY KEY (customers_id, projects_id),
    FOREIGN KEY(customers_id) REFERENCES customers(id),
    FOREIGN KEY (projects_id) REFERENCES projects(id)
);

