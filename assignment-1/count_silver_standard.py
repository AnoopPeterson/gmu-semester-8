import csv
import time

def count_silver_cars_standard(filename='honda_cars_standard.csv'):
    """
    Read through each row in the standard CSV file,
    extract the color (4th element), and count silver cars.
    Returns the time taken for the operation.
    """
    start_time = time.time()
    
    silver_count = 0
    total_count = 0
    
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        next(reader)  # Skip header row
        
        for row in reader:
            total_count += 1
            # Extract the fourth element (index 3), which is the color
            color = row[3]
            if color == 'Silver':
                silver_count += 1
    
    end_time = time.time()
    elapsed_time = end_time - start_time
    
    print(f"Standard CSV Analysis (Row-based) - Silver Car Count:")
    print(f"  Total cars processed: {total_count}")
    print(f"  Silver cars found: {silver_count}")
    print(f"  Percentage: {(silver_count/total_count)*100:.2f}%")
    print(f"  Time taken: {elapsed_time:.6f} seconds")
    
    return elapsed_time

if __name__ == "__main__":
    count_silver_cars_standard()
