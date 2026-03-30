# Summary

두 번째 조사 관점에서는 Builder-Reviewer 하이브리드와 request 번호 결정 규칙이 실제 운영에서 충돌 없이 작동하는지 점검했다.

## Scope Investigated

- Builder와 Reviewer의 입력 시야 차이
- request_0000 템플릿과 active request의 분리
- request 번호 재사용과 신규 발급의 판단 기준

## Codebase Facts

- role-boundaries.instructions.md는 리더의 코드 수정 금지와 빌더의 탐색 제한을 명확히 정의해야 한다.
- markdown-docs.instructions.md는 README, .github 문서, request artifact에 공통으로 적용된다.
- base researcher는 researcher.agent.md 하나로 유지하고, 추가 researcher는 별도 파일로 복제하는 방식이 자연스럽다.

## External or Domain Facts

- leader가 허용 가능한 subagent를 좁히면 의도치 않은 agent 선택을 줄일 수 있다.
- duplicate researcher를 생성하거나 삭제할 때 leader `agents` 목록을 같은 변경 세트에서 수정하는 방식이 가장 일관적이다.
- fresh context를 가진 independent reviewer는 구현자가 놓친 회귀를 발견할 가능성이 있다.

## Constraints for Implementation

- request_0000은 활성 작업이 아니라 템플릿으로 고정되어야 한다.
- request_0001은 첫 active request로 읽혀야 한다.
- review.md는 findings 중심 구조를 유지하되 조건부 independent review artifact가 되어야 한다.

## Risks and Open Questions

- 빌더와 리뷰어를 완전 병합하면 fresh-context 검증 이점이 줄어든다.
- request 재사용 규칙이 너무 느슨하면 unrelated 작업이 한 request에 섞일 수 있다.
