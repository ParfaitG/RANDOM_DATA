
import os
import numpy as np
import pandas as pd
import datetime as dt
import time

cd = os.path.dirname(os.path.abspath(__file__))
LETTERS = list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

epoch_time = int(time.time())


for i in range(1,11):
    df = pd.DataFrame({'ID': [np.random.randint(15) for _ in range(50)],
                       'GROUP': ["".join(np.random.choice(LETTERS,1)) for _ in range(50)],
                       'NUM1': np.random.randn(50)*100,
                       'NUM2': np.random.randn(50),
                       'BOOL': [np.random.choice([True,False],1).item(0) for _ in range(50)],
                       'DATE': [dt.datetime.fromtimestamp(np.random.randint(epoch_time)) for _ in range(50)]},
                      columns = ['ID','GROUP','DATE','NUM1','NUM2','BOOL'])
                       
    df.to_csv(os.path.join(cd, 'RandomData_PY_'+str(i)+'.csv'))


