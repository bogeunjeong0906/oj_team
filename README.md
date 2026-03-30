
# 오케스트레이션 커스터마이징 저장소

이 저장소는 VS Code Copilot용 멀티 에이전트 오케스트레이션 규칙을 문서 기반으로 관리한다. 목적은 리더, 리서처, 플래너, 빌더, 리뷰어가 같은 방식으로 작업을 분해하고, request 단위 산출물을 남기고, 문법 오류와 컨텍스트 부족 같은 운영 실패를 미리 막는 것이다.

## 핵심 목표

- 사용자 요청을 request 단위로 분리해 추적 가능하게 유지한다.
- 연구, 계획, 구현, 리뷰의 역할 경계를 명확히 유지한다.
- 리더 응답만 봐도 누가 어떤 단계를 수행했는지 알 수 있게 만든다.
- 에이전트가 작업 전 컨텍스트 위험과 작업 후 Problems 상태를 반드시 확인하게 만든다.
- 정보가 부족한 경우 무조건 추측하지 않고, 필요한 경우에만 제한적으로 질문하게 만든다.

## 저장소 구성

```text
.github/
  agents/
    beastmode.agent.md
    leader.agent.md
    researcher.agent.md
    researcher-02.agent.md
    planner.agent.md
    builder.agent.md
    reviewer.agent.md
  instructions/
    agent-artifacts.instructions.md
    markdown-docs.instructions.md
    orchestration.instructions.md
    role-boundaries.instructions.md
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
docs/
  agent_docs/
    request_0000/
    request_0001/
    request_0002/
```

## Request 모델

- `request_0000`은 공식 템플릿이자 예시 패키지다.
- 활성 작업은 `request_0001`부터 시작한다.
- 같은 1차 목표를 계속 다듬는 후속 수정은 같은 request 번호를 재사용한다.
- 요청 카테고리, 주요 산출물, 대상 서브시스템, 구현 방향이 크게 바뀌면 새 request를 만든다.
- 각 활성 request는 아래 산출물 집합을 기준으로 운영한다.

```text
docs/agent_docs/request_XXXX/
  research1.md
  research2.md
  plan.md
  report.md
  review.md
```

## 에이전트 역할

### Leader

- 사용자와 직접 대화하는 유일한 에이전트다.
- request 번호 재사용 또는 신규 할당을 결정한다.
- 연구 인원 수와 위임 경로를 결정한다.
- 작업 시작 전에 context preflight를 수행한다.
- 정보 부족이 안정적인 구현을 막는 경우에만 사용자에게 질문한다.
- 작업 완료 전 Problems 및 lint 게이트 통과 여부를 확인한다.

### Researcher

- 관련 코드, 문서, 외부 자료를 조사한다.
- researchN.md에 사실, 제약, 위험, 열린 질문을 기록한다.
- 빌더가 불필요한 문맥을 읽지 않도록 입력 범위를 정제한다.
- 필요한 경우 어떤 질문이 정말 필요한지와 기본 fallback 경로를 제안한다.

### Planner

- researchN.md를 바탕으로 실행 가능한 plan.md를 만든다.
- 구현 순서, 대상 파일, 검증 계획, 완료 조건을 구체화한다.
- 구현 전에 반드시 해소해야 하는 모호성을 드러낸다.

### Builder

- researchN.md와 plan.md만을 핵심 입력으로 삼아 구현한다.
- 수정 전후 Problems 상태와 관련 lint 결과를 확인한다.
- self-review를 수행한 뒤 report.md에 변경과 검증을 기록한다.
- 사용자 답변이 없으면 프로젝트 정책, 그다음 산업 표준을 따른다.

### Reviewer

- plan.md와 report.md를 기준으로 독립 검토를 수행한다.
- 버그, 회귀 위험, 검증 누락, 부적절한 가정 사용 여부를 찾는다.
- 필요할 때만 투입되는 독립 게이트 역할이다.

## 표준 워크플로우

