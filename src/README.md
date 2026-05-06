# TAS 커스터마이징 저장소

이 저장소는 단일 에이전트인 TAS를 중심으로 VS Code Copilot용 customization 파일을 관리한다. 현재 목적은 Beast Mode의 해결력을 유지하면서 요청별 산출물을 남겨 새 세션에서도 필요한 컨텍스트만 이어받을 수 있게 하는 것이다.

## 핵심 원칙

- TAS는 단독 에이전트다.
- TAS의 본체는 Beast Mode 3.1을 거의 그대로 계승한다.
- TAS는 비단순 작업에서 request artifact를 사용한다.
- request artifact의 기준점은 `prompt.md`이며, 이후 analysis/plan/execution 산출물은 이를 기준으로 정렬한다.
- request artifact는 `.github/agent_docs/request_XXXX/` 아래에 저장한다.
- `request_0000`은 공식 템플릿이며 활성 작업에 사용하지 않는다.
- 단계는 analysis, plan, execution 세 개뿐이다.
- 기본적으로 한 턴에 한 단계만 완료하고 종료한다.
- 사용자가 연속 진행을 명시적으로 요청한 경우에만 analysis -> plan -> execution 순서로 이어서 수행할 수 있다.
- artifact 기본 언어는 사용자의 요청 언어를 따른다.
- 후속 수정이나 추가 연구를 하더라도 기존 artifact의 내용을 지우지 않고 누적 갱신한다.
- 수정 전후 Problems 상태를 확인하고 Markdown과 customization 파일도 검증 대상에 포함한다.
- TAS는 문제 해결 시 패턴 매칭보다 이벤트 체인 기반 트러블슈팅을 우선한다.
- `research-find`는 광범위 탐색 도구가 아니라, 실패 링크와 검색 목적이 정해진 뒤 좁게 사용하는 보조 장치다.

## 현재 구조

```text
.github/
  agents/
    tas.agent.md
  instructions/
    markdown-docs.instructions.md
    tas-artifact-policy.instructions.md
  skills/
    clarification-fallback/
    context-preflight/
    event-chain-troubleshooting/
    git-commit-workflow/
    python-execution-environment/
    problems-lint-gate/
    research-find/
docs/
  agent_docs/
    request_0000/
```

실제 템플릿 경로는 `.github/agent_docs/request_0000/` 이다.

이외의 예전 team orchestration 관련 파일은 삭제하지 않고 루트 `ref/` 아래로 이동해 보관한다.

## Request Artifact 모델

모든 비단순 TAS 작업은 아래 구조를 기본으로 사용한다.

```text
.github/agent_docs/request_XXXX/
  prompt.md
  research.md
  plan.md
  report.md
```

- `prompt.md`: 사용자 요구사항, 제약, 완료 기준을 정리한 주문명세서
- `research.md`: 분석 결과, 구현 경계, 후속 연구 누적 기록
- `plan.md`: 실행 계획, 검증 계획, 계획 변경 이력
- `report.md`: 이번 실행 결과, 검증, self-review, 잔여 이슈

## TAS 표준 흐름

1. TAS가 활성 request를 재사용할지 새로 만들지 결정한다.
2. `prompt.md`에 현재 사용자 요구사항과 제약을 기준 문서로 정리하거나 갱신한다.
3. analysis 단계에서 필요한 조사만 수행하고 `research.md`를 갱신한다.
4. plan 단계에서 `prompt.md`와 `research.md`를 읽고 `plan.md`를 갱신한다.
5. execution 단계에서 `prompt.md`, `research.md`, `plan.md`를 읽고 구현, 검증, self-review 후 `report.md`를 갱신한다.
6. 후속 수정이 들어오면 같은 request를 재사용하되 필요 시 plan 또는 analysis로 롤백한다.

## 문서 보존 원칙

- 기존 artifact를 통째로 덮어쓰지 않는다.
- 새 연구나 새 계획은 기존 내용을 보존한 채 추가하거나 수정 이력으로 남긴다.
- 더 이상 유효하지 않은 내용은 삭제 대신 `Superseded` 또는 `Revised`로 표시한다.
- 부분 추가 연구를 수행할 때도 기존 findings와 decisions를 유지한다.
- 다음 단계로 갈수록 이전 단계 artifact를 먼저 읽는다.

## 운영 가드레일

### Context Preflight

- 작업 범위가 크면 시작 전에 working set 위험을 추정한다.
- 위험이 높으면 working set을 줄이거나 artifact에 상태를 먼저 요약한다.

### Event-Chain Troubleshooting

- 문제를 성공 조건과 필수 프로세스 체인으로 먼저 분해한다.
- 체인의 어느 링크가 깨졌는지 가설 하나와 가장 싼 검증 하나로 좁혀간다.
- 트레이스백, 로그, 좁은 테스트, mock을 소스 대탐색보다 우선한다.
- `research-find`는 실패 링크와 검색 목적이 정해진 뒤에만 사용한다.

### Clarification Fallback

- 질문은 안정적인 구현을 막는 실질적 모호성에서만 허용한다.
- 질문은 한 번에 묶는다.
- 답이 없으면 저장소 정책, 그다음 산업 표준을 따른다.

### Python Execution Environment

- Python 스크립트 실행 시 먼저 레포 루트의 가상환경을 찾는다.
- 레포 로컬 환경이 있으면 그것을 1순위로 사용한다.
- 로컬 환경이 없으면 현재 활성 전역 환경이나 `base` 같은 전역 환경을 2순위로 사용한다.

### Git Commit and Push

- stage, commit, push는 사용자가 명시적으로 요청한 경우에만 수행한다.
- 관련 없는 변경은 가능한 한 제외한다.

### Problems and Lint Gate

- touched file에 새 오류를 남기지 않는다.
- customization Markdown도 완료 전에 검사한다.

## 참고

- TAS 원형은 루트의 `sample_beastmode.md`를 기준으로 유지한다.
- 예전 에이전트와 지침은 향후 참조를 위해 루트 `ref/` 아래에 보관한다.
