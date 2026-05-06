# TAS v2 Plan 1

## 목적

`research_1.md`의 진단을 바탕으로, TAS v2를 "기록 중심 워크플로우"에서 "정확한 테스트, 절차적 트러블슈팅, 구조 단순화, 레거시 정리"를 강하게 강제하는 워크플로우로 재구성한다.

이번 계획은 `src` 전체 customization 구조를 대상으로 하는 대규모 개선조치 계획이며, 구현은 순차적 슬라이스 방식으로 진행한다.

## 최상위 목표

1. pytest가 단순 통과가 아니라 실패 링크를 증명하는 테스트가 되도록 강제한다.
2. 이벤트 체인 기반 트러블슈팅을 문서 수준이 아니라 실행 게이트 수준으로 끌어올린다.
3. 새 구현이 들어올수록 코드가 짧아지고 단순해지도록 구조적 압력을 만든다.
4. 대체된 레거시 경로와 dead code를 기본적으로 제거하도록 execution 규칙을 바꾼다.
5. README, agent, skills, instructions 간 참조 드리프트를 자동으로 드러내는 구조를 만든다.

## 성공 기준

- TAS 본체 규칙이 장문 서술보다 실행 품질 게이트 중심으로 재편된다.
- pytest 품질 전용 skill 또는 instruction이 추가되고, 테스트 최소 세트가 정의된다.
- execution 단계에서 obsolete path 제거 여부와 잔존 레거시 사유를 반드시 기록하게 된다.
- request artifact 템플릿이 테스트 품질, 체인 검증, 구조 단순화 점검을 포함하게 된다.
- customization repo 내부 참조 무결성을 확인하는 검증 루틴이 추가된다.

## 설계 원칙

- 새 장치를 추가하되, TAS 본체의 전역 프롬프트는 지금보다 더 짧고 결정적이어야 한다.
- 정책은 가능하면 전용 skill 또는 instruction으로 분리하고, agent 본문에는 핵심 게이트만 남긴다.
- 테스트와 트러블슈팅은 모두 "어느 링크를 검증하는가"를 기준으로 정렬한다.
- 새 규칙은 "기록 권장"이 아니라 "다음 단계로 넘어가기 전 확인해야 하는 문턱" 형태로 설계한다.
- 레거시 코드는 보존보다 제거를 기본값으로 하고, 예외만 기록한다.

## 작업 순서 개요

1. 구조 정합성 복구
2. execution 품질 게이트 도입
3. pytest 품질 체계 도입
4. 트러블슈팅 체계 강화
5. 복잡도/토큰 효율 게이트 도입
6. 문서/템플릿/README 정렬

## Slice 0. 구조 정합성 복구

### 목적과 범위

- 현재 구조에 이미 존재하는 드리프트를 제거한다.
- 참조 무결성 검사를 도입하기 전에, README와 agent가 실제 파일 구조와 맞도록 만든다.

### 선행 조건

- 없음

### 대상 파일과 변경

- `.github/agents/tas.agent.md`
- `README.md`
- `.github/skills/context-preflight/` 관련 복구 또는 참조 제거
- 필요 시 `.github/instructions/` 또는 `.github/skills/`에 구조 무결성 검사 규칙 초안 추가

### 세부 조치

- `context-preflight`를 실제로 복구할지, 참조를 제거할지 결정한다.
- README의 구조 설명과 실제 파일 트리를 다시 맞춘다.
- agent가 읽는 shared rules 목록 중 존재하지 않는 항목이 없도록 정리한다.

### 검증과 완료 기준

- README, agent, skill 참조 경로가 실제 파일 구조와 일치한다.
- 더 이상 존재하지 않는 skill/instruction 링크가 남아 있지 않다.
- touched Markdown 파일 Problems 검사에서 오류가 없다.

### 롤백 트리거

- `context-preflight`의 개념적 가치가 크다고 판단되는데 복구 방향이 불명확한 경우
- 참조 제거가 다른 계획 슬라이스와 충돌하는 경우

## Slice 1. Execution 품질 게이트 도입

### 목적과 범위

- execution 단계가 "구현 추가"보다 "구현 대체와 정리"를 기본으로 따르도록 만든다.
- obsolete path 제거, dead code pruning, replacement cleanup을 명문화한다.

### 선행 조건

- Slice 0 완료

### 대상 파일과 변경

- `.github/agents/tas.agent.md`
- `.github/instructions/tas-artifact-policy.instructions.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`
- 필요 시 새 instruction 또는 skill 추가

### 세부 조치

