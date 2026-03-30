
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
- Request별 폴더: request_0001/, request_0002/, ...
- 각 request 폴더 기본 파일:
  - research1.md
  - research2.md
  - plan.md
  - report.md
  - review.md

### 예시

```text
docs/agent_docs/
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

### 코더 (Coder)

- researchN.md와 plan.md를 기준으로 구현한다.
- 컨텍스트 격리를 엄격하게 유지한다.
- 계획에 명시된 대상 파일만 찾아 읽고 수정한다.
- 구현 후 report.md에 변경 내용, 검증 결과, 계획과의 차이를 기록한다.

### 리뷰어 (Reviewer)

- plan.md와 report.md를 기준으로 구현 결과를 검토한다.
- 버그, 회귀 위험, 누락, 테스트 공백을 식별한다.
- review.md에 findings 중심으로 검토 결과를 남긴다.
- 원칙적으로 코드를 수정하지 않는다.

---

## 4. 협업 및 검증 프로세스

1. 리더가 사용자 요청을 분석하고 request 폴더를 생성한다.
2. 리더가 프로젝트 규모에 따라 리서처 수를 결정한다.
3. 리서처가 병렬 또는 순차로 연구를 수행하고 researchN.md를 작성한다.
4. 플래너가 연구 결과를 종합해 plan.md를 작성한다.
5. 코더가 plan.md에 따라 구현하고 report.md를 작성한다.
6. 리뷰어가 구현 결과를 검토하고 review.md를 작성한다.
7. 리더가 산출물을 취합해 사용자에게 보고하고, 필요하면 재연구, 재계획, 재구현을 지시한다.

---

## 5. 운영 원칙

- 리더만 사용자와 직접 대화한다.
- 코더의 컨텍스트는 researchN.md와 plan.md로 엄격하게 제한한다.
- 리더는 문서와 폴더는 수정할 수 있지만 애플리케이션 코드는 수정하지 않는다.
- 리뷰는 리더가 아니라 리뷰어가 전담한다.
- 리서처 수 조정은 프로젝트 규모, 병렬 조사 필요성, 컨텍스트 예산을 기준으로 결정한다.
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
  │   ├── coder.agent.md
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
      └── researcher-scaling/
          └── SKILL.md
```
