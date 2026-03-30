# Summary

지원 연구자 관점에서는 Researcher가 최종 연구 소유자이고, Subresearcher 01과 Subresearcher 02는 필요할 때만 병렬 슬라이스를 조사해야 한다는 점을 확인했다.

## Scope Investigated

- subresearcher naming 구조
- leader agents 목록 동기화 규칙
- delegation visibility에서 research stage를 표현하는 방식

## Codebase Facts

- 기존 구조는 `researcher-02.agent.md` 같은 중복 researcher 모델에 의존하고 있었다.
- leader.agent.md와 researcher-scaling skill이 기존 naming에 결합되어 있었다.
- request_0000 템플릿도 기존 duplicate researcher 모델을 예시로 사용하고 있었다.

## External or Domain Facts

- supporting agent는 distinct artifact target을 가져야 병렬 조사 충돌이 줄어든다.
- main agent가 synthesis를 담당하면 planner 입력을 한 파일에 안정적으로 고정할 수 있다.

## Constraints for Implementation

- Researcher는 final research handoff owner여야 한다.
- Subresearcher 01은 research2.md, Subresearcher 02는 research3.md를 기본 대상으로 삼는 편이 자연스럽다.
- leader의 research stage direct handling은 금지되어야 한다.

## Risks and Open Questions

- 실제 작은 작업에서는 subresearcher 파일이 존재하더라도 비활성 상태가 기본이어야 한다.
- Execution Ledger template이 research stage owner와 supporting executor를 함께 설명해야 한다.