- execution 규칙에 "새 구현이 기존 경로를 대체하면 구 경로 제거가 기본값"임을 추가한다.
- 제거하지 않은 레거시 경로는 이유와 제거 보류 조건을 report에 기록하게 한다.
- plan에 "대체 대상 경로", "삭제 후보 경로", "정리 후 예상 활성 경로" 항목을 추가한다.
- report에 "실제 제거한 경로", "남겨둔 경로와 이유" 항목을 추가한다.

### 검증과 완료 기준

- execution 관련 템플릿과 policy에 obsolete cleanup 문턱이 반영된다.
- agent 본문이 replacement cleanup을 명시적으로 요구한다.
- 레거시 경로를 남기는 경우 기록해야 할 필드가 템플릿에 존재한다.

### 롤백 트리거

- 너무 공격적인 삭제 기본값이 사용자 요청 언어 또는 보존 정책과 충돌하는 경우
- artifact 보존 규칙과 코드 정리 규칙 사이에서 해석 충돌이 생기는 경우

## Slice 2. Pytest 품질 체계 도입

### 목적과 범위

- pytest를 단순 통과 체크가 아니라 실패 링크를 증명하는 검증 도구로 재정의한다.
- 테스트 최소 세트와 mock/fixture 사용 기준을 명문화한다.

### 선행 조건

- Slice 1 완료

### 대상 파일과 변경

- 새 skill 또는 instruction: 예시 `pytest-quality-gate`
- `.github/agents/tas.agent.md`
- `.github/prompt/request_prompt_template.md`
- `.github/prompt/request_prompt_minimal.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`
- 필요 시 관련 asset template 추가

### 세부 조치

- pytest 품질 전용 문서를 추가한다.
- 최소 테스트 세트를 정의한다.
  - 실패 재현 테스트
  - 정상 경로 테스트
  - 경계 조건 테스트
  - 회귀 방지 테스트
- mock/fixture 사용 시 "고정하는 링크"와 "검증하는 링크"를 반드시 적게 한다.
- plan 템플릿에 테스트 설계 표 또는 체크리스트를 넣는다.
- report 템플릿에 실제로 추가한 테스트가 어떤 링크를 검증했는지 기록하게 한다.

### 검증과 완료 기준

- pytest 전용 skill/instruction이 추가된다.
- prompt와 artifact 템플릿이 테스트 설계 정보를 수집한다.
- agent가 테스트 최소 세트와 링크 명시를 요구한다.

### 롤백 트리거

- 테스트 규칙이 지나치게 무거워져 간단한 작업에도 과잉 설계를 강요하는 경우
- Python 외 작업에도 부자연스럽게 적용되는 경우

## Slice 3. 트러블슈팅 체계 강화

### 목적과 범위

- event-chain troubleshooting을 권고가 아니라 실행 강제 규칙에 가깝게 강화한다.
- `research-find`를 체인 기반 조사와 직접 연결한다.

### 선행 조건

- Slice 2 완료

### 대상 파일과 변경

- `.github/skills/event-chain-troubleshooting/SKILL.md`
- `.github/skills/research-find/SKILL.md`
- `.github/skills/research-find/assets/grep-templates.md`
- `.github/agents/tas.agent.md`
- `.github/agent_docs/request_0000/research.md`
- `.github/agent_docs/request_0000/plan.md`

### 세부 조치

- `research.md`에 hypothesis와 cheapest check를 채우지 않으면 plan으로 넘어가기 어렵게 하는 규칙을 도입한다.
- `research-find`를 "키워드 검색"이 아니라 "체인의 특정 링크를 찾기 위한 제한 검색"으로 재정의한다.
- grep 템플릿도 증거 목적별로 재구성한다.
  - 예외/traceback 원인 찾기
  - 특정 링크의 입출력 경로 찾기
  - 대체 후보 경로 찾기
  - dead path 의심 경로 찾기
- agent 본문에서 넓은 탐색보다 가설 기반 검색을 더 강하게 우선시한다.

### 검증과 완료 기준

- event-chain 문서와 research 템플릿이 직접 연결된다.
- `research-find`가 좁은 체인 검색 스킬로 바뀐다.
- plan으로 넘어가기 전 필요한 분석 정보가 구체적으로 정의된다.

### 롤백 트리거

- agent 본문과 skill 문서 사이 역할 중복이 지나치게 커지는 경우
- 분석 게이트가 너무 무거워져 작은 작업도 불필요하게 느려지는 경우

## Slice 4. 복잡도 및 토큰 효율 게이트 도입

