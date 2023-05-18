# jaguar_udf
jaguar 에서 사용되는 udf 명령어를 사용하는데 도와주는 web 입니다


## Using for UDF cmd

이 웹 사이트는 Jaguar 의 udf 함수를 좀 더 쉽게 관리하기 위해 제작하였습니다

### 예시 test_udf.py
```
import polars as pl
import pandas as pd


def run(df: pl.DataFrame, args: str) -> pl.DataFrame:
    """
    Write your function

    if you want to use pandas dataframe, exchange from pl.DataFrame to pd.DataFrame
    ex:) pdf = df.to_pandas()
    """
    df = df.select("TEL")

    return df

```

### 주의사항
이 web 은 portotype 임으로 사용법의 순서에 맞게 동작해야합니다

### 사용법

####  Get Udf List
1. User ID 에 사용자의 ID 를 작성합니다
2. 확인을 누릅니다
3. Get Udf List 버튼을 클릭합니다

####  Get Udf Detail
1. User ID 에 사용자의 ID 를 작성합니다
2. File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다
3. File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다
4. 확인을 누릅니다
5. Get Udf Detail 버튼을 클릭합니다

####  Delete Udf File
1. User ID 에 사용자의 ID 를 작성합니다
2. File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다
3. File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다
4. 확인을 누릅니다
5. Delete Udf File 버튼을 클릭합니다

####  Upload Udf File
1. User ID 에 사용자의 ID 를 작성합니다
2. File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다
3. File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다
4. 확인을 누릅니다
5. Upload Udf File 버튼을 클릭합니다
6. 업로드할 파일을 선택합니다

### 명령어 예시
```
* | udf func_name='only_TEL' func_owner='root'
* | udf func_name='only_TEL' func_owner='root' args='col1='학년_A', col2='학교A''
```
