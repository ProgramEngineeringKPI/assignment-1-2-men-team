input_file = "premiere_league.csv"
into_file = "result.csv"

def parseFile(filename) :
    with open(filename) as file :
        res_array = file.read().split("\n")
        del res_array[-1]
        res_array = [x.split(",") for x in res_array]
        for i in range(len(res_array)):
            res_array[i][1:] = [x.split(":") for x in res_array[i][1:]]
    return res_array

def score(s1,s2):
    if(int(s1) > int(s2)): return 3
    if(int(s1) == int(s2)): return 1
    return 0

def main(array):
    for i in range(len(array)):
        array[i].append(0)
        for j in range(1,11):
            array[i][-1] += score(array[i][j][0],array[i][j][1])

def output(intoFile, array) :
    with open(intoFile, "a") as output :
        for x in range(len(array)) :
            output.write(array[x][0] + ","+ str(array[x][-1]) + "\n")

parsed = parseFile(input_file)
main(parsed)
output(into_file, parsed)
