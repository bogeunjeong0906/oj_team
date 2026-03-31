# Current Objective

TAS customization에서 실제 문법 문제가 되는 tool 이름 표기를 수정하고, `src` 트리에서 추가 정리 또는 보강이 필요한 지점을 계획 수준으로 정리한다.

## Locked Decisions

- `tas.agent.md`는 VS Code 공식 built-in tool set 이름인 `search`, `read`, `edit`, `execute`, `web` 중심으로 정리한다.
- subagent 금지는 문장 지시뿐 아니라 frontmatter `agents: []`로도 강제한다.
- 본문의 non-VS Code tool 표기는 `#tool:` 문법 기반으로 치환하고, Problems 참조는 `#tool:read/problems`로 통일한다.
- 구조 리뷰는 즉시 대규모 재배치 대신 우선 계획으로 남긴다.

## Scope and Assumptions

- 이번 실행은 active TAS 파일만 다룬다.
- asset 링크 경고는 실제 파일 부재가 아니라는 현재 확인 결과를 기준으로 한다.
- 구조 정리는 사용자 승인 없이 대규모 이동까지는 진행하지 않는다.

## Ordered Steps

1. active `src` 범위에서 구버전 tool 이름 또는 비정규 tool 표기를 찾는다.
2. `tas.agent.md` frontmatter를 공식 built-in tool set 기준으로 정리한다.
3. `tas.agent.md` 본문의 tool 이름을 공식 `#tool:` 문법으로 정리한다.
4. request artifact 기록 중 잘못된 tool 이름 서술도 현재 상태에 맞게 갱신한다.
5. Problems 기준으로 customization 파일 오류를 재검증한다.

## Target Files

- `src/.github/agents/tas.agent.md`
- `src/docs/agent_docs/request_0001/research.md`
- `src/docs/agent_docs/request_0001/plan.md`
- `src/docs/agent_docs/request_0001/report.md`

## Validation Plan

- `tas.agent.md`에 대해 Problems 검사를 다시 실행한다.
- `runCommands`, `runTasks`, `fetch`, `problems`, `changes`, `testFailure` 같은 구버전 frontmatter tool 이름 잔존 여부를 검색한다.
- `fetch_webpage`, `functions.fetch_webpage`, `get_errors` 잔존 여부를 검색한다.
- active `src` 경로에서 legacy orchestration 잔존 여부를 확인한다.

## Completion Criteria

- `tas.agent.md`에서 문법 오류가 없어야 한다.
- active customization 파일에서 구버전 또는 비정규 tool 표기가 제거되어야 한다.
- `src` 구조 리뷰 결과와 후속 정리 후보가 문서화되어야 한다.

## Rollback Triggers

- 공식 문서와 상충하는 tool 명세가 확인되면 frontmatter를 다시 조정한다.
- link warning이 실제 로딩 실패로 재현되면 링크 방식 자체를 다시 검토한다.

## Plan Changes

- 2026-03-31: 공식 tool set 이름 정정 작업을 반영해 검색 및 검증 항목을 확장했다.

## Change Log

- 2026-03-31: tool 이름 정리 및 `src` 구조 리뷰 계획 수립.
