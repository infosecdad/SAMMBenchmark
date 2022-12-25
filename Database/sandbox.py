import yaml
import os

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\questions'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)

    qtext = str(prac['text']).replace("'", "''").replace("“","\"").replace("”","\"")
    qdesc = str(prac['quality']).replace("'", "''").replace("“","\"").replace("”","\"")

    print(eachfile[0:-4])
    parts = eachfile[0:-4].split('-')
    count = 1
    code = ""
    temp = ""

    for part in parts:
        if count < 3:
            code += str(part + "-")
        elif count == 3:
            temp = part
        elif count == 4:
            code += str(part + "-" + temp + "-1")
        count += 1

    print(code)

    insert = "INSERT INTO assessmentquestion VALUES('{}','{}','{}','{}','{}','{}','{}');".format(prac['id'], qtext, str(prac['order']), prac['activity'], prac['answerset'], code, qdesc)
    
    print(insert)

    print("\n")
    #print(prac)