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
    failed = []
    for i in range(len(array)):
        array[i].append(0)
        for j in range(1,len(array[i])-1):
            check = valid(array[i][j][0],array[i][j][1])
            if check == False:
                failed.append(array[i][j])
            else:
                array[i][-1] += score(array[i][j][0],array[i][j][1])
    return failed

def output(intoFile, array) :
    with open(intoFile, "a") as output :
        for x in range(len(array)) :
            output.write(array[x][0] + ","+ str(array[x][-1]) + "\n")

def valid(s1,s2):
    try:
        s1_valid = int(s1)
        s2_valid = int(s2)
        if(s1_valid < 0 or s2_valid < 0):
            print "Exception! Only numbers available."
            return False
        return True
    except ValueError:
        print "Exception! Only numbers available."
        return False

parsed = parseFile(input_file)
failed = main(parsed)
print(failed)
output(into_file, parsed)
