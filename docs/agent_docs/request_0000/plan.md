# Scope and Assumptions

- 범위: Beast Mode 예외와 내부 팀 request 워크플로우를 공존시키는 공식 템플릿 정리
- 가정: 이 request는 공식 예시와 템플릿 역할을 하며 저장소 기본 상태를 설명한다.

## Ordered Steps

1. Beast Mode를 standalone external agent로 명시하고 request 비생성 원칙을 고정한다.
2. Leader 기반 내부 팀 워크플로우를 request artifact 전용 경로로 유지한다.
3. duplicate researcher 모델을 Researcher + Subresearcher 01 + Subresearcher 02 구조로 교체한다.
4. Researcher가 연구 payload 계산과 supporting researcher 추천을 맡고, Leader는 승인과 반영만 맡는 구조를 반영한다.
5. Researcher가 최종 연구 합성자이고 leader direct research는 금지라는 점을 규칙과 템플릿에 반영한다.
6. Python 실행 전 repo-local 환경을 먼저 식별하는 규칙을 추가한다.
7. request_0000 문서 세트를 새 구조 기준으로 갱신한다.
8. portable 기본 상태를 위해 활성 request 폴더 제거 원칙을 문서화한다.

## Target Files

- .github/agents/beastmode.agent.md
- .github/agents/leader.agent.md
- .github/agents/researcher.agent.md
- .github/agents/subresearcher-01.agent.md
- .github/agents/subresearcher-02.agent.md
- .github/agents/builder.agent.md
- .github/agents/reviewer.agent.md
- .github/instructions/orchestration.instructions.md
- .github/instructions/role-boundaries.instructions.md
- .github/prompts/create-next-request.prompt.md
- .github/skills/researcher-scaling/SKILL.md
- .github/skills/delegation-visibility/**
- README.md
- docs/agent_docs/request_0000/*.md

## Validation Plan

- 변경된 Markdown/customization 파일의 Problems를 점검한다.
- request_0000 템플릿이 research1.md, research2.md, research3.md, plan.md, report.md, review.md를 포함하는지 확인한다.
- Beast Mode 예외와 내부 request 규칙이 README, instructions, agents에서 같은 방향을 가리키는지 확인한다.

## Completion Criteria

- Beast Mode가 request 비생성 예외로 명시된다.
- 내부 연구 구조가 Researcher와 두 개의 subresearcher 기준으로 정리된다.
- Researcher가 용량 견적과 스케일링 추천을 담당하고 Leader는 승인과 반영을 담당한다.
- leader direct research 금지 규칙이 반영된다.
- Python 실행 전 환경 활성화 규칙이 반영된다.
- request_0000 문서가 새 운영 모델을 설명한다.

## Risks and Decision Points

- env-like 폴더 판별은 conda 우선이되 native fallback 허용으로 균형을 잡아야 한다.
- 실제 작업 request는 상황에 따라 research2.md, research3.md를 생략할 수 있다.
