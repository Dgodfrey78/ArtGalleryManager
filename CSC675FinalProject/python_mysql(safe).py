from  datetime import datetime
from datetime import timedelta
def show_menu():
    """
    Prints in console the main menu
    :return: VOID
    """
    print("User Menu \n"
          "1. Create Account \n"
          "2. Login \n"
          "3. Search \n"
          "4. Insert \n"
          "5. Update \n"
          "6. Delete \n"
          "7. Exit \n")
def show_table_names(tables):
    """
    Show all the tables names
    :param tables: a list with the tables names.
                   You can get it by calling the method
                   get_table_names() from DB object
    :return: VOID
    """
    index = 1
    print("\nTables:")
    for table in tables:
        print(table[0])  # print tables names
        index += 1
def find_id_number(db_object,table,attribute):
  """
    Finds the next available Unique ID number for any table
  """

  #get a list of all ID's from the table
  query = """SELECT {} FROM {}""".format(attribute,table)
  results = db_object.select(query=query)
  index=0
  #if known exists go with 0
  if results == ():
    return index
  
  match = False
  #Search each number until an unused ID is found
  while match == False:
    for result in results:
      match=False
      if index == result[0]:
        
        index=index+1
        break
      match=True

      
  #return ID index
  return index

    

def option1(db_object):
  try:
    #Collect User Account Information
    acctType=input("\nWhat Type of Account is this: 1. Visistor or 2. Manager?(Type Number please)")
    username=input("\nChoose a username: ")
    password=input("\nChoose a password: ")
    name=input("\nWhat is your name? ")
    email=input("\nWhat is your Email? ")

    #get Unique ids for a new  account and a new user
    userid=str(find_id_number(db_object,"User","userid"))
    acctId=str(find_id_number(db_object,"Account","acctId"))
    
    #insert new user  
    db_object.insert(table='User', attributes=('userid','Name','Email'),values=(userid,name,email))
    #insert new account with userId as foerign key
    db_object.insert(table='Account',attributes=('acctId','username','acctType','password','userId'),values=(acctId,username,acctType,password,userid))
    update_session(db_object,userid)
  #if failed run option1 again
  except Exception as err:
    print(err)
    option1(db_object)

#Update Session with a thirty minute time window of use until asking for password again
def update_session(db_object, userid):
  #get unique session ID
  sessionId=str(find_id_number(db_object,"session","sessionId"))
  #calculate the current time of session update
  now = datetime.now()

  #add 30 minutes
  expires = now + timedelta(minutes=30)
  exp= expires.strftime('%Y-%m-%d %H:%M:%S')

  user=userid[0]
  userId=str(user[0])

  

#Add new session, before being able to use option after 30 minutes you must resign in
  try:
    db_object.insert(table='session', attributes=('sessionId','userSessionId','expires'), values=(sessionId,userId,exp))

  except Exception as err:
    print(err)



def option2(db_object):
  #get username and password
  username = input("\nUsername: ")
  password = input("\nPassword: ")
  query="""SELECT * FROM Account WHERE username = '{}' and password = '{}'""".format(username,password)
  try:
    #search for username and password combo as username is Unique
    account= db_object.select(query=query)


  except Exception as err:
    print(err)
    

  if account == ():
    #restart if not found
    print("Password/Username combination does not exist\n")
    option2(db_object)
  # get the user ID from the account 
  userIdquery="""SELECT userId FROM Account WHERE username = '{}' and password = '{}'""".format(username,password)
  userid=db_object.select(query=userIdquery)

  #update session time of login
  update_session(db_object,userid)
  return 

