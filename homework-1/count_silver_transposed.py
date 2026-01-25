import csv
import time

def count_silver_cars_transposed(filename='honda_cars_transposed.csv'):
    """
    Read the transposed CSV file, extract the fourth row (colors),
    and count silver cars.
    Returns the time taken for the operation.
    """
    start_time = time.time()
    
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        
        # Read all rows
        rows = list(reader)
        
        # Extract the fourth row (index 3), which contains all colors
        color_row = rows[3]
        
        # Count silver cars
        silver_count = color_row.count('Silver')
        total_count = len(color_row)
    
    end_time = time.time()
    elapsed_time = end_time - start_time
    
    print(f"Transposed CSV Analysis (Column-based) - Silver Car Count:")
    print(f"  Total cars processed: {total_count}")
    print(f"  Silver cars found: {silver_count}")
    print(f"  Percentage: {(silver_count/total_count)*100:.2f}%")
    print(f"  Time taken: {elapsed_time:.6f} seconds")
    
    return elapsed_time

if __name__ == "__main__":
    count_silver_cars_transposed()
