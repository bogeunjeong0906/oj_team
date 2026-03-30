
# 에이전트 기반 협업 워크플로우

## 1. 워크플로우 개요

### 1) 연구 (Research)

- 목적: 프로젝트 구조, 관련 코드, 도메인 지식, 외부 레퍼런스를 조사한다.
- 책임: 리서처 에이전트 1명 이상.
- 산출물: research1.md, research2.md, ...

### 2) 계획 (Planning)

- 목적: 연구 결과를 바탕으로 실행 가능한 작업 계획과 검증 기준을 수립한다.
- 책임: 플래너 에이전트.
- 산출물: plan.md

### 3) 실행 (Execution)

- 목적: 계획을 기준으로 코드를 구현하고 결과를 정리한다.
- 책임: 코더 에이전트.
- 산출물: 코드, report.md

### 4) 리뷰 (Review)

- 목적: 구현 결과가 계획과 일치하는지 검토하고 위험, 회귀, 테스트 공백을 찾는다.
- 책임: 리뷰어 에이전트.
- 산출물: review.md

### 5) 검증 및 피드백 (Validation and Feedback)

- 목적: 산출물을 취합하고 사용자 피드백을 반영해 반복 개선한다.
- 책임: 리더 에이전트 및 사용자.
- 산출물: 수정된 plan.md, report.md, review.md

---

## 2. 폴더 및 파일 구조

- 에이전트 전용 저장공간: docs/agent_docs/
- 공식 템플릿 폴더: request_0000/
- 활성 Request별 폴더: request_0001/, request_0002/, ...
- 각 request 폴더 기본 파일:
  - research1.md
  - research2.md
  - plan.md
  - report.md
  - review.md

### 예시

```text
docs/agent_docs/
  ├── request_0000/
  │   ├── research1.md
  │   ├── research2.md
  │   ├── plan.md
  │   ├── report.md
  │   └── review.md
  └── request_0001/
      ├── research1.md
      ├── research2.md
      ├── plan.md
      ├── report.md
      └── review.md
```

---

## 3. 에이전트 역할 및 책임

### 리더 (Leader)

- 사용자와 직접 소통하는 유일한 에이전트다.
- 전체 워크플로우를 오케스트레이션한다.
- 사용자 요청을 세부 작업으로 분해하고 적절한 에이전트에 배정한다.
- request ID를 할당하고 docs/agent_docs/ 문서를 관리한다.
- 프로젝트 규모와 컨텍스트 예산에 따라 리서처 수를 조절한다.
- 리서처 파일을 복제하거나 정리해 팀 규모를 유동적으로 운영할 수 있다.
- 최종 보고에서 각 단계를 누가 수행했는지 식별 가능하게 설명한다.
- 리서처 수를 바꾸면 허용 서브에이전트 목록도 함께 갱신한다.
- edit 권한은 가지지만 애플리케이션 코드 수정은 금지한다.

### 리서처 (Researcher)

- 프로젝트 구조와 도메인 지식을 조사한다.
- 필요시 외부 문서를 조사하고 근거를 정리한다.
- researchN.md 파일을 작성한다.
- 코더가 엉뚱한 자료를 참조하지 않도록 입력 컨텍스트를 정제한다.

### 플래너 (Planner)

- researchN.md를 바탕으로 plan.md를 작성한다.
- 작업 순서, 대상 파일, 검증 기준, 완료 조건을 명시한다.
- 계획의 논리적 타당성과 실행 가능성을 점검한다.

### 빌더 (Builder)

- researchN.md와 plan.md를 기준으로 구현한다.
- 컨텍스트 격리를 엄격하게 유지한다.
- 계획에 명시된 대상 파일만 찾아 읽고 수정한다.
- 구현 후 검증과 self-review를 먼저 수행한다.
- 구현 후 report.md에 변경 내용, 검증 결과, self-review 결과, 계획과의 차이를 기록한다.

### 리뷰어 (Reviewer)

- plan.md와 report.md를 기준으로 구현 결과를 독립 시야에서 검토한다.
- 버그, 회귀 위험, 누락, 테스트 공백을 식별한다.
- review.md에 findings 중심으로 검토 결과를 남긴다.
- 원칙적으로 코드를 수정하지 않는다.
- 모든 작업에 항상 투입되지는 않으며, 고위험 또는 반복 수정 작업에서 우선 사용한다.