#Search for a entity by specifying search parameters
def option3(db_object):
  now = datetime.now()
  expire = now.strftime('%Y-%m-%d %H:%M:%S')
  try:
    #create query for current session
    query= """SELECT userSessionId FROM session WHERE expires > '{}'""".format(expire)

    #query sessoions for current userId
    userId=db_object.select(query=query)
    
    #if query is empty no one is signed in
    if userId==():
      print("You're Not Logged In")
      option2(db_object)
      option3(db_object)
    userId1=userId[0]
    userId2=str(userId1[0])

    #find acctType by querying account
    acctTypeQuery="""SELECT acctType FROM Account WHERE userId = '{}'""".format(userId2)
    userAcctType= db_object.select(query=acctTypeQuery)
    acctId1=userAcctType[0]
    acctId2=str(acctId1[0])
    #get the tables that the user have access to Read
    featureQuery="""SELECT feature FROM accountFeatures WHERE accountType = '{}'""".format(acctId2)
    featureId=db_object.select(query=featureQuery)
  
    tableList=[]
    tables=[]
    permissiveTables=[]
    for feature in featureId:
      tableList.append(feature[0])
      
    for tabled in tableList:
      tables.append(db_object.select(query="""SELECT tables FROM feature WHERE featureId = '{}' AND permission = 'Read'""".format(str(tabled))))
     
    for tabs in tables:
      for t in tabs:
        if t[0]!= ():
          permissiveTables.append(t[0])
  except Exception as err:
    print(err)
  #display the names of the tales with permissions to choose from
  print("Tables with Search Permission")
  count=0
  for search in permissiveTables:
    print("""{}. {}""".format((count+1),search ))
    count=count+1
  try:
    userSearch= int(input("Type the number of the table you would like to search in? "))
    searchTable = permissiveTables[(userSearch-1)]
    #display fields for search criteria
    columns = db_object.get_column_names(searchTable)
    print("Fields in this Table: ")
    for column in columns:
      print(column[0])
  except Exception as err:
    print("Number must be in the range.")
    option3(db_object)

  #get search criteria
  fieldSearch = input("Field: ")
  valueSearch= input("Value: ")
  try:
    searched = db_object.select(query="""SELECT * FROM {} WHERE {} = '{}'""".format(permissiveTables[(userSearch-1)],fieldSearch,valueSearch))
    if searched ==():
      print("No results Found")
    find=searched[0]
    counting=0
    for column in columns:
      print("""{}: {}""".format(column[0],find[counting]))
      counting= counting+1
    return
  except Exception as err:
    print("No results Found")
    
    return



def option4(db_object):
  now = datetime.now()
  expire = now.strftime('%Y-%m-%d %H:%M:%S')
  try:
    #create query for current session
    query= """SELECT userSessionId FROM session WHERE expires > '{}'""".format(expire)

    #query sessoions for current userId
    userId=db_object.select(query=query)

    #if query is empty no one is signed in
    if userId==():
      print("You're Not Logged In")
      option2(db_object)
      option4(db_object)
    #find acctType by querying account
    userId1=userId[0]
    userId2=str(userId1[0])
    acctTypeQuery="""SELECT acctType FROM Account WHERE userId = '{}'""".format(userId2)
    userAcctType= db_object.select(query=acctTypeQuery)
    acctId1=userAcctType[0]
    acctId2=str(acctId1[0])
  
    featureQuery="""SELECT feature FROM accountFeatures WHERE accountType = '{}'""".format(acctId2)
    featureId=db_object.select(query=featureQuery)

    tableList=[]
    tables=[]
    permissiveTables=[]
    #get the tables that the user have access to Write
    for feature in featureId:
      tableList.append(feature[0])
    
    for tabled in tableList:
      tables.append(db_object.select(query="""SELECT tables FROM feature WHERE featureId = '{}' AND permission = 'Write'""".format(str(tabled))))
      
    for tabs in tables:
      for t in tabs:
        if t[0]!= ():
          permissiveTables.append(t[0])
  except Exception as err:
    print(err)
  #display the names of the tales with permissions to choose from
  print("Tables with Write Permission")
  count=0
  for search in permissiveTables:
    print("""{}. {}""".format((count+1),search ))
    count=count+1
  #get the table being added to 
  try:
    userSearch= int(input("Type the number of the table you would like to delete from? "))
    searchTable = permissiveTables[(userSearch-1)]
  except Exception as err:
    print("Number must be in the range.")
    option4(db_object)
  columns = db_object.get_column_names(searchTable)

  fieldList = []
  valueList = []
  #display fields for input values 
  print("Fields in this Table: ")
  for column in columns:
    print(column[0])
    fieldList.append(column[0])
    valueList.append(input("Input value:"))


  fieldTuple = tuple(fieldList)
  valueTuple = tuple(valueList)
  #insert values into table
  try:
    db_object.insert(table=searchTable,attributes=fieldTuple,values=valueTuple)
  except Exception as err:
    print("Add error occurred: Make sure all field values are correct")
  #searched = db_object.select(query="""SELECT * FROM {} WHERE {} = '{}'""".format(permissiveTables[(userSearch-1)],fieldSearch,valueSearch))
  #print(searched)

