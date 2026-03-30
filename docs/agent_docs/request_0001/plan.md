# Scope and Assumptions

- 범위: 오케스트레이션 에이전트 팀의 1차 워크스페이스 커스터마이징 구축
- 가정: 이 request는 실제 첫 작업의 기록이자 이후 request들의 참조 예시 역할을 한다.

## Ordered Steps

1. beastmode.agent.md는 유지하고 나머지 역할별 에이전트를 분리한다.
2. 공통 운영 규칙을 instructions로 분리한다.
3. request artifact 관리와 researcher scaling을 skills로 추가한다.
4. docs/agent_docs/request_0001 산출물 세트를 생성한다.
5. 리더가 복제해서 사용할 researcher-02.agent.md 예시를 추가한다.
6. Markdown 및 frontmatter 오류를 점검한다.

## Target Files

- .github/agents/leader.agent.md
- .github/agents/researcher.agent.md
- .github/agents/planner.agent.md
- .github/agents/coder.agent.md
- .github/agents/reviewer.agent.md
- .github/agents/researcher-02.agent.md
- .github/instructions/*.instructions.md
- .github/skills/request-artifact-management/SKILL.md
- .github/skills/researcher-scaling/SKILL.md
- docs/agent_docs/request_0001/*.md

## Validation Plan

- 새로 만든 Markdown 파일의 구조와 frontmatter를 오류 검사한다.
- README와 생성된 agent, instruction, skill 파일에 lint 또는 구문 오류가 없는지 확인한다.
- request_0001 산출물이 canonical artifact set을 모두 포함하는지 확인한다.

## Completion Criteria

- 다섯 역할의 agent 파일이 존재한다.
- researcher-02.agent.md 예시가 존재한다.
- request_0001 아래 research1.md, research2.md, plan.md, report.md, review.md가 존재한다.
- 관련 Markdown/customization 파일 오류가 없다.

## Risks and Decision Points

- 향후 researcher를 더 늘릴 때 naming 규칙을 `researcher-02`, `researcher-03`로 유지할지 결정이 필요할 수 있다.
- docs/agent_docs의 실제 운영 범위를 모든 요청으로 확대할지, 중요한 요청에만 적용할지 추후 정할 수 있다.
