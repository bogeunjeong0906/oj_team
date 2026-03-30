# Summary

첫 active request의 목표는 위임 가시성, request 번호 재사용 기준, 그리고 Builder-Reviewer 하이브리드 운영 규칙을 실전 운영 기준으로 정교화하는 것이다.

## Scope Investigated

- request_0000 템플릿과 active request 구조
- Builder-Reviewer 하이브리드 운영 방향
- request 번호 재사용과 신규 발급 기준
- git commit workflow를 skill로 분리할 필요성

## Codebase Facts

- docs/agent_docs/request_0000은 공식 예시와 템플릿 역할을 하도록 승격되어야 한다.
- active work는 request_0001 이상에서만 진행되도록 강제할 필요가 있다.
- builder와 reviewer를 완전 병합하기보다 Builder self-review와 조건부 independent review를 병행하는 구조가 더 적합하다.
- 동일 카테고리의 작은 후속 요청은 같은 request 번호 재사용 규칙이 필요하다.

## External or Domain Facts

- skills는 반복 가능한 번호 할당, commit, 운영 가드레일 같은 절차형 워크플로우를 담기에 적합하다.
- custom agents는 서로 다른 시야와 도구 제한이 필요할 때 역할을 분리하는 데 적합하다.
- subagent orchestration에서는 fresh context를 가진 independent reviewer가 여전히 검증 가치를 가진다.

## Constraints for Implementation

- beastmode.agent.md는 비상용으로 유지해야 한다.
- 리더는 edit 권한을 가지되 애플리케이션 코드를 수정하면 안 된다.
- 빌더는 researchN.md와 plan.md 중심으로 엄격한 컨텍스트 격리를 유지해야 한다.
- 독립 리뷰는 유지하되 모든 후속 수정에 강제하지는 않는 하이브리드가 필요하다.

## Risks and Open Questions

- request 번호 재사용 기준이 모호하면 리더가 잘못된 새 request를 만들거나 기존 request를 덮어쓸 수 있다.
- 빌더 self-review만으로 충분한 작업과 독립 리뷰가 필요한 작업을 구분하는 기준이 필요하다.
- git commit은 사용자 명시 요청 없이는 실행되면 안 된다.
