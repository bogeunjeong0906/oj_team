# Scope and Assumptions

- 범위: request_0000 템플릿화, request 번호 재사용 규칙, Builder-Reviewer 하이브리드, git commit skill을 저장소 커스터마이징에 반영한다.
- 가정: 이 request는 첫 active orchestration request이자 이후 request 운영 규칙의 기준이 된다.

## Ordered Steps

1. request_0000을 공식 템플릿으로 인식하도록 instructions, skills, prompt를 갱신한다.
2. request 번호 할당과 재사용 판단을 위한 request-id-allocation skill을 추가한다.
3. coder를 builder로 대체하고 self-review 규칙을 가진 builder agent를 추가한다.
4. reviewer를 조건부 independent gate로 재정의한다.
5. git commit workflow skill을 추가한다.
6. README와 request artifacts를 새 규칙에 맞게 갱신한다.
7. Markdown 및 frontmatter 오류를 점검한다.

## Target Files

- .github/agents/leader.agent.md
- .github/agents/researcher.agent.md
- .github/agents/planner.agent.md
- .github/agents/builder.agent.md
- .github/agents/reviewer.agent.md
- .github/agents/researcher-02.agent.md
- .github/instructions/*.instructions.md
- .github/skills/request-artifact-management/SKILL.md
- .github/skills/request-id-allocation/SKILL.md
- .github/skills/git-commit-workflow/SKILL.md
- .github/skills/researcher-scaling/SKILL.md
- docs/agent_docs/request_0000/*.md
- docs/agent_docs/request_0001/*.md

## Validation Plan

- 새로 만든 Markdown 파일의 구조와 frontmatter를 오류 검사한다.
- README와 생성된 agent, instruction, skill 파일에 lint 또는 구문 오류가 없는지 확인한다.
- request_0000이 공식 템플릿처럼 읽히는지 확인한다.
- request_0001이 첫 active request로 읽히는지 확인한다.

## Completion Criteria

- builder.agent.md가 존재하고 leader가 이를 사용한다.
- request-id-allocation과 git-commit-workflow skill이 존재한다.
- request_0000과 request_0001이 의도에 맞게 구분된다.
- 관련 Markdown/customization 파일 오류가 없다.

## Risks and Decision Points

- 동일 request 재사용 기준이 너무 느슨하면 범위가 과도하게 커질 수 있다.
- reviewer를 너무 자주 생략하면 fresh-context 검증 가치가 줄어들 수 있다.
