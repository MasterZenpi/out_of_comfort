from pdfminer.high_level import extract_text
text = extract_text('Earnings.pdf')

#getts the pay period dates
date = text.split('\n')[47] + text.split('\n')[48]


import os
import PyPDF2

# specify the folder path
folder_path = "path/to/folder"

# list all files in the folder
files = os.listdir(folder_path)

# filter for only the PDF files
pdf_files = [f for f in files if f.endswith('.pdf')]

# loop through each PDF file and open it
for file in pdf_files:
    # create a PDF reader object
    pdf_reader = PyPDF2.PdfFileReader(open(os.path.join(folder_path, file), 'rb'))

    # loop through each page of the PDF file
    for page_num in range(pdf_reader.numPages):
        # extract the text from the page
        page_text = pdf_reader.getPage(page_num).extractText()

        # do something with the page text (e.g. print it)
        print(page_text)
