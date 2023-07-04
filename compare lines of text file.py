# Requires installing python and 'pip install fuzzywuzzy'
# Import the csv module, which provides functionality to both read from and write to CSV files
import csv
# Import the fuzz module from fuzzywuzzy, which is used for string matching
from fuzzywuzzy import fuzz

# Define a function named fuzzy_compare with four parameters: file1, file2, output_file and a threshold for match ratio (default value set to 80)
def fuzzy_compare(file1, file2, output_file, threshold=80):
    # Open the first file for reading and assign it to the variable f1. Do the same for the second file and assign it to f2.
    # 'with' keyword in python is used in exception handling to make the code cleaner and much more readable. It simplifies the management of common resources like file streams.
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        # Read all lines from the first and second file and store them in f1_lines and f2_lines respectively
        f1_lines = f1.readlines()
        f2_lines = f2.readlines()

    # Create an empty list to store matching line details
    matches = []

    # Loop over each line in the first file
    for i, line1 in enumerate(f1_lines):
        # For each line in the first file, loop over each line in the second file
        for j, line2 in enumerate(f2_lines):
            # Calculate the fuzzy match ratio between the current line in the first file and the current line in the second file
            ratio = fuzz.ratio(line1.strip(), line2.strip())
            # If the match ratio is greater than or equal to the threshold, append the line number from file1, the content from file1, the line number from file2, the content from file2 and the match ratio to the matches list
            if ratio >= threshold:
                matches.append((i+1, line1.strip(), j+1, line2.strip(), ratio))

    # Open the output file for writing
    with open(output_file, 'w', newline='') as f:
        # Create a CSV writer object
        writer = csv.writer(f)
        # Write the header row to the CSV file
        writer.writerow(["File1_Line_Number", "File1_Content", "File2_Line_Number", "File2_Content", "Match_Ratio"])
        # Write all the match details to the CSV file
        writer.writerows(matches)

# Call the fuzzy_compare function with the paths to the first file, the second file and the output file
fuzzy_compare(r'C:\path\to\file1.txt', r'C:\path\to\file2.txt', r'C:\path\to\output.csv')