### 목적과 범위

- 새 구현이 기존 구현보다 더 단순해졌는지, 아니면 경로 수와 분기 수를 늘렸는지를 점검하는 구조를 만든다.

### 선행 조건

- Slice 3 완료

### 대상 파일과 변경

- 새 instruction 또는 skill: 예시 `simplification-budget` 또는 `complexity-gate`
- `.github/agents/tas.agent.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`
- 필요 시 `README.md`

### 세부 조치

- helper 추가, branch 추가, shim 추가 시 정당화 규칙을 만든다.
- "기존 경로를 대체했는가", "활성 경로 수가 늘었는가", "중복 분기를 만들었는가"를 self-review 항목으로 추가한다.
- 가능한 경우 "이번 변경으로 제거된 구조"를 기록하게 한다.
- 토큰 효율을 위해 agent 본문에서 장황한 전역 서술을 더 줄이고, 외부 문서 참조 방식으로 이동한다.

### 검증과 완료 기준

- complexity gate 문서가 추가된다.
- plan/report에 단순화 여부를 기록하는 필드가 생긴다.
- agent 본문이 복잡도 증가를 예외적 상황으로 다루게 된다.

### 롤백 트리거

- 지나치게 기계적인 복잡도 규칙이 실제 개선 작업을 방해하는 경우
- 복잡하지만 필요한 구조를 허용하는 예외 규칙이 부족한 경우

## Slice 5. Customization Repo 자체 검증 루틴 추가

### 목적과 범위

- customization 저장소 자체가 장기적으로 드리프트하지 않도록 내부 검증 루틴을 만든다.

### 선행 조건

- Slice 4 완료

### 대상 파일과 변경

- 새 skill 또는 instruction: 예시 `customization-integrity-check`
- 필요 시 검증용 스크립트 또는 체크리스트 문서
- `.github/agents/tas.agent.md`
- `README.md`

### 세부 조치

- README, agent, instruction, skill 간 참조 무결성 확인 규칙을 만든다.
- 템플릿 경로, 참조 asset 경로, 실제 존재 여부를 점검하는 절차를 추가한다.
- 최소한 수동 체크리스트라도 둔다.
- 가능하면 추후 스크립트화 가능한 구조로 설계한다.

### 검증과 완료 기준

- 참조 무결성 점검 절차가 문서화된다.
- 현재 저장소 기준으로 드리프트를 탐지할 수 있다.
- 향후 새 skill/instruction 추가 시 정합성 검사를 적용할 수 있다.

### 롤백 트리거

- 저장소 규모 대비 검증 장치가 과도하게 무거운 경우
- 수동 문서 검증과 자동 검증의 책임 경계가 불명확한 경우

## 영향 파일 맵

### 핵심 수정 파일

- `.github/agents/tas.agent.md`
- `.github/instructions/tas-artifact-policy.instructions.md`
- `README.md`
- `.github/prompt/request_prompt_template.md`
- `.github/prompt/request_prompt_minimal.md`
- `.github/agent_docs/request_0000/research.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`

### 신규 추가 가능성이 높은 파일

- `.github/skills/pytest-quality-gate/SKILL.md`
- `.github/skills/pytest-quality-gate/assets/...`
- `.github/skills/complexity-gate/SKILL.md`
- `.github/skills/customization-integrity-check/SKILL.md`
- `.github/instructions/...` 하위의 보완 규칙 파일

## 권장 실행 방식

- 한 슬라이스씩 구현하고 검증한다.
- 각 슬라이스 완료 시 README와 agent, 템플릿의 정렬 상태를 다시 확인한다.
- 전 슬라이스를 한 번에 바꾸지 않는다.
- 특히 Slice 1과 Slice 2를 먼저 완료해야 이후 구조가 안정된다.

## 우선 착수 권고

첫 구현 턴은 Slice 0과 Slice 1을 묶어 진행하는 것이 가장 효과적이다.

이유:

- 현재 이미 존재하는 구조 드리프트를 먼저 줄여야 이후 규칙 추가가 정확해진다.
- obsolete path 제거 원칙이 먼저 들어가야 나머지 개선이 코드 누적 문제를 악화시키지 않는다.

## 최종 결론

TAS v2의 본질은 기능 추가가 아니라, execution 단계에 강한 품질 문턱을 세우는 구조조정이다. 우선순위는 "정합성 복구 -> 레거시 정리 기본값화 -> pytest 품질 체계화 -> 트러블슈팅 강제화 -> 복잡도 억제" 순서로 잡는 것이 가장 합리적이다.