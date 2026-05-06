# TAS v2 Research 1

## 목적

`src` 전체 customization 파일을 읽고, 현재 TAS 워크플로우가 다음 문제를 왜 충분히 막지 못하는지 분석한다.

- pytest의 정확도가 만족스럽지 않음
- 트러블슈팅 정확도가 만족스럽지 않음
- 생성 코드가 길고 복잡해 토큰 효율이 낮고 후속 트러블슈팅이 어려움
- 새 구현이 생겨도 레거시 코드가 자동으로 정리되지 않아 dead code가 누적됨

## 검토 범위

실제 존재하는 아래 파일들을 모두 읽어 검토했다.

- `README.md`
- `.github/agents/tas.agent.md`
- `.github/instructions/tas-artifact-policy.instructions.md`
- `.github/instructions/markdown-docs.instructions.md`
- `.github/prompt/request_prompt_template.md`
- `.github/prompt/request_prompt_minimal.md`
- `.github/skills/clarification-fallback/SKILL.md`
- `.github/skills/clarification-fallback/assets/clarification-decision.template.md`
- `.github/skills/event-chain-troubleshooting/SKILL.md`
- `.github/skills/git-commit-workflow/SKILL.md`
- `.github/skills/git-commit-workflow/assets/commit-summary.template.md`
- `.github/skills/problems-lint-gate/SKILL.md`
- `.github/skills/problems-lint-gate/assets/problems-lint-checklist.template.md`
- `.github/skills/python-execution-environment/SKILL.md`
- `.github/skills/research-find/SKILL.md`
- `.github/skills/research-find/assets/grep-templates.md`
- `.github/agent_docs/request_0000/prompt.md`
- `.github/agent_docs/request_0000/research.md`
- `.github/agent_docs/request_0000/plan.md`
- `.github/agent_docs/request_0000/report.md`

추가로, README와 agent에서 참조하는 `.github/skills/context-preflight/SKILL.md`는 현재 실제 파일이 없다.

## 현재 구조의 강점

- request artifact 구조가 있어 세션 간 문맥 보존은 비교적 잘 된다.
- `prompt.md`, `research.md`, `plan.md`, `report.md`로 역할 분리가 되어 있다.
- 최근 추가된 event-chain troubleshooting 방향은 문제를 절차 체인으로 보려는 의도가 분명하다.
- Problems gate와 Python environment 규칙이 있어 최소한의 실행 안정성은 고려되어 있다.

## 핵심 진단

현재 TAS는 "조사와 기록"을 위한 규칙은 꽤 많지만, "품질 좋은 변경만 남기고 나쁜 변경 구조를 줄이는 규칙"은 약하다. 그 결과 아래 네 가지 문제가 반복될 가능성이 높다.

### 1. pytest 정확도를 강제하는 장치가 거의 없다

현재 pytest 관련 규칙은 프롬프트 예시나 문장 수준의 권고에 가깝고, 테스트 설계의 품질을 강제하는 전용 정책이 없다.

관찰 근거:

- `tas.agent.md`는 좁은 테스트와 mock 사용을 권장하지만, 어떤 테스트가 충분한지 정의하지 않는다.
- `request_prompt_template.md`에는 "pytest로 모든 테스트 통과" 예시가 있지만, 이는 예시일 뿐 강제 규칙이 아니다.
- `plan.md`와 `report.md` 템플릿에는 validation 섹션이 있으나, 테스트 범위 분해 기준이 없다.
- 별도의 pytest skill, regression-test policy, test design rubric, mock strategy 문서가 없다.

문제 결과:

- 테스트가 단순 통과 여부 중심으로 흐를 수 있다.
- mock 기반 테스트를 쓰더라도 어떤 링크를 고정하고 어떤 링크를 검증하는지 불명확하다.
- 실패 재현 테스트, 회귀 방지 테스트, 정상 경로 테스트, 경계 조건 테스트의 최소 세트가 정의되어 있지 않다.
- 따라서 모델이 만든 pytest가 실제 결함을 잘 잡지 못하거나, 너무 넓고 비싼 테스트를 만들 가능성이 있다.

### 2. 트러블슈팅 정확도는 좋아졌지만 아직 실행 게이트가 약하다