#get a comma seperate string of table fields from user
def get_update_fields():
  attributes_str= input("Enter field names seperate by comma: ")
  valuesStr= input("Enter values in same order: ")

  if "," in attributes_str:  # multiple attributes
    attributes = attributes_str.split(",")
    values = valuesStr.split(",")
  else:  # one attribute
    attributes = attributes_str
    values = valuesStr
    setState="""{} = '{}'""".format(attributes,values)
    return setState

  counter = 0;
  setState=[]
  try:
    for attribute in attributes:
      setState.append("""{} = '{}'""".format(attribute,values[counter]))
      counter=counter+1;
    setStateStr=", ".join(setState)
  
    return setStateStr
  except Exception as err:
    print("Input Fields incorrect")

  #get a comma seperate string of conditions from user

def get_condition_fields():
  attributes_str= input("Enter field names seperate by comma: ")
  valuesStr= input("Enter values in same order: ")

  if "," in attributes_str:  # multiple attributes
    attributes = attributes_str.split(",")
    values = valuesStr.split(",")
  else:  # one attribute
    attributes = attributes_str
    values = valuesStr
    setState="""{} ='{}'""".format(attributes,values)
    return setState

  
  counter = 0;
  setState=[]
  try:
    for attribute in attributes:
      setState.append("""{} = '{}'""".format(attribute,values[counter]))
      counter=counter+1;
    setStateStr=" AND ".join(setState)
  
    return setStateStr
  except Exception as err:
    print("Input Fields incorrect")


#Update the value of a row in a table
def option5(db_object):
  now = datetime.now()
  expire = now.strftime('%Y-%m-%d %H:%M:%S')
  try:
    #create query for current session
    query= """SELECT userSessionId FROM session WHERE expires > '{}'""".format(expire)

    #query sessoions for current userId
    userId=db_object.select(query=query)
    #if query is empty no one is signed in
    if userId==():
      print("You're Not Logged In")
      option2(db_object)
      option5(db_object)
    #get account type 
    userId1=userId[0]
    userId2=str(userId1[0])
    acctTypeQuery="""SELECT acctType FROM Account WHERE userId = '{}'""".format(userId2)
    userAcctType= db_object.select(query=acctTypeQuery)
    acctId1=userAcctType[0]
    acctId2=str(acctId1[0])

    #get the tables that the account has Write access to
    featureQuery="""SELECT feature FROM accountFeatures WHERE accountType = '{}'""".format(acctId2)
    featureId=db_object.select(query=featureQuery)

    tableList=[]
    tables=[]
    permissiveTables=[]

    for feature in featureId:
      tableList.append(feature[0])
      
    for tabled in tableList:
      tables.append(db_object.select(query="""SELECT tables FROM feature WHERE featureId = '{}' AND permission = 'Write'""".format(str(tabled))))
      
    for tabs in tables:
      for t in tabs:
        if t[0]!= ():
          permissiveTables.append(t[0])
  except Exception as err:
    print(err)
  #display tables
  print("Tables with Write Permission")
  count=0
  for search in permissiveTables:
    print("""{}. {}""".format((count+1),search ))
    count=count+1
  #get table that user is updating
  try:
    userSearch= int(input("Type the number of the table you would like to update: "))
    searchTable = permissiveTables[(userSearch-1)]
    columns = db_object.get_column_names(searchTable)
    print("Fields in this Table: ")
    for column in columns:
      print(column[0])
  except Exception as err:
    print("Number must be in the range.")
    option5(db_object)
  
  


  #display fields in chosen table

  

  #get condition and values for the updated table
  print("Which rows do you want to change? ")
  conditionsQuery= get_condition_fields()
  print(conditionsQuery)
  print("What values do you want to add?")
  updateQuery= get_update_fields()
  upQuery="""UPDATE {} SET {} WHERE {}""".format(searchTable,updateQuery,conditionsQuery)
  print(upQuery)
  
  #update values
  try:
    db_object.update(query=upQuery)
  except Exception as err:
    print(err)
  #searched = db_object.select(query="""SELECT * FROM {} WHERE {} = '{}'""".format(permissiveTables[(userSearch-1)],fieldSearch,valueSearch))
  #print(searched)

