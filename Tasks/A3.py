from datetime import datetime

# Define possible date formats
date_formats = ["%Y-%m-%d", "%b %d, %Y", "%d-%m-%Y", "%Y/%m/%d"]

# Read the file
with open("/data/dates.txt", "r") as f:  # Adjust path if needed
    dates = [line.strip() for line in f]

def parse_date(date_str):
    for fmt in date_formats:
        try:
            return datetime.strptime(date_str, fmt)
        except ValueError:
            continue
    return None  # Return None if no format matches

# Count Wednesdays
wednesdays = sum(1 for date in dates if (dt := parse_date(date)) and dt.weekday() == 2)

# Write the count to the output file
with open("/data/dates-wednesdays.txt", "w") as f:
    f.write(str(wednesdays))

print(f"Total Wednesdays: {wednesdays}")
#