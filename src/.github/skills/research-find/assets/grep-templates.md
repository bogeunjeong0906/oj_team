# research-find 검색 템플릿 모음

## 1. traceback 또는 예외 원인 찾기
```sh
rg -n 'ExceptionName|function_name|error message' .
```

## 2. 특정 링크의 입출력 경로 찾기
```sh
rg -n 'acquire|load|store|save|render' src
```

## 3. 특정 심볼의 controlling path 찾기
```sh
rg -n --glob '*.py' 'symbol_name' .
```

## 4. 대체 후보 또는 중복 구현 찾기
```sh
rg -n 'new_path|old_path|legacy|deprecated|fallback' .
```

## 5. dead path 의심 경로만 파일명으로 보기
```sh
rg -l 'legacy|obsolete|deprecated|unused|fallback' .
```

## 6. 특정 디렉터리와 확장자로 제한하기
```sh
rg -n --glob 'src/**/*.py' 'keyword' .
```

## 7. 여러 신호를 한 번에 좁게 찾기
```sh
rg -n 'foo|bar|baz' .
```

- 너무 넓은 결과가 나오면 디렉터리, 파일 타입, 심볼 단위로 즉시 좁힌다.
- 검색 결과는 다음 인접 코드 읽기나 검증으로 바로 연결한다.