---

## 4. 협업 및 검증 프로세스

1. 리더가 사용자 요청을 분석하고 request 폴더를 생성한다.
2. 리더가 프로젝트 규모에 따라 리서처 수를 결정한다.
3. 리서처가 병렬 또는 순차로 연구를 수행하고 researchN.md를 작성한다.
4. 플래너가 연구 결과를 종합해 plan.md를 작성한다.
5. 빌더가 plan.md에 따라 구현하고 self-review 후 report.md를 작성한다.
6. 필요할 때 리뷰어가 구현 결과를 독립 검토하고 review.md를 작성한다.
7. 리더가 산출물을 취합해 사용자에게 보고하고, 필요하면 재연구, 재계획, 재구현을 지시한다.

---

## 5. 운영 원칙

- 리더만 사용자와 직접 대화한다.
- 빌더의 컨텍스트는 researchN.md와 plan.md로 엄격하게 제한한다.
- 리더는 문서와 폴더는 수정할 수 있지만 애플리케이션 코드는 수정하지 않는다.
- 독립 리뷰는 고위험 또는 범위가 넓은 변경에서 우선 적용한다.
- 리서처 수 조정은 프로젝트 규모, 병렬 조사 필요성, 컨텍스트 예산을 기준으로 결정한다.
- request_0000은 공식 예시이자 템플릿이며 활성 작업에 사용하지 않는다.
- 동일한 1차 목표를 계속 다듬는 작은 후속 요청은 같은 request 번호를 재사용한다.
- 요청 카테고리, 주요 산출물, 대상 서브시스템이 바뀌면 새로운 request 번호를 사용한다.
- 사용자는 리더 응답만 보고도 각 단계가 리더 직접 수행인지 서브에이전트 수행인지 구분할 수 있어야 한다.
- 리더는 non-trivial 작업에서 Execution Ledger를 제공해 stage, executor, output, delegation status를 드러낸다.
- 산출물은 재현 가능하고 다음 단계 에이전트가 바로 사용할 수 있는 형식으로 작성한다.

---

## 6. 구현 대상 커스터마이징 구조

```text
.github/
  ├── agents/
  │   ├── beastmode.agent.md
  │   ├── leader.agent.md
  │   ├── researcher.agent.md
  │   ├── planner.agent.md
  │   ├── builder.agent.md
  │   └── reviewer.agent.md
  ├── instructions/
  │   ├── orchestration.instructions.md
  │   ├── agent-artifacts.instructions.md
  │   ├── role-boundaries.instructions.md
  │   └── markdown-docs.instructions.md
  ├── prompts/
  │   └── create-next-request.prompt.md
  └── skills/
      ├── request-artifact-management/
      │   ├── SKILL.md
      │   └── assets/
        ├── request-id-allocation/
        │   ├── SKILL.md
        │   └── assets/
      ├── delegation-visibility/
      │   ├── SKILL.md
      │   └── assets/
        ├── git-commit-workflow/
        │   ├── SKILL.md
        │   └── assets/
      └── researcher-scaling/
          └── SKILL.md
```

## 7. 실행 주체 식별 규칙

- 리더는 최종 응답에서 Execution Ledger를 제공한다.
- 각 stage는 다음 중 하나로 표시한다.
  - `delegated and completed`
  - `delegated but no usable result returned`
  - `handled directly by leader`
- ledger에는 최소한 stage, executor, output, note가 포함된다.
- 리더는 위임이 실제로 완료되지 않았으면 위임 완료처럼 서술하면 안 된다.

## 8. Request 번호 규칙

- request_0000은 공식 템플릿이자 예시다.
- 활성 작업 번호는 request_0001부터 시작한다.
- 작은 후속 수정, 누락 보완, 폴리시, 사소한 버그 수정은 같은 request 번호를 재사용한다.
- 요청 카테고리나 주요 대상이 바뀌면 새 request 번호를 부여한다.

## 9. Git Commit 규칙

- stage와 commit은 사용자가 명시적으로 요청한 경우에만 수행한다.
- commit 전에는 변경 범위와 관련성 검토가 선행되어야 한다.
- 비관련 변경이 섞여 있으면 분리하거나 중단한다.
