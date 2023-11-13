use project3;

#Weekly User Engagement
/*Objective: Measure the activeness of users on a weekly basis.
Your Task: Write an SQL query to calculate the weekly user engagement.*/

SELECT 
    WEEK(occured_at) AS week_no, COUNT(user_id) AS active_users
FROM
    events
GROUP BY week_no;

#User Growth Analysis
/*Objective: Analyze the growth of users over time for a product.
Your Task: Write an SQL query to calculate the user growth for the product.*/

SELECT 
    YEAR(created_at) AS years,
    MONTH(created_at) AS months,
    COUNT(DISTINCT user_id) / (SELECT 
            COUNT(DISTINCT user_id)
        FROM
            users) * 100 AS user_growth_rate
FROM
    users
GROUP BY 1 , 2;

#Weekly Retention Analysis
/*Objective: Analyze the retention of users on a weekly basis after signing up for a product.
Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.*/

SELECT 
    WEEK(ACTIVATED_AT) AS weekday_activity,
    (COUNT(USER_ID) / (SELECT 
            COUNT(DISTINCT USER_ID)
        FROM
            USERS)) * 100 AS weekly_retention_users
FROM
    USERS
GROUP BY WEEKLY;

#Weekly Engagement Per Device
/*Objective: Measure the activeness of users on a weekly basis per device.
Your Task: Write an SQL query to calculate the weekly engagement per device.*/

SELECT 
    EXTRACT(WEEK FROM occured_at) AS week_no,
    device,
    COUNT(DISTINCT user_id) AS users
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY week_no, device;

#Email Engagement Analysis
/*Objective: Analyze how users are engaging with the email service.
Your Task: Write an SQL query to calculate the email engagement metrics.*/

SELECT 
    action,
    COUNT(DISTINCT email_events.user_id) / (SELECT 
            COUNT(DISTINCT user_id)
        FROM
            email_events) * 100 AS user_metrics
FROM
    email_events
        JOIN
    events ON email_events.user_id = events.user_id
        AND EVENT_TYPE = 'engagement'
GROUP BY action;

