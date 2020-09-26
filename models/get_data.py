import os
import random as random
import pandas as pd
import xml.etree.ElementTree as et
import numpy as np

df_cols = ["C0t", "C0v",
           "N1t", "N1v", "N2t", "N2v",
           "S1t", "S1v", "S2t", "S2v",
           "T1t", "T1v", "T2t", "T2v",
           "I1t", "I1v", "I2t", "I2v", "res"
           ]


def citire_date():
    rows = []
    directory = "/home/liana/Desktop/licenta/dataSet"
    results = []
    df = df = pd.DataFrame(columns=df_cols)
    nFile = open("normalExamples", "w")
    drFile = open("drExamples", "w")
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.xml'):
                tree = et.parse(os.path.join(root, file))
                if os.path.join(root, file).find('DMLV') > 0:
                    result = 2
                else:
                    if os.path.join(root, file).find('Normal') > 0:
                        result = 0
                    else:
                        if os.path.join(root, file).find('Retinopatie diabetica') > 0:
                            result = 1
                        else:
                            result = -1
                xroot = tree.getroot()
                row = [0] * 18
                count = 0
                for child in xroot.findall('./BODY/Patient/Study/Series/ThicknessGrid/Zone'):
                    if (child.find('Volume') != None):
                        if (child.find('AvgThickness') != None):
                            if (child.find('Name') != None):
                                if (child.find('Volume').text != None):
                                    volume = float(child.find('Volume').text)
                                    if (child.find('AvgThickness').text != None):
                                        avgthickness = float(child.find('AvgThickness').text)
                                        if (child.find('Name').text != None):
                                            name1 = str(child.find('Name').text) + 't'
                                            name2 = str(child.find('Name').text) + 'v'
                                            indxt = df.columns.get_loc(name1)
                                            row[indxt] = avgthickness
                                            indxv = df.columns.get_loc(name2)
                                            row[indxv] = volume
                                            count = count + 1

                # print(row)
                idx = 0
                if result == 0:
                    for i in row:
                        nFile.write(df_cols[idx] + " " + str(i) + " ")
                        idx = idx + 1
                nFile.write("\n")
                if result == 1:
                    for i in row:
                        drFile.write(df_cols[idx] + " " + str(i) + " ")
                        idx = idx + 1
                drFile.write("\n")

                if row and (count == 9):
                    if (
                            result != 2):  # result = 2 => pacientul are DMLV, iar pacienti cu DMLV sunt mult mai multi in setul de date
                        for i in range(
                                10):  # pentru restul datelor am mai adaugat cate 10 linii in setul de date cu valori similare
                            new_row = []
                            for c in row:
                                no = random.randrange(0, 10, 1) / 10000
                                new_row.append(c)
                            new_row.append(result)
                            rows.append(new_row)
                            results.append(result)
                    if count == 9:
                        row.append(int(result))
                        results.append(result)
                        rows.append(row)
                        df.append(row)
    df = pd.DataFrame(rows, columns=df_cols)
    print(df)

    return df, results
