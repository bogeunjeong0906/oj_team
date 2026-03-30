# Summary

세 번째 연구 관점에서는 저장소 휴대성과 Python 실행 규칙을 점검했다. 기본 저장소 상태에서는 활성 request 폴더가 없어야 하고, Python 실행 시에는 repo-local 환경을 먼저 식별해야 한다.

## Scope Investigated

- 활성 request 폴더 정리 정책
- Beast Mode 전용 운영 시의 저장소 상태
- conda 기반 Python 환경 활성화 방식

## Codebase Facts

- request_0000 외의 request 폴더는 실제 작업 흔적이며 템플릿 자체는 아니다.
- 저장소를 다른 프로젝트에 붙여 쓸 때 기존 활성 request가 남아 있으면 오해를 만든다.
- 현재 저장소는 customization 중심이므로 Python 환경 규칙은 미래 작업을 위한 운영 가드레일에 가깝다.

## External or Domain Facts

- conda 공식 문서는 prefix 기반 환경을 `conda activate ./envs`처럼 활성화할 수 있다고 설명한다.
- conda는 활성화 없이 실행할 때 activation script와 환경 변수가 적용되지 않아 문제가 생길 수 있다고 경고한다.
- 실제 conda 환경이 아닌 venv 스타일 폴더는 native activation을 써야 한다.

## Constraints for Implementation

- Beast Mode 작업 자체로는 활성 request를 만들면 안 된다.
- 저장소 기본 상태는 request_0000만 남기는 방향이 적합하다.
- Python 실행 규칙은 conda 우선이되 가짜 conda 해석은 피해야 한다.

## Risks and Open Questions

- env-like 폴더 이름만 보고 무조건 conda activate를 시도하면 잘못된 환경을 깨울 수 있다.
- 따라서 conda env 판별과 native fallback을 함께 규정해야 한다.
