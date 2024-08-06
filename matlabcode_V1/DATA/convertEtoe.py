def convert_E_to_e(input_file, output_file):
    with open(input_file, 'r') as file:
        data = file.read()

    # Replace all "E" with "e"
    data = data.replace('E', 'e')

    with open(output_file, 'w') as file:
        file.write(data)

# Example usage
input_file = '01_DATA_30_YEARS_DAILY.txt'
output_file = '01_DATA_30_YEARS_DAILY_converted.txt'
convert_E_to_e(input_file, output_file)
