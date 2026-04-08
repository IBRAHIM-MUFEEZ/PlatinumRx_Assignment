s = input()


def rem_dup(s):
    new_s = ""
    for char in s:
        if char not in new_s:
            new_s += char
    return new_s


print(rem_dup(s))