#Delete a row from a table based on search criteria
def option6(db_object):
  now = datetime.now()
  expire = now.strftime('%Y-%m-%d %H:%M:%S')
  try:
    #create query for current session
    query= """SELECT userSessionId FROM session WHERE expires > '{}'""".format(expire)

    #query sessoions for current userId
    userId=db_object.select(query=query)

    #if query is empty no one is signed in
    if userId==():
      print("You're Not Logged In")
      option2(db_object)
      option6(db_object)
    #get the accountType of the logged in user
    userId1=userId[0]
    userId2=str(userId1[0])
    acctTypeQuery="""SELECT acctType FROM Account WHERE userId = '{}'""".format(userId2)
    userAcctType= db_object.select(query=acctTypeQuery)
    acctId1=userAcctType[0]
    acctId2=str(acctId1[0])
    #get tables with read access
    featureQuery="""SELECT feature FROM accountFeatures WHERE accountType = '{}'""".format(acctId2)
    featureId=db_object.select(query=featureQuery)

    tableList=[]
    tables=[]
    #show tables available to delete
    permissiveTables=[]
    for feature in featureId:
      tableList.append(feature[0])
      
    for tabled in tableList:
      tables.append(db_object.select(query="""SELECT tables FROM feature WHERE featureId = '{}' AND permission = 'Write'""".format(str(tabled))))

    for tabs in tables:
      for t in tabs:
        if t[0]!= ():
          permissiveTables.append(t[0])
  except Exception as err:
    print(err)
  print("Tables with Write Permission")
  count=0
  for search in permissiveTables:
    print("""{}. {}""".format((count+1),search ))
    count=count+1
  #get target table for deleteing
  try:
    userSearch= int(input("Type the number of the table you would like to delete from? "))
    searchTable = permissiveTables[(userSearch-1)]
  except Exception as err:
    print("Number must be in the range.")
    option6(db_object)
  columns = db_object.get_column_names(searchTable)

  fieldList = []
  valueList = []
  #display fields 
  print("Fields in this Table: ")
  for column in columns:
    print(column[0])

  #get conditions for the delete
  print("Which rows do you want to delete? ")
  conditionsQuery= get_condition_fields()
  
  deleteQuery="""DELETE FROM {}  WHERE {}""".format(searchTable,conditionsQuery)
  print(deleteQuery)
  

  try:

    db_object.delete(query=deleteQuery)
  except Exception as err:
    print(err)


####Driver Program.....

from database import DB

print("Setting up the database.......\n")

db = DB(config_file="sqlconfig.conf.py")


database= "ArtGalleryManagementDB"


tempUserID=find_id_number(db,"User","userid")


#option1(db,tempUserID)
#option2(db)
#option3(db)
#option4(db

show_menu()
option = int(input("Select one option from the menu: "))
#db._execute_query(query="INSERT INTO session ( sessionId, userSessionId, expires ) VALUES ( 25, 5, 2020-08-06 02:40:35 )",values=())
while option != 7:
    if option == 1:
      option1(db)  # create your account
    elif option == 2:
      option2(db)
    elif option == 3:
      option3(db)
    elif option == 4:
      option4(db)
    elif option == 5:
      option5(db)
    elif option == 6:
      option6(db)


    show_menu()
    option = int(input("Select one option from the menu: "))



