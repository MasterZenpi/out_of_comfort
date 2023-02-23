import tabula
from pdfminer.high_level import extract_text
import os
import pdfplumber

# specify the folder path
folder_path = "sierra_hours"

# list all files in the folder
files = os.listdir(folder_path)

# filter for only the PDF files
pdf_files = [f for f in files if f.endswith('.pdf')]

# loop through each PDF file and open it
for file in pdf_files:
    # create a PDF object
    with pdfplumber.open(os.path.join(folder_path, file)) as pdf:

        tables = tabula.read_pdf(file, pages='all')
        text = extract_text(file)
        df = tables[0]
        #hours worked in one pay period  
        hours = df.iloc[1][1]
  
        #getts the pay period dates
        date = text.split('\n')[47] + text.split('\n')[48]
        new_row = {date:hours}
