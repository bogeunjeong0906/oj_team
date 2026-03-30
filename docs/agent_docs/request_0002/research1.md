# Summary

이번 request의 첫 번째 연구 관점은 에이전트가 Markdown을 포함한 문서 변경에서도 Problems 패널과 linter를 강제 확인하게 만드는 방법, 그리고 정보 부족 시 질문 남용 없이 안전하게 clarification을 수행하는 규칙을 정리하는 것이다.

## Scope Investigated

- VS Code Problems 패널과 problem matcher 기반 작업 흐름
- 현재 저장소의 agent, instruction, skill 구조
- clarification이 필요한 상황과 fallback 기준

## Codebase Facts

- 현재 저장소에는 Problems/lint를 완료 게이트로 강제하는 skill이 없다.
- 리더만 사용자와 직접 대화하는 구조는 이미 존재하므로 clarification 권한도 리더에게 집중하는 것이 일관적이다.
- beastmode.agent.md에는 추가 질문 없이 해결해야 한다는 강한 문구가 있어 새 clarification 정책과 충돌 가능성이 있다.

## External or Domain Facts

- VS Code 공식 tasks 문서는 task output을 problem matcher로 스캔해 Problems 패널에 반영할 수 있다고 설명한다.
- `presentation.revealProblems`와 problem matcher는 lint 결과를 Problems 중심 워크플로우로 연결하는 표준 수단이다.
- 작업 검증이 task 기반이 아니더라도 Problems 상태 자체를 재확인하는 방식은 최소한의 안전 게이트로 사용할 수 있다.

## Constraints for Implementation

- 저장소는 문서 기반 커스터마이징 저장소이므로 범용 lint task를 강제로 추가하기보다는 workflow 규칙으로 Problems 확인을 강제하는 편이 안전하다.
- clarification은 모든 에이전트가 직접 수행하면 역할 경계가 무너지므로 leader 중심으로 라우팅되어야 한다.

## Risks and Open Questions

- Problems 패널에 직접 연결되는 작업이 없는 저장소에서는 `get_errors` 성격의 검사가 사실상 최소 게이트가 된다.
- clarification 기준이 너무 느슨하면 에이전트가 사소한 선호도까지 묻게 되어 속도가 떨어질 수 있다.

## Recommended Clarification Trigger and Default Fallback When Needed

- 기능, 보안, 호환성, 데이터 처리처럼 결과를 크게 바꾸는 불명확성만 질문 후보로 올린다.
- 사용자가 답하지 못하면 저장소 정책을 우선 적용하고, 없으면 산업 표준으로 진행한다.

## Recommended Boundaries for the Builder

- Builder는 직접 질문하지 않고 leader에 질문 후보와 fallback 옵션만 넘겨야 한다.
- Builder report에는 Problems/lint 확인과 fallback assumption을 명시해야 한다.
