import csv
import random
import string

# Current Honda models in circulation
HONDA_MODELS = [
    'Civic', 'Civic Hybrid', 'Accord', 'Accord Hybrid', 
    'CR-V', 'CR-V Hybrid', 'HR-V', 'Pilot', 
    'Passport', 'Odyssey', 'Ridgeline', 'Prologue'
]

# Common car colors
COLORS = [
    'White', 'Black', 'Silver', 'Gray', 'Blue', 
    'Red', 'Green', 'Brown', 'Beige', 'Yellow'
]

# Price ranges for different models (in dollars)
PRICE_RANGES = {
    'Civic': (15000, 28000),
    'Civic Hybrid': (25000, 32000),
    'Accord': (22000, 35000),
    'Accord Hybrid': (28000, 38000),
    'CR-V': (28000, 40000),
    'CR-V Hybrid': (32000, 42000),
    'HR-V': (24000, 32000),
    'Pilot': (38000, 52000),
    'Passport': (40000, 50000),
    'Odyssey': (35000, 48000),
    'Ridgeline': (38000, 48000),
    'Prologue': (48000, 58000)
}

def generate_vin():
    """Generate a random 10-character alphanumeric VIN"""
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))

def generate_car_data(num_cars=10000):
    """Generate random car data"""
    cars = []
    for _ in range(num_cars):
        model = random.choice(HONDA_MODELS)
        price_min, price_max = PRICE_RANGES[model]
        car = {
            'vin': generate_vin(),
            'model': model,
            'price': random.randint(price_min, price_max),
            'color': random.choice(COLORS)
        }
        cars.append(car)
    return cars

def write_standard_csv(cars, filename='honda_cars_standard.csv'):
    """Write standard CSV with rows as cars"""
    with open(filename, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['vin', 'model', 'price', 'color'])
        writer.writeheader()
        writer.writerows(cars)
    print(f"Standard CSV written to {filename}")

def write_transposed_csv(cars, filename='honda_cars_transposed.csv'):
    """Write transposed CSV with columns as cars"""
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        
        # Write each field as a row
        vins = [car['vin'] for car in cars]
        models = [car['model'] for car in cars]
        prices = [car['price'] for car in cars]
        colors = [car['color'] for car in cars]
        
        writer.writerow(vins)
        writer.writerow(models)
        writer.writerow(prices)
        writer.writerow(colors)
    
    print(f"Transposed CSV written to {filename}")

def main():
    print("Generating 10,000 Honda car records...")
    cars = generate_car_data(10000)
    
    print("Writing standard CSV (10,000 rows x 4 columns)...")
    write_standard_csv(cars)
    
    print("Writing transposed CSV (4 rows x 10,000 columns)...")
    write_transposed_csv(cars)
    
    print("\nDone! Both CSV files have been created.")

if __name__ == "__main__":
    main()
