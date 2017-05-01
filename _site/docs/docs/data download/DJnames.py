citi_data_name = []

year = ["2013", "2014", "2015", "2016"]

for y in year:
    for i in range(12):
        if i < 9:
            citi_data_name.append(y + "0" + str(i + 1))
        else:
            citi_data_name.append(y + str(i + 1))


for ny in range(6):
    citi_data_name.remove("20130" + str(ny + 1))
            

print(citi_data_name)



#f = open("citiDataName.csv", "w")
#for i in range(len(citi_data_name)):
#    print(citi_data_name[i])
#    f.write(citi_data_name[i] + '\n')
    
#f.close()
