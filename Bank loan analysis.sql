-- 1. Retrieve all loans from a specific state.
SELECT * FROM loans WHERE address_state = 'CA';

-- 2. List all unique employment titles.
SELECT DISTINCT emp_title FROM loans;

-- 3. Find all loans with a grade of 'A'.
SELECT * FROM loans WHERE grade = 'A';

-- 4. Count the total number of loans issued.
SELECT COUNT(*) AS total_loans FROM loans;

-- 5. List loans with an annual income greater than $100,000.
SELECT * FROM loans WHERE annual_income > 100000;

-- 6. Retrieve loans with an interest rate lower than 10%.
SELECT * FROM loans WHERE int_rate < 0.10;

-- 7. Find the average loan amount for each loan grade.
SELECT grade, AVG(loan_amount) AS avg_loan_amount FROM loans GROUP BY grade;

-- 8. Identify the top 5 states with the highest number of loans.
SELECT address_state, COUNT(*) AS loan_count 
FROM loans 
GROUP BY address_state 
ORDER BY loan_count DESC 
LIMIT 5;

-- 9. Calculate the total payment made for loans with a term of '36 months'.
SELECT SUM(total_payment) AS total_36_months_payment FROM loans WHERE term = '36 months';

-- 10. Find the maximum annual income for each verification status.
SELECT verification_status, MAX(annual_income) AS max_income FROM loans GROUP BY verification_status;

-- 11. Retrieve loans issued in 2021 with a sub-grade of 'C5'.
SELECT * FROM loans WHERE issue_date LIKE '2021%' AND sub_grade = 'C5';

-- 12. Identify borrowers with a debt-to-income ratio higher than 0.5.
SELECT * FROM loans WHERE dti > 0.5;

-- 13. Count the number of loans by their purpose.
SELECT purpose, COUNT(*) AS purpose_count FROM loans GROUP BY purpose;

-- 14. Retrieve loans where the total payment exceeds the loan amount by at least 50%.
SELECT * FROM loans WHERE total_payment > loan_amount * 1.5;

-- 15. Find the loan with the highest interest rate in each state.
SELECT address_state, MAX(int_rate) AS max_interest_rate 
FROM loans 
GROUP BY address_state;

-- 16. Calculate the average installment for loans grouped by grade and term.
SELECT grade, term, AVG(installment) AS avg_installment 
FROM loans 
GROUP BY grade, term;

-- 17. Identify loans where the borrower's annual income is within the top 10%.
SELECT * FROM loans WHERE annual_income > (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY annual_income) FROM loans
);

-- 18. Find the total loan amount and average interest rate for loans with 'Verified' income status.
SELECT SUM(loan_amount) AS total_loan, AVG(int_rate) AS avg_interest_rate 
FROM loans 
WHERE verification_status = 'Verified';

-- 19. List all loans where the next payment date is later than '2022-01-01'.
SELECT * FROM loans WHERE next_payment_date > '2022-01-01';

-- 20. Retrieve the top 5 loans with the highest installment amount.
SELECT * FROM loans ORDER BY installment DESC LIMIT 5;

-- 21. Calculate the number of loans with a debt-to-income ratio greater than the average.
SELECT COUNT(*) AS high_dti_loans 
FROM loans 
WHERE dti > (SELECT AVG(dti) FROM loans);

-- 22. Identify loans where the borrower's employment length is '10+ years' and their loan grade is 'B'.
SELECT * FROM loans WHERE emp_length = '10+ years' AND grade = 'B';

-- 23. Retrieve the percentage of loans with a 'Paid' status.
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loans)) AS paid_percentage 
FROM loans 
WHERE loan_status = 'Paid';

-- 24. Find the average loan amount for each state where the loan status is not 'Default'.
SELECT address_state, AVG(loan_amount) AS avg_loan_amount 
FROM loans 
WHERE loan_status != 'Default' 
GROUP BY address_state;

-- 25. Identify loans where the borrower's home ownership status is 'Mortgage' and the loan term is '60 months'.
SELECT * FROM loans WHERE home_ownership = 'Mortgage' AND term = '60 months';

-- 26. Find the total number of loans issued per state for borrowers with above-average annual income.
SELECT address_state, COUNT(*) AS loans_above_avg_income 
FROM loans 
WHERE annual_income > (SELECT AVG(annual_income) FROM loans) 
GROUP BY address_state;

-- 27. Retrieve the top 3 states with the highest average loan amount for borrowers whose debt-to-income ratio is below the overall average.
SELECT address_state, AVG(loan_amount) AS avg_loan_amount 
FROM loans 
WHERE dti < (SELECT AVG(dti) FROM loans) 
GROUP BY address_state 
ORDER BY avg_loan_amount DESC 
LIMIT 3;

-- 28. Identify borrowers who have the highest total payment within each loan grade.
SELECT * FROM loans WHERE (grade, total_payment) IN (
    SELECT grade, MAX(total_payment) FROM loans GROUP BY grade
);

-- 29. Calculate the average interest rate for loans issued in 2021, grouped by verification status and sub-grade.
SELECT verification_status, sub_grade, AVG(int_rate) AS avg_interest_rate 
FROM loans 
WHERE issue_date LIKE '2021%' 
GROUP BY verification_status, sub_grade;

-- 30. Find the percentage of loans where the borrower's annual income is in the top 25% for their state.
SELECT address_state, 
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loans WHERE address_state = loans.address_state)) AS top_25_percent 
FROM loans 
WHERE annual_income > (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY annual_income) FROM loans WHERE address_state = loans.address_state) 
GROUP BY address_state;
