import csv
import time

def analyze_transposed_csv(filename='honda_cars_transposed.csv'):
    """
    Read the transposed CSV file, extract the third row (prices),
    and compute the average.
    Returns the time taken for the operation.
    """
    start_time = time.time()
    
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        
        # Read all rows
        rows = list(reader)
        
        # Extract the third row (index 2), which contains all prices
        price_row = rows[2]
        
        # Convert to integers and calculate average
        prices = [int(price) for price in price_row]
        average_price = sum(prices) / len(prices)
    
    end_time = time.time()
    elapsed_time = end_time - start_time
    
    print(f"Transposed CSV Analysis (Column-based):")
    print(f"  Total cars processed: {len(prices)}")
    print(f"  Average price: ${average_price:,.2f}")
    print(f"  Time taken: {elapsed_time:.6f} seconds")
    
    return elapsed_time

if __name__ == "__main__":
    analyze_transposed_csv()
