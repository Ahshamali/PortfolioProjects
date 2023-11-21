#Retrieve all information about the vehicles available in the dealership.
SELECT * FROM Brands;
SELECT * FROM Customer;
SELECT * FROM Deal;
SELECT * FROM Dealership;
SELECT * FROM Insaurance;
SELECT * FROM Manager;
SELECT * FROM Region;
SELECT * FROM Sales_agent;
SELECT * FROM Vehicle;

#Find the total number of vehicles in the all the Showrooms.
SELECT COUNT(*) FROM Vehicle; 

#List the details of the distinct top three most expensive Scooters in all showrooms.
SELECT DISTINCT(price) FROM Vehicle
ORDER BY Price DESC
LIMIT 3;

#Retrieve the names and contact information of all customers who have purchased a vehicle.
SELECT CFirstName, CLastName, Phone_number, Email FROM Customer
WHERE CustomerID IN (SELECT DISTINCT(d.customerID) FROM Customer c  JOIN Deal d ON c.CustomerID  AND d.DealID);

#Find the average price of vehicles in all showrooms.
SELECT AVG(price) FROM Vehicle;

#List the names of sales agents along with the total number of deals they have closed.
SELECT AFirstName, ALastName, COUNT(*) AS TotalDeals FROM Sales_Agent 
JOIN DEAL ON Sales_agent.AgentID = Deal.AgentID
GROUP BY AFirstName, ALastName;

#Retrieve the details of the most recent deal, including the vehicle, customer, and agent information.
SELECT * FROM Deal WHERE DealDate = (SELECT MAX(DealDate) FROM Deal);

#Find the total revenue generated by each dealership from all deals.
SELECT  DealershipName , SUM(price) Totalrevenue FROM dealership d JOIN Vehicle v ON d.DealershipID = v.dealershipID
GROUP BY DealershipName
ORDER BY Totalrevenue DESC;

#Retrieve the details of vehicles that have not been sold (not included in any deal).
SELECT * FROM Vehicle  WHERE vehicleID NOT IN
(SELECT VehicleID FROM deal);

#List the names of customers who purchased a vehicle along with the model and make of the vehicle.
SELECT CfirstName, CLastName, Make, Model FROM Vehicle 
JOIN deal ON Vehicle.VehicleID = deal.VehicleID
JOIN Customer ON Customer.customerID = Deal.customerID;

#Calculate the total commission earned by each sales agent in the last quarter. 
#Assume that the commission is 5% of the total deal amount. Include the agent's name and total commission.
SELECT Deal.AgentID, AFirstName, ALastName, SUM(price * 0.05) AS Total_Commission  FROM Sales_agent 
JOIN Deal ON Sales_Agent.AgentID = Deal.AgentID
JOIN Vehicle ON Deal.VehicleID = Vehicle.VehicleID
WHERE DealDate <= '2022-12-20' AND DealDate >= '2022-11-08'
GROUP BY Deal.AgentID, AFirstName, ALastName;


#Identify the top 3 most profitable vehicle models by calculating the total revenue generated from deals for each model.
SELECT Model, SUM(price) AS Total_revenue FROM Vehicle 
JOIN Deal ON Deal.VehicleID = Vehicle.VehicleID
GROUP BY Model
ORDER BY Total_revenue DESC
LIMIT 3;

#Calculate the total number of deals closed for each vehicle Make. 
#Display the Make and the total number of deals, even if no deals have been made for that Make.
SELECT Make, COUNT(Deal.VehicleID) FROM Deal
JOIN Vehicle ON Deal.VehicleID = Vehicle.VehicleID
GROUP BY Make

    #Find the last name of all agents, and where they work, with a salary higher than 55000
SELECT ALastName,DealershipName FROM Sales_agent 
JOIN Dealership ON Sales_agent.DealershipID = Dealership.DealershipID 
WHERE salary > 55000;

#Find all the deals that included Liability insurance
SELECT DealID FROM Deal  JOIN Insaurance ON Deal.InsauranceID = Insaurance.InsauranceID
WHERE PolicyType ='Liability Insurance';

#Calculate the cumulative sales for each sales agent over time.
SELECT d.AgentID, d.DealDate, SUM(v.price) 
OVER (PARTITION BY AgentID ORDER BY DealDate) AS Cumulative_sum FROM Deal d 
JOIN Vehicle v ON d.VehicleID = v.VehicleID

#Find the average price of vehicles, considering the previous and next rows in the result set.
SELECT VehicleID, price ,AVG(price) 
OVER (Order BY VehicleID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Avgpricewithrows 
FROM Vehicle

#Rank the sales agents based on the total sales amount.
SELECT d.AgentID, SUM(price) AS Total_Sales, 
RANK() OVER (ORDER BY SUM(price) DESC) AS Sales_Rank FROM Deal d 
JOIN Vehicle v ON d.VehicleID = v.VehicleID
GROUP BY d.AgentID

#Change the renewal date From Insaurance table to different dates for each row
UPDATE Insaurance
SET RenewalDate = 
	CASE
		WHEN InsauranceID = 1 THEN  '2022-12-05'
        WHEN InsauranceID = 2 THEN  '2022-12-13'
        WHEN InsauranceID = 3 THEN  '2022-12-18'
        WHEN InsauranceID = 4 THEN  '2022-11-25'
        WHEN InsauranceID = 5 THEN  '2022-12-10'
        WHEN InsauranceID = 6 THEN  '2022-12-01'
        WHEN InsauranceID = 7 THEN '2023-12-12'
        WHEN InsauranceID = 8 THEN  '2023-12-14'
        WHEN InsauranceID = 9 THEN  '2023-12-10'
        WHEN InsauranceID = 10 THEN '2023-12-17'
        WHEN InsauranceID = 11 THEN  '2023-12-15'
        WHEN InsauranceID = 12 THEN  '2023-12-13'
        WHEN InsauranceID = 13 THEN  '2023-12-18'
        WHEN InsauranceID = 14 THEN   '2023-11-25'
        WHEN InsauranceID = 15 THEN   '2023-12-10'
        WHEN InsauranceID = 16 THEN   '2023-12-01'
        
        ELSE RenewalDate = "2024-01-01"
	END;
        
   #Calculate the running total of insurance renewals over time. 
SELECT RenewalDate, COUNT(*) OVER(ORDER BY RenewalDate) FROM Insaurance



    

 





 












