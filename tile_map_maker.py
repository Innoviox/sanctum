import os, string

direc = "/Users/chervjay/Documents/GitHub/sanctum/swift/kavonia/kavonia/art.scnassets"


_, _, files = next(os.walk(direc))
files = list(map(lambda i: i.split(".")[0], filter(lambda i: i.endswith(".obj"), files)))

s = "let tile_map = [\n"
for a, b in zip(string.ascii_uppercase + string.ascii_letters, files):
    s += f'\t"{a}": "{b}",\n'
s += "]"
print(s)
