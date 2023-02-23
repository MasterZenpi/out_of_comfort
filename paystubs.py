from pdfminer.high_level import extract_text
text = extract_text('Earnings.pdf')

#getts the pay period dates
date = text.split('\n')[47] + text.split('\n')[48]
