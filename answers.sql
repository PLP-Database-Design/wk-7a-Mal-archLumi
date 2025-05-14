-- Question 2 🧩
-- Transform the OrderDetails table into 2NF by removing partial dependencies

-- Step 1: Create a new table for Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

-- Step 2: Insert unique customers into the Customers table
INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName
FROM OrderDetails;

-- Step 3: Create the OrderDetails table without CustomerName
CREATE TABLE OrderDetails_2NF (
    OrderID INT NOT NULL,
    Product VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 4: Insert the data into the new OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity, CustomerID)
SELECT o.OrderID, o.Product, o.Quantity, c.CustomerID
FROM OrderDetails o
JOIN Customers c ON o.CustomerName = c.CustomerName;
