# 오케스트레이션 커스터마이징 저장소

이 저장소는 VS Code Copilot용 커스텀 에이전트, instructions, skills, prompts를 문서 기반으로 관리한다. 핵심은 두 계층을 분리하는 것이다.

- Beast Mode는 외부 특권 계층의 단독 에이전트다.
- Leader 기반 팀 워크플로우는 내부 오케스트레이션 계층이다.
- TAS는 request artifact를 사용하는 단독 직렬 모드 에이전트다.

이 구분 때문에 Beast Mode는 request 생성 규칙을 따르지 않고, 내부 팀과 TAS만 docs/agent_docs/request_XXXX 구조를 사용한다.

## 핵심 원칙

- Beast Mode는 자신의 agent 파일만 운영 기준으로 삼는다.
- Beast Mode는 스스로 작업할 때 활성 request를 만들지 않는다.
- TAS는 단독 에이전트이지만 request artifact를 사용한다.
- 내부 팀 워크플로우는 request artifact를 사용하되, 저장소를 다른 프로젝트에 이식할 때는 활성 request 폴더를 남기지 않는다.
- 리더는 직접 연구하지 않고, Researcher가 연구 단계를 소유한다.
- Subresearcher는 필요할 때만 병렬 조사 슬라이스를 맡고, 최종 연구 산출물은 항상 Researcher가 합성한다.
- 수정 전후 Problems 상태를 확인하고, Markdown과 customization 파일도 같은 검증 게이트를 통과해야 한다.
- 정보가 부족할 때는 질문을 남발하지 않고, 저장소 정책 우선, 산업 표준 차선의 fallback을 기록한다.

## 기본 저장소 상태

배포 또는 재사용 가능한 기본 상태에서는 템플릿 request만 남긴다.

```text
.github/
  agents/
    beastmode.agent.md
    tas.agent.md
    leader.agent.md
    researcher.agent.md
    subresearcher-01.agent.md
    subresearcher-02.agent.md
    planner.agent.md
    builder.agent.md
    reviewer.agent.md
  instructions/
    agent-artifacts.instructions.md
    markdown-docs.instructions.md
    orchestration.instructions.md
    role-boundaries.instructions.md
    tas-workflow.instructions.md
  prompts/
    create-next-request.prompt.md
  skills/
    clarification-fallback/
    context-preflight/
    delegation-visibility/
    git-commit-workflow/
    problems-lint-gate/
    request-artifact-management/
    request-id-allocation/
    researcher-scaling/
    tas-action-mode/
    tas-mode-router/
    tas-plan-mode/
    tas-research-mode/
docs/
  agent_docs/
    request_0000/
```

활성 request 폴더는 내부 팀이 실제 작업할 때만 일시적으로 존재해야 하며, Beast Mode 전용 운영이나 저장소 이식 전 정리 대상이다.

## 운영 계층

### 1. Beast Mode

- 단독 에이전트다.
- 자체 워크플로우로 연구, 계획, 구현, 검증을 끝까지 수행할 수 있다.
- 내부 Leader request 워크플로우를 실행 규칙으로 채택하지 않는다.
- docs/agent_docs/request_XXXX를 자신의 실행 산출물로 만들지 않는다.

### 2. Internal Team Workflow

- Leader가 사용자와 직접 대화한다.
- Researcher가 연구 단계를 소유한다.
- Subresearcher 01, Subresearcher 02는 필요할 때만 병렬 조사에 참여한다.
- Planner가 plan.md를 작성한다.
- Builder가 구현과 self-review를 담당한다.
- Reviewer가 필요 시 독립 검토 게이트를 제공한다.
- Researcher가 연구 payload와 컨텍스트 부담을 먼저 계산하고, Leader는 그 추천을 승인해 실제 지원 연구자를 활성화한다.

### 3. TAS

- 단독 에이전트다.
- docs/agent_docs/request_XXXX를 자신의 실행 산출물로 사용한다.
- research, plan, action의 3개 mode로 작업한다.
- mode는 병렬로 섞지 않고 직렬로 처리한다.
- 한 턴에 여러 mode를 끝낼 수는 있지만, 항상 research 완료 후 plan, plan 완료 후 action 순서만 허용된다.
- action 단계가 구현, 검증, self-review, report.md 작성을 함께 담당한다.

## Request 모델

- request artifact 규칙은 내부 팀 워크플로우와 TAS에 적용된다.
- `request_0000`은 공식 템플릿이자 예시 패키지다.
- 내부 활성 작업은 `request_0001`부터 시작한다.
- 같은 1차 목표를 계속 다듬는 후속 수정은 같은 request 번호를 재사용한다.
- 요청 카테고리, 주요 산출물, 대상 서브시스템, 구현 방향이 크게 바뀌면 새 request를 만든다.

내부 팀의 request 산출물은 아래 구조를 기준으로 운영한다.

```text
docs/agent_docs/request_XXXX/
  research.md
  research1.md
  research2.md
  plan.md
  report.md
  review.md
```

- `research.md`: main Researcher의 최종 합성 결과
- `research1.md`: Subresearcher 01 지원 조사
- `research2.md`: Subresearcher 02 지원 조사

