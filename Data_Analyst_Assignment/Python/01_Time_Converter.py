minutes = int(input())


def convert_minutes(minutes):
    hours = minutes // 60
    mins = minutes % 60

    if hours > 0:
        if hours == 1:
            return f"{hour}hr {mins}minutes"
        else:
            return f"{hours} hrs {mins} minutes"
    else:
        return f"{mins} minutes"


print(convert_minutes(minutes))