1. 리더가 request 연속성 여부와 신규 request 필요 여부를 판단한다.
2. 리더가 context preflight를 수행해 작업 전 컨텍스트 위험을 분류한다.
3. 필요하면 리서처를 1명 이상 배정해 researchN.md를 채운다.
4. 플래너가 plan.md를 작성한다.
5. 안정적인 구현을 막는 정보 부족이 남아 있으면 리더가 한 번에 묶어 질문한다.
6. 빌더가 구현하고 Problems/lint 게이트와 self-review를 통과시킨 뒤 report.md를 작성한다.
7. 고위험이거나 사용자가 요청한 경우 리뷰어가 review.md를 작성한다.
8. 리더가 Execution Ledger와 함께 결과를 사용자에게 보고한다.

## 운영 가드레일

### 1. Delegation Visibility

- 리더는 non-trivial 작업에서 Execution Ledger를 제공한다.
- 각 단계는 `research`, `planning`, `building`, `review` 기준으로 추적한다.
- 위임이 실제로 완료되지 않았으면 완료처럼 서술하지 않는다.

### 2. Problems and Lint Gate

- 수정 전 baseline Problems를 확인한다.
- 수정 후 touched file 기준으로 Problems를 다시 확인한다.
- 기존 lint 또는 build task가 있으면 관련 task를 우선 사용한다.
- 명시적 task가 없어도 Problems 데이터 자체는 반드시 확인한다.
- Markdown, frontmatter, instructions, skills, prompts도 동일한 게이트를 적용한다.

### 3. Context Preflight

- 큰 작업 전에는 예상 working set과 안전 여유를 계산한다.
- 위험이 높으면 작업 도중이 아니라 작업 전에 `/compact`를 우선 고려한다.
- `/compact`가 불가능하면 request 산출물에 상태를 요약하고 working set을 줄인다.

### 4. Clarification Fallback

- 질문은 안정적인 구현이 막힐 때만 허용된다.
- 사소한 스타일 선택이나 일반적인 관례는 질문 사유가 아니다.
- 질문은 한 번에 묶어서 짧게 한다.
- 사용자가 답하지 못하면 프로젝트 정책을 우선 적용한다.
- 저장소에 정책이 없으면 산업 표준을 적용하고 가정을 문서에 남긴다.

## Skills

### request-artifact-management

- request 산출물 생성 및 갱신 규칙을 정의한다.

### request-id-allocation

- 기존 request 재사용 여부와 새 request 번호 부여 기준을 정의한다.

### researcher-scaling

- 리서처 수를 컨텍스트 예산과 범위에 따라 조정한다.

### delegation-visibility

- 리더가 어떤 단계를 직접 처리했고 무엇을 위임했는지 드러내게 한다.

### problems-lint-gate

- Problems 패널과 lint 결과를 완료 게이트로 강제한다.

### context-preflight

- 작업 전 컨텍스트 부족 위험을 추정하고 사전 압축 또는 범위 축소를 결정한다.

### clarification-fallback

- 질문 남용을 막으면서 필요한 질문만 하도록 제한하고, 답이 없을 때의 fallback 순서를 정의한다.

### git-commit-workflow

- 사용자가 명시적으로 요청한 경우에만 stage, commit, push를 수행하게 한다.

## 문서 작성 규칙

- Markdown 문서는 heading 주변 공백, 일관된 리스트, 마지막 trailing newline을 유지한다.
- request artifact는 stage별 역할에 맞게 나누고 문서를 합치지 않는다.
- 열린 질문과 fallback 가정은 숨기지 않고 문서에 남긴다.

## Git 원칙

- commit과 push는 사용자가 명시적으로 요청한 경우에만 수행한다.
- commit 전에는 변경 범위가 요청 범위와 일치하는지 확인한다.
- 관련 없는 변경이 섞여 있으면 분리하거나 중단한다.

## 현재 운영 방향

- 기본 구현자는 Builder다.
- Reviewer는 조건부 독립 게이트다.
- request 산출물은 작업 기록이자 컨텍스트 압축 수단이다.
- 이 저장소의 중심은 애플리케이션 코드가 아니라 에이전트 동작 규칙의 일관성이다.