작업 범위가 작으면 `research1.md`, `research2.md`는 생략할 수 있다.

TAS 기본 흐름은 아래 3개 산출물을 사용한다.

- `research.md`: 조사 결과와 구현 경계
- `plan.md`: 직렬 실행 계획과 검증 계획
- `report.md`: 구현 결과, 검증 결과, self-review

## 역할 정의

### Beast Mode

- 외부 특권 계층 에이전트
- request 비생성 원칙 유지
- 필요 시 내부 오케스트레이션 파일을 수정 대상 콘텐츠로만 다룸

### TAS

- request를 생성하거나 재사용하는 단독 에이전트
- research, plan, action mode를 하나씩 직렬 완료한다.
- 필요 시 한 턴에 여러 mode를 수행해도 순서를 건너뛰지 않는다.
- subagent에 의존하지 않고 자체적으로 request artifact를 갱신한다.

### Leader

- 내부 팀의 요청 연속성, context preflight, 검증 게이트, 위임 경로를 관리한다.
- Researcher의 추천을 바탕으로 subresearcher 활성화 여부를 승인하고 반영한다.
- 직접 연구하지 않는다.

### Researcher

- 연구 단계의 주인이다.
- 단독 조사 또는 subresearcher 결과를 합성한 최종 연구 산출물을 만든다.
- 초기 연구 코퍼스와 컨텍스트 부담을 추정하고 supporting researcher 필요 여부를 추천한다.

### Subresearcher 01 / 02

- 넓은 범위에서만 활성화되는 병렬 조사자다.
- 서로 겹치지 않는 슬라이스를 조사해 main Researcher에 전달한다.

### Planner

- 연구 결과를 plan.md로 변환한다.

### Builder

- plan.md 기반 구현 담당자다.
- 수정 전후 Problems 확인과 self-review가 필수다.

### Reviewer

- 고위험 또는 사용자 요청 시 독립 검토를 수행한다.

## 내부 팀 표준 워크플로우

1. Leader가 이 요청이 내부 팀용인지 Beast Mode용인지 먼저 판단한다.
2. Beast Mode용이면 request artifact를 만들지 않는다.
3. 내부 팀용이면 context preflight를 수행한다.
4. request 재사용 또는 신규 할당을 결정한다.
5. Researcher를 기본 배치한다.
6. Researcher가 연구 payload와 supporting researcher 필요 여부를 추천한다.
7. Leader가 그 추천을 승인해 필요 시 subresearcher를 추가한다.
8. Researcher가 최종 연구 handoff를 정리한다.
9. Planner가 실행 계획을 만든다.
10. Builder가 구현, Problems/lint 검증, self-review를 수행한다.
11. 필요 시 Reviewer가 독립 검토를 수행한다.
12. Leader가 Execution Ledger와 함께 사용자에게 보고한다.

## TAS 표준 워크플로우

1. TAS가 context preflight를 수행한다.
2. TAS가 request 재사용 또는 신규 할당을 결정한다.
3. TAS가 research mode를 완료하고 research.md를 기록한다.
4. TAS가 plan mode로 전환하고 plan.md를 기록한다.
5. TAS가 action mode로 전환해 구현, 검증, self-review를 수행한다.
6. TAS가 report.md에 실행 결과를 기록한다.
7. 후속 수정이 들어오면 기존 request를 재사용하되 필요 시 research 또는 plan으로 롤백한다.

## Python 실행 규칙

Python 명령을 실행하는 에이전트는 먼저 저장소 루트의 `.venv`, `venv`, `env`, `.conda`, `conda`를 확인해야 한다.

- 유효한 conda 환경 또는 path prefix면 `conda activate <path>` 후 실행한다.
- 폴더 이름만 비슷하고 실제 conda 환경이 아니면 해당 환경의 native activation을 사용하고 그 fallback을 기록한다.

이 규칙은 Beast Mode, Builder, Reviewer에 직접 반영되어 있다.

## 운영 가드레일

### Delegation Visibility

- non-trivial 내부 팀 작업은 Execution Ledger를 남긴다.
- research 단계는 leader 직접 처리로 기록될 수 없다.
- subresearcher가 기여했더라도 최종 research stage owner는 Researcher다.

### Problems and Lint Gate

- Markdown, frontmatter, instructions, skills, prompts까지 포함해 검증한다.
- touched file에 새 오류를 남기면 완료로 간주하지 않는다.

### Context Preflight

- 큰 작업은 시작 전에 working set 위험을 추정한다.
- 위험이 높으면 `/compact` 또는 working set 축소를 먼저 적용한다.

### Clarification Fallback

- 질문은 안정적인 구현을 막는 실질적 모호성에서만 허용된다.
- 질문은 한 번에 묶는다.
- 답이 없으면 저장소 정책, 그다음 산업 표준을 따른다.

## Git 원칙

- commit과 push는 사용자가 명시적으로 요청한 경우에만 수행한다.
- 관련 없는 변경은 가능한 한 커밋에서 제외한다.
- 저장소를 공유하거나 이식하기 전에는 활성 request 폴더를 제거한다.