event-chain troubleshooting은 방향은 좋지만, 실제 agent 전체를 지배하는 수준의 강한 게이트는 아니다.

관찰 근거:

- `event-chain-troubleshooting/SKILL.md`는 훌륭한 절차를 제시하지만, 실제 산출물 템플릿에 필수 체크리스트로 강제되지는 않는다.
- `research.md`에는 hypothesis와 cheapest check 항목이 추가되었지만, 채우지 않아도 다음 단계로 넘어가는 것을 막는 구조는 없다.
- `tas.agent.md`는 여전히 장문의 전역 규칙을 많이 담고 있어, 모델이 본문 전체의 서술 압력에 끌릴 가능성이 남아 있다.
- `research-find`는 아직도 grep 중심의 범용 검색 스킬로 남아 있어, 체인 기반 조사와 직접 연결되지 않는다.

문제 결과:

- 문제를 이벤트 체인으로 분해하려는 의도는 있으나, 실제 작업 중 다시 넓은 탐색으로 돌아갈 수 있다.
- 가설 하나와 가장 싼 검증 하나를 유지하지 못하면, 모델이 익숙한 코드 패턴이나 표면 증상에 끌릴 수 있다.
- 분석 artifact에 적힌 좋은 절차가 실행 단계의 의사결정을 완전히 제어하지 못한다.

### 3. 코드 단순화와 토큰 효율을 강제하는 규칙이 없다

현재 구조에는 "더 짧고 단순한 구현을 우선하라"는 방향은 있지만, 복잡도를 차단하는 명시적 게이트가 없다.

관찰 근거:

- `tas.agent.md`에는 narrow/local/token-efficient라는 표현이 있으나, 코드 복잡도에 대한 정량적 또는 구조적 제한은 없다.
- 어떤 경우에 helper 분리, 어떤 경우에 inline 유지, 어떤 경우에 기존 흐름 재사용을 우선할지 기준이 없다.
- plan/report 템플릿에는 변경 후 구조 복잡도 증가 여부를 점검하는 항목이 없다.
- dead branch, duplicate branch, temporary compatibility shim, one-off adapter 같은 복잡도 냄새를 탐지하는 규칙이 없다.

문제 결과:

- 모델이 안전하게 보이기 위해 방어 분기와 보조 함수를 계속 추가할 수 있다.
- 기존 흐름을 대체하는 대신 새 흐름을 병렬로 덧붙이는 식의 수정이 쉽게 발생한다.
- 후속 세션에서 active code path를 식별하는 비용이 계속 커진다.

### 4. 레거시 코드와 dead code를 정리하는 정책이 없다

이 부분이 현재 구조의 가장 큰 결함 중 하나다. 보존 정책은 강한데, 제거 정책은 사실상 없다.

관찰 근거:

- `tas-artifact-policy.instructions.md`는 artifact 내용 보존에 강하게 치우쳐 있다.
- 코드 변경에 대해 obsolete path removal, dead code pruning, replacement cleanup, migration completion check 같은 규칙이 없다.
- `problems-lint-gate`는 새 오류만 막고, 불필요한 코드 잔존은 차단하지 않는다.
- 전체 저장소에서 legacy, obsolete, cleanup, prune, deprecate 같은 정리 규칙은 거의 보이지 않는다.

문제 결과:

- 새 구현이 추가되어도 구 구현이 함께 남기 쉽다.
- 모델은 남아 있는 구 경로를 활성 경로로 오해할 수 있다.
- 추후 수정 시 데드코드와 실제 코드의 구분 비용이 커진다.
- 토큰 사용량과 분석 시간이 함께 증가한다.

## 구조적 추가 문제

### 5. 문서와 실제 구조가 이미 드리프트하고 있다

가장 명확한 증거는 `context-preflight`다.

관찰 근거:

- `README.md`와 `tas.agent.md`는 `context-preflight`를 참조한다.
- 실제 `.github/skills/context-preflight/SKILL.md`는 존재하지 않는다.

문제 결과:

- 에이전트가 기대하는 워크플로우와 실제 저장소 구조 사이에 차이가 생겼다.
- 이런 종류의 드리프트는 이후에도 누적되기 쉽고, TAS v2에서 반드시 막아야 한다.

