# Summary

두 번째 연구 관점은 작업 전에 컨텍스트 위험을 판단해 미리 압축하거나 working set을 줄이는 규칙, 그리고 이번 패치 후 전체 워크플로우가 서로 모순 없이 이어지는지 점검하는 데 있다.

## Scope Investigated

- 컨텍스트 부족 사전 점검과 pre-work compaction 규칙
- request artifact를 컨텍스트 압축 수단으로 재사용하는 방식
- README 전면 개편에 필요한 현재 저장소 실체

## Codebase Facts

- 현재 리더와 researcher-scaling에는 연구 범위용 토큰 추정 규칙이 있지만, 작업 시작 전 전체 working-context 위험을 재는 공통 skill은 없다.
- request 산출물 구조는 이미 존재하므로 `/compact`가 직접 불가능한 환경에서는 산출물 요약을 fallback 압축 수단으로 활용할 수 있다.
- README는 현재 구조를 부분적으로만 반영하고 있어 전체 프로젝트 설명을 다시 쓰는 편이 낫다.

## External or Domain Facts

- 공식 프롬프트 엔지니어링 문서는 context window 한계를 고려해 필요한 컨텍스트만 구조적으로 전달할 것을 권장한다.
- 같은 문서는 instructions와 context를 분리하고, 반복적으로 쓰는 규칙은 앞쪽에 배치하는 방식이 더 안정적이라고 설명한다.
- 중간 작업 중 컨텍스트를 급하게 압축하는 것보다, 사전에 working set을 줄이고 요약을 남기는 편이 정보 손실 위험을 줄인다.

## Constraints for Implementation

- `/compact` 직접 호출 가능 여부는 환경에 따라 다를 수 있으므로, skill은 fallback 절차를 반드시 포함해야 한다.
- context-preflight는 research 전용이 아니라 leader, planner, builder가 공통으로 참조할 수 있어야 한다.

## Risks and Open Questions

- practical budget 수치를 너무 빡빡하게 잡으면 불필요한 compaction이 늘 수 있다.
- 반대로 임계값이 너무 높으면 작업 도중 압축이 발생해 중요한 문맥이 사라질 수 있다.

## Recommended Clarification Trigger and Default Fallback When Needed

- context-preflight와 clarification-fallback은 별도 skill로 유지하는 편이 책임이 명확하다.
- 질문이 불필요한 경우에는 README와 instructions에 명시된 정책을 기본 해석 근거로 삼는다.

## Recommended Boundaries for the Builder

- Builder는 큰 작업 전에 context-preflight를 보고 working set을 최소화해야 한다.
- 중간에 범위가 커지면 leader에게 재평가를 요청하되, 문서 상태를 먼저 요약해야 한다.
