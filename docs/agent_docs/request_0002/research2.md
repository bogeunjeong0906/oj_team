# Summary

두 번째 조사 관점에서는 researcher 수 증감 시 허용 subagent 목록이 어떻게 함께 갱신되어야 하는지, 그리고 description 차별화가 왜 필요한지 점검했다.

## Scope Investigated

- researcher scaling과 leader `agents` 목록의 동기화 규칙
- active agent name과 file name의 매핑 안정성
- worker agent description의 분리도 개선

## Codebase Facts

- 현재 저장소에는 `Researcher`, `Researcher 02`, `Planner`, `Coder`, `Reviewer`가 존재한다.
- worker agent들은 모두 `user-invocable: false`로 설정되어 있어 subagent 중심 운용에 적합하다.
- description이 비슷하면 리더가 잘못된 worker를 선택할 가능성이 높아진다.

## External or Domain Facts

- leader가 허용 가능한 subagent를 좁히면 의도치 않은 agent 선택을 줄일 수 있다.
- duplicate researcher를 생성하거나 삭제할 때 leader `agents` 목록을 같은 변경 세트에서 수정하는 방식이 가장 일관적이다.

## Constraints for Implementation

- `agents` 목록에는 파일 경로가 아니라 frontmatter `name` 값만 들어가야 한다.
- researcher file을 없앴는데 leader 목록에 stale name이 남으면 위임 품질이 떨어질 수 있다.
- 운영 문서는 사용자가 artifact와 ledger를 서로 대조할 수 있도록 안내해야 한다.

## Risks and Open Questions

- 향후 `Researcher 03` 이상이 늘어나면 naming 규칙과 artifact 매핑 규칙을 계속 유지해야 한다.
- 리더가 description보다 body 지침에 더 강하게 끌릴 수도 있으므로 반복 고정이 필요하다.
