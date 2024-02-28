def json_to_csv(json_data):
    csv_data = []
    if json_data:
        keys = list(json_data.keys())
        csv_data.append(keys)
        row = []
        for key in keys:
            row.append(json_data[key])
        csv_data.append(row)
    return csv_data