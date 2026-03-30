# Scope and Assumptions

- 범위: Problems/lint 게이트, context preflight, clarification fallback, workflow 정합성 점검, README 전면 개편을 현재 저장소 커스터마이징에 반영한다.
- 가정: 이 request는 request 안정성 강화와 운영 문서 재정비를 동시에 수행하는 별도 active request다.

## Ordered Steps

1. request_0002 산출물을 생성하고 이번 범위의 연구 결과를 정리한다.
2. Problems/lint 게이트 skill을 추가한다.
3. context preflight skill을 추가한다.
4. clarification fallback skill을 추가한다.
5. leader, builder, planner, researcher, reviewer, beastmode, instructions, prompt에 새 규칙을 연결한다.
6. delegation visibility의 남은 `coding` 표현을 `building` 기준으로 정리한다.
7. README를 현재 저장소 구조와 운영 정책 기준으로 처음부터 다시 쓴다.
8. 전체 Markdown/customization 파일에 대해 Problems 검사를 수행한다.
9. 변경 범위를 검토한 뒤 commit과 push를 수행한다.

## Target Files

- .github/agents/leader.agent.md
- .github/agents/builder.agent.md
- .github/agents/planner.agent.md
- .github/agents/researcher.agent.md
- .github/agents/researcher-02.agent.md
- .github/agents/reviewer.agent.md
- .github/agents/beastmode.agent.md
- .github/instructions/orchestration.instructions.md
- .github/instructions/role-boundaries.instructions.md
- .github/prompts/create-next-request.prompt.md
- .github/skills/delegation-visibility/SKILL.md
- .github/skills/delegation-visibility/assets/execution-ledger.template.md
- .github/skills/problems-lint-gate/**
- .github/skills/context-preflight/**
- .github/skills/clarification-fallback/**
- README.md
- docs/agent_docs/request_0002/*.md

## Validation Plan

- 새 skill, agent, instruction, prompt, README에 대해 Problems 검사를 수행한다.
- request_0002 산출물이 canonical artifact set을 모두 포함하는지 확인한다.
- 남아 있는 `Coder` 또는 `coding` 구조 표현이 실제 운영 규칙과 충돌하지 않는지 검색한다.

## Completion Criteria

- Problems/lint 게이트가 문서와 커스터마이징 파일에 대해 명시적으로 강제된다.
- 작업 전 context-preflight와 사전 compaction fallback이 문서화된다.
- 질문은 leader만 수행하고, fallback order가 project policy 우선으로 명시된다.
- README가 현재 저장소 구조와 운영 원칙을 정확히 설명한다.
- 관련 Markdown/customization 파일 Problems 검사가 통과한다.

## Risks and Decision Points

- `/compact` 직접 실행 가능 여부는 환경 차이가 있을 수 있으므로 fallback 문서화가 중요하다.
- clarification 기준이 과도하게 엄격하면 질문이 남용되고, 과도하게 느슨하면 잘못된 추측 구현이 늘어날 수 있다.

## Clarification Trigger or Fallback Rationale

- 이번 작업은 저장소 규칙 개편이므로 사용자의 추가 결정 없이도 구현 가능하다.
- clarification 정책 자체는 미래 request에서 리더가 적용할 규칙으로 문서화한다.
