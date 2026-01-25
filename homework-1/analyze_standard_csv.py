import csv
import time

def analyze_standard_csv(filename='honda_cars_standard.csv'):
    """
    Read through each row in the standard CSV file,
    extract the price (3rd element), and compute the average.
    Returns the time taken for the operation.
    """
    start_time = time.time()
    
    prices = []
    
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        next(reader)  # Skip header row
        
        for row in reader:
            # Extract the third element (index 2), which is the price
            price = int(row[2])
            prices.append(price)
    
    # Calculate average
    average_price = sum(prices) / len(prices)
    
    end_time = time.time()
    elapsed_time = end_time - start_time
    
    print(f"Standard CSV Analysis (Row-based):")
    print(f"  Total cars processed: {len(prices)}")
    print(f"  Average price: ${average_price:,.2f}")
    print(f"  Time taken: {elapsed_time:.6f} seconds")
    
    return elapsed_time

if __name__ == "__main__":
    analyze_standard_csv()