### 6. request artifact는 충실하지만 execution quality gate가 약하다

artifact는 잘 쌓이지만, 그 artifact가 낮은 품질 구현을 차단하는 문턱 역할까지 하지는 못한다.

관찰 근거:

- `prompt.md`는 요구사항 정리에는 좋다.
- `research.md`는 분석 기록에는 좋다.
- `plan.md`와 `report.md`는 단계 분리에는 좋다.
- 하지만 "이 구현이 기존 구현을 대체하는가", "obsolete path를 제거했는가", "pytest가 체인의 주요 링크를 각각 검증하는가" 같은 실행 품질 질문은 없다.

문제 결과:

- 문서는 남지만 코드 품질 상승으로 자동 연결되지 않는다.
- execution 단계에서 결과물의 구조 건강도를 충분히 심사하지 못한다.

## 원인 요약

현재 TAS의 문제는 단순히 모델 성능 부족이 아니라, 워크플로우가 아래 편향을 갖기 때문이다.

1. 보존 편향
기존 기록은 잘 남기지만, 대체된 코드나 쓸모없는 경로를 제거하는 규칙이 없다.

2. 통과 편향
테스트는 "무언가 통과했는가"를 보기 쉽고, "정확히 어떤 실패 링크를 증명했는가"를 덜 묻는다.

3. 추가 편향
새 구조를 덧붙이는 쪽이 기존 구조를 접고 정리하는 것보다 더 쉽게 허용된다.

4. 문서 편향
좋은 절차가 문서에는 존재하지만, 실행 단계에서 강한 게이트로 작동하지 않는다.

## TAS v2에서 필요한 방향

이번 research는 구현이 아니라 분석이므로, 방향만 정리한다.

### A. pytest 품질을 위한 전용 장치 필요

- pytest 전용 skill 또는 instruction이 필요하다.
- 최소 테스트 세트를 정의해야 한다.
  - 실패 재현 테스트
  - 정상 경로 테스트
  - 경계 조건 테스트
  - 회귀 방지 테스트
- mock/fixture 사용 시 "어느 링크를 가정하고 어느 링크를 검증하는지"를 명시하게 해야 한다.
- 테스트는 체인 링크 단위로 설명되게 해야 한다.

### B. execution에 "대체 후 정리" 게이트 필요

- 새 구현이 기존 경로를 대체하면 obsolete path 제거를 기본값으로 삼아야 한다.
- 삭제하지 않고 남겨야 하는 경우에만 이유를 기록하게 해야 한다.
- report나 plan에 "남겨둔 레거시 경로"와 "제거하지 않은 이유"를 반드시 적게 해야 한다.

### C. 복잡도 예산 또는 단순화 규칙 필요

- 새 helper, 새 branch, 새 shim 추가 시 정당화 규칙이 필요하다.
- 기존 로직 재사용과 교체 중 무엇을 택했는지 기록하게 해야 한다.
- execution self-review에 "이번 변경이 코드 경로 수를 늘렸는가 줄였는가"를 넣는 것이 좋다.

### D. 구조 드리프트 탐지 장치 필요

- README, agent, skills 참조 무결성 검사가 필요하다.
- 참조된 skill/instruction 파일이 실제로 존재하는지 확인하는 lint가 유용하다.
- 최소한 customization repo 자체에 대한 구조 정합성 검사가 있어야 한다.

## 우선순위 결론

TAS v2에서 가장 먼저 해결해야 할 우선순위는 아래 순서로 보인다.

1. execution 단계의 레거시/obsolete 코드 제거 원칙 추가
2. pytest 품질 전용 skill 또는 instruction 추가
3. execution/report에 복잡도 감소 여부와 남은 레거시 경로를 강제 기록
4. customization 파일 참조 무결성 검사 추가
5. `research-find`를 event-chain 기반 조사와 직접 결합하도록 재설계

## 한 줄 결론

현재 TAS는 "잘 조사하고 잘 기록하는 구조"에는 가까워졌지만, 아직 "짧고 정확한 코드만 남기고 오래된 코드는 걷어내는 구조"는 아니다. TAS v2의 핵심은 새로운 기능을 더하는 것보다, execution 단계에 테스트 품질 게이트와 obsolete code 제거 게이트를 추가하는 방향이어야 한다.