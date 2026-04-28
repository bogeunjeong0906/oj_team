# grep 검색 템플릿 모음

## 1. 전체 폴더에서 키워드 검색
```sh
grep -rn '키워드' .
```

## 2. 여러 키워드 동시 검색
```sh
grep -rn 'foo\|bar\|baz' .
```

## 3. 특정 확장자만 검색
```sh
grep -rn --include='*.py' '키워드' .
```

## 4. 대소문자 구분 없이 검색
```sh
grep -rni '키워드' .
```

## 5. 결과에서 파일명만 추출
```sh
grep -rl '키워드' .
```

## 6. 검색 결과 줄 수 세기
```sh
grep -r '키워드' . | wc -l
```

## 7. 검색 결과 하이라이트
```sh
grep --color=auto -rn '키워드' .
```

---
- 복잡한 패턴은 정규표현식(egrep, grep -E) 활용
- 필요시 find, awk, sed 등과 조합 가능
