# Scope and Assumptions

- 범위: 위임 가시성, 실행 주체 식별, researcher scaling 시 허용 subagent 목록 동기화 규칙을 저장소 커스터마이징에 반영한다.
- 가정: 이 request는 실제 운영 규칙 추가와 예시 request 역할을 동시에 수행한다.

## Ordered Steps

1. delegation-visibility skill을 생성하고 Execution Ledger 규칙을 정의한다.
2. leader.agent.md에 allowed subagent 목록과 실행 주체 보고 계약을 추가한다.
3. orchestration.instructions.md에 사용자 식별 가능성 원칙을 추가한다.
4. researcher-scaling skill에 leader `agents` 목록 동기화 절차를 추가한다.
5. worker agent description을 더 분리해 리더의 선택 정확도를 높인다.
6. create-next-request prompt와 README를 새 규칙에 맞게 갱신한다.
7. request_0002 예시 artifact 세트를 생성한다.
8. 관련 Markdown/customization 파일 오류를 검사한다.

## Target Files

- .github/agents/leader.agent.md
- .github/agents/researcher.agent.md
- .github/agents/researcher-02.agent.md
- .github/agents/planner.agent.md
- .github/agents/coder.agent.md
- .github/agents/reviewer.agent.md
- .github/instructions/orchestration.instructions.md
- .github/skills/researcher-scaling/SKILL.md
- .github/skills/delegation-visibility/SKILL.md
- .github/skills/delegation-visibility/assets/execution-ledger.template.md
- .github/skills/delegation-visibility/assets/operator-guide.md
- .github/prompts/create-next-request.prompt.md
- README.md
- docs/agent_docs/request_0002/*.md

## Validation Plan

- 새 skill, agents, instructions, prompt, README의 frontmatter 및 Markdown 오류를 검사한다.
- leader `agents` 목록과 실제 agent frontmatter name이 일치하는지 확인한다.
- request_0002가 canonical artifact set을 포함하는지 확인한다.

## Completion Criteria

- delegation-visibility skill이 존재한다.
- leader agent가 allowed subagent 목록과 Execution Ledger 규칙을 가진다.
- researcher scaling skill이 leader `agents` 목록 동기화를 요구한다.
- README와 prompt가 새 가시성 규칙을 반영한다.
- request_0002 아래 research1.md, research2.md, plan.md, report.md, review.md가 존재한다.

## Risks and Decision Points

- ledger 적용 대상을 모든 요청으로 강제할지, non-trivial request에 우선 적용할지는 운영하며 조정할 수 있다.
- 향후 더 많은 researcher duplicate가 생기면 leader `agents` 목록 길이가 길어질 수 있다.
