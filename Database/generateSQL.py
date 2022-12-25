import yaml
import os

### Generate SQL INSERT for Maturity Levels

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\maturity_levels'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        matlvl = yaml.safe_load(file)

    desc = str(matlvl['description']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO maturitylevel VALUES('{}','{}','{}','{}','{}');".format(matlvl['id'], str(matlvl['number']), desc, str(matlvl['number']), str(matlvl['number']))
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()


f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()

### Generate SQL INSERT for Business Functions

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\business_functions'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        bfunc = yaml.safe_load(file)

    desc = str(bfunc['description']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO businessfunction VALUES('{}','{}','{}','{}');".format(bfunc['id'], bfunc['name'], desc, str(bfunc['order']))
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()


f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()

### Generate SQL INSERT for Security Practices

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\security_practices'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        secp = yaml.safe_load(file)

    shortDesc = str(secp['shortDescription']).replace("'", "''").replace("“","\"").replace("”","\"")
    longDesc = str(secp['longDescription']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO securitypractice VALUES('{}','{}','{}','{}','{}','{}','{}');".format(secp['id'], secp['name'], secp['shortName'], shortDesc, longDesc, secp['function'], str(secp['order']))
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()


f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()

### Generate SQL INSERT for Streams

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\streams'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)

    desc = str(prac['description']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO stream VALUES('{}','{}','{}','{}','{}');".format(prac['id'], prac['name'], desc, prac['letter'], str(prac['order']))
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()


f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()

### Generate SQL INSERT for Practice Level

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\practice_levels'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)

    objective = str(prac['objective']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO practicelevel VALUES('{}','{}','{}','{}','{}');".format(prac['id'], objective, "", prac['maturitylevel'], prac['practice'])
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()

f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()


### Generate SQL INSERT for Activity

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\activities'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)
    
    title = str(prac['title']).replace("'", "''").replace("“","\"").replace("”","\"")
    benefit = str(prac['benefit']).replace("'", "''").replace("“","\"").replace("”","\"")
    shortDesc = str(prac['shortDescription']).replace("'", "''").replace("“","\"").replace("”","\"")
    longDesc = str(prac['longDescription']).replace("'", "''").replace("“","\"").replace("”","\"")
    results = str(prac['results']).replace("'", "''").replace("“","\"").replace("”","\"")
    metrics = str(prac['metrics']).replace("'", "''").replace("“","\"").replace("”","\"")
    costs = str(prac['costs']).replace("'", "''").replace("“","\"").replace("”","\"")
    notes = str(prac['notes']).replace("'", "''").replace("“","\"").replace("”","\"")

    insert = "INSERT INTO activity VALUES('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}');".format(prac['id'],prac['stream'],prac['level'],title,benefit,shortDesc,longDesc,"","1",results,metrics,costs,notes)
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")
    f.close()

f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()

### Generate SQL INSERT for Answer Set, Answer Map, and Answer (because of how the YAML is structured)

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\answer_sets'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)

    id = prac['id']

    f = open("Database/insert_model.pgsql", "a")
    insert = "INSERT INTO AnswerSet VALUES('{}','{}','{}');".format(id, eachfile[0], "")
    f.write(insert + "\n")

    for answer in prac['values']:
        atext = str(answer['text']).replace("'", "''").replace("“","\"").replace("”","\"")
        insert = "INSERT INTO Answer VALUES('{}','{}','{}','{}','{}');".format(id+str(answer['order']), atext, str(answer['value']), str(answer['weight']), str(answer['order']))
        f.write(insert + "\n")
        insert = "INSERT INTO AnswerMap VALUES('{}','{}');".format(id, id+str(answer['order']))
        f.write(insert + "\n")
    
    f.close()

f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()


### Generate SQL INSERT for Assessment Question

source = r'C:\Users\BrianGlas\Projects\SAMM\core\model\questions'

for eachfile in os.listdir(source):
    with open(source + '\\' + eachfile,'r') as file:
        prac = yaml.safe_load(file)

    qtext = str(prac['text']).replace("'", "''").replace("“","\"").replace("”","\"")
    qdesc = str(prac['quality']).replace("'", "''").replace("“","\"").replace("”","\"")

    parts = eachfile[0:-4].split('-')
    count = 1
    code = ""
    temp = ""

    # Stupid hack because we didn't standardize on the non-standard coding systems in the toolbox
    for part in parts:
        if count < 3:
            code += str(part + "-")
        elif count == 3:
            temp = part
        elif count == 4:
            code += str(part + "-" + temp + "-1")
        count += 1

    insert = "INSERT INTO assessmentquestion VALUES('{}','{}','{}','{}','{}','{}','{}');".format(prac['id'], qtext, str(prac['order']), prac['activity'], prac['answerset'], code, qdesc)
    
    f = open("Database/insert_model.pgsql", "a")
    f.write(insert + "\n")

    insert = "INSERT INTO questionnairequestion VALUES('4','{}');".format(prac['id'])
    f.write(insert + "\n")

    f.close()

f = open("Database/insert_model.pgsql", "a")
f.write("\n")
f.close()


print("Done!")