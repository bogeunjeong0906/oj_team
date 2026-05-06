# TAS v2 Report 1

## 목적

`plan_1.md`에서 승인된 모든 슬라이스를 구현하고, 실제 적용 내용과 검증 결과를 요약한다.

## 구현 범위

이번 턴에서는 Slice 0부터 Slice 5까지를 모두 구현했다.

## Slice 0. 구조 정합성 복구

### 구현 내용

- `tas.agent.md`에서 이미 삭제된 `context-preflight` 참조를 제거했다.
- `README.md`의 구조 설명을 현재 저장소 상태에 맞게 다시 정렬했다.
- `.github/tools/check-customization-integrity.sh`를 추가해 customization 저장소 내부 링크 무결성을 검사할 수 있게 했다.
- `customization-integrity-check` 스킬과 template을 추가했다.

### 결과

- 문서와 실제 파일 구조 사이의 가장 명백한 드리프트가 정리됐다.
- 이후 구조 변경 시 반복 가능한 무결성 검사 루틴이 생겼다.

## Slice 1. Execution 품질 게이트 도입

### 구현 내용

- `replacement-cleanup` 스킬과 cleanup summary template을 추가했다.
- `tas.agent.md`에 obsolete path 제거 기본값, retained legacy path 기록 의무, replacement cleanup 요구를 추가했다.
- `tas-artifact-policy.instructions.md`에 artifact 보존이 obsolete code 보존을 의미하지 않음을 명시했다.
- `request_0000/plan.md`와 `request_0000/report.md`에 replacement scope, deletion candidates, retained legacy path 기록 필드를 추가했다.

### 결과

- execution 단계가 단순 구현 추가보다 "대체 후 정리"를 기본값으로 따르도록 바뀌었다.
- 레거시 경로를 남기는 경우 이유와 제거 조건을 반드시 기록하도록 템플릿이 강화됐다.

## Slice 2. Pytest 품질 체계 도입

### 구현 내용

- `pytest-quality-gate` 스킬과 test linkage template을 추가했다.
- prompt 템플릿과 minimal prompt에 검증 전략, 최소 테스트 세트, 대체 범위 및 정리 기대사항 섹션을 추가했다.
- `request_0000/plan.md`와 `request_0000/report.md`에 테스트 링크 커버리지와 mock/fixture rationale 기록 필드를 추가했다.
- `tas.agent.md`에 validation이 어떤 event-chain link를 덮는지 기록하도록 요구를 추가했다.

### 결과

- pytest가 단순 통과 여부가 아니라 어떤 링크를 검증하는지 설명하도록 구조가 바뀌었다.
- failure reproduction, happy path, boundary condition, regression guard가 최소 검증 관점으로 정리됐다.

## Slice 3. 트러블슈팅 체계 강화

### 구현 내용

- `event-chain-troubleshooting` 스킬에 planning gate를 추가했다.
- `request_0000/research.md`에 validation targets, replacement and cleanup risks, analysis completion gate를 추가했다.
- `research-find` 스킬을 범용 grep 안내에서 체인 기반 제한 검색 스킬로 재정의했다.
- `research-find/assets/grep-templates.md`를 traceback, 입출력 링크, 대체 후보, dead path 찾기 중심으로 재구성했다.

### 결과

- analysis에서 가설과 cheapest check가 비어 있으면 plan으로 넘어가기 어렵도록 문서 게이트가 강화됐다.
- 검색 스킬이 "전체 탐색"보다 "가설 검증용 좁은 검색"을 우선하게 바뀌었다.

## Slice 4. 복잡도 및 토큰 효율 게이트 도입

### 구현 내용

- `complexity-gate` 스킬과 complexity review template을 추가했다.
- `tas.agent.md`를 장문 전역 서술에서 짧은 핵심 게이트 중심 구조로 축소했다.
- `request_0000/plan.md`에 complexity guardrails를 추가했다.
- `request_0000/report.md`에 complexity impact 섹션을 추가했다.
- `README.md`에 active code path 감소, 병렬 구현 억제 원칙을 반영했다.

### 결과

- TAS 본체 프롬프트가 이전보다 짧아졌고, 새 구조를 덧붙이는 행동보다 경로 수 축소를 우선하도록 바뀌었다.
- helper, branch, shim 증가를 예외적인 상황으로 다루는 기준이 생겼다.

## Slice 5. Customization Repo 자체 검증 루틴 추가

### 구현 내용

- `customization-integrity-check` 스킬과 integrity check template을 추가했다.
- `.github/tools/check-customization-integrity.sh`를 구현했다.
- `README.md`에 integrity check 운영 가드레일을 추가했다.
- `tas.agent.md` shared rules에 integrity check를 포함시켰다.

### 결과

- 구조 변경 후 README, agent, instruction, skill, asset 링크가 실제 파일을 가리키는지 즉시 확인할 수 있게 됐다.

## 주요 변경 파일

- `README.md`
- `.github/agents/tas.agent.md`
- `.github/instructions/tas-artifact-policy.instructions.md`
- `.github/prompt/request_prompt_template.md`
- `.github/prompt/request_prompt_minimal.md`
- `.github/agent_docs/request_0000/prompt.md`
- `.github/agent_docs/request_0000/research.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`
- `.github/skills/event-chain-troubleshooting/SKILL.md`
- `.github/skills/research-find/SKILL.md`
- `.github/skills/research-find/assets/grep-templates.md`
- `.github/skills/replacement-cleanup/SKILL.md`
- `.github/skills/replacement-cleanup/assets/cleanup-summary.template.md`
- `.github/skills/pytest-quality-gate/SKILL.md`
- `.github/skills/pytest-quality-gate/assets/test-linkage.template.md`
- `.github/skills/complexity-gate/SKILL.md`
- `.github/skills/complexity-gate/assets/complexity-review.template.md`
- `.github/skills/customization-integrity-check/SKILL.md`
- `.github/skills/customization-integrity-check/assets/integrity-check.template.md`
- `.github/tools/check-customization-integrity.sh`

## 검증 결과

- touched Markdown 및 skill 파일에 대해 Problems 검사를 수행했고 새 오류가 없음을 확인했다.
- `bash .github/tools/check-customization-integrity.sh` 실행 결과, customization integrity check가 통과했다.

## 계획 대비 주요 편차

- Slice 0에서 `context-preflight`를 복구하지 않고, 이미 삭제된 현재 저장소 상태에 맞춰 참조를 제거하는 방향을 택했다.
- Slice 5의 무결성 검사는 전용 shell script로 구현했다. 현재는 내부 Markdown 링크와 asset 경로 존재 여부 중심이며, 향후 더 정교한 구조 검사로 확장 가능하다.

## 남은 이슈

- integrity checker는 현재 Markdown 링크 무결성 중심이며, README의 모든 prose 구조 설명을 자동으로 검사하지는 않는다.
- pytest quality gate는 정책과 템플릿 수준까지 구현됐지만, 실제 프로젝트 코드베이스에서의 반복 적용 경험을 통해 더 다듬을 여지가 있다.

## 최종 결론

승인된 모든 슬라이스는 구현됐다. TAS v2는 이제 기존보다 더 짧은 agent 본문, 명시적인 cleanup 기본값, 테스트 링크 중심 검증 규칙, 복잡도 억제 규칙, customization 구조 무결성 검사 루틴을 갖춘 상태다.