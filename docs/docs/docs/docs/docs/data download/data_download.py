import urllib.request
import DJnames
import ssl
import zipfile
import os
import glob

# This restores the same behavior as before.
context = ssl._create_unverified_context()
names = DJnames.citi_data_name

# download zip-file from citi
os.chdir("/Users/Hongbo/Desktop/DataVizProject/zip_file")
for i in range(0 , len(names)):
    url = "https://s3.amazonaws.com/tripdata/" + names[i] + "-citibike-tripdata.zip"
    response = urllib.request.urlopen(url, context=context)

    f = open( names[i] + ".zip", "wb")
    html = response.read()
    f.write(html)
    f.close()

# unizip file
directory_to_extract_to = "/Users/Hongbo/Desktop/DataVizProject/citi_data"
for i in range(0 , len(names)):
    path_to_zip_file = "/Users/Hongbo/Desktop/DataVizProject/zip_file/" + names[i] + ".zip"
    zip_ref = zipfile.ZipFile(path_to_zip_file, 'r')
    zip_ref.extractall(directory_to_extract_to)
    zip_ref.close()

# rename
os.chdir("/Users/Hongbo/Desktop/DataVizProject/citi_data")
for filename in os.listdir("."):
    if filename.startswith("2"):
        os.rename(filename, filename.replace("-", "")[0:6] + ".csv")

# merge files
#interesting_files = glob.glob("*.csv") 
#header_saved = False
#with open('output.csv','w') as fout:#
#    for filename in interesting_files:
#        with open(filename) as fin:
#            header = next(fin)
#            if not header_saved:
 #               noprinting = fout.write(header)
#                header_saved = True
 #           for line in fin:
 #               noprinting = fout.write(line)
