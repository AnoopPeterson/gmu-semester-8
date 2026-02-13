from analyze_standard_csv import analyze_standard_csv
from analyze_transposed_csv import analyze_transposed_csv
from count_silver_standard import count_silver_cars_standard
from count_silver_transposed import count_silver_cars_transposed

print("Standard CSV Analysis:")
analyze_standard_csv()
print("\nTransposed CSV Analysis:")
analyze_transposed_csv()
print("\nSilver Car Count (Standard CSV):")
count_silver_cars_standard()
print("\nSilver Car Count (Transposed CSV):")
count_silver_cars_transposed()
