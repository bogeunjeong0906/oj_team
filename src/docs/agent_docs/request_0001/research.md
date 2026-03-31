# Current Summary

TAS customization의 경고와 tool 문법을 점검했다. 첨부된 경고 중 상대 링크와 asset 링크는 실제 파일 부재가 아니라, 현재 워크스페이스 기준으로는 파일이 모두 존재하는 상태였다. 실제 수정이 필요한 항목은 `tas.agent.md`의 tool frontmatter와 본문 내 VS Code customization 문법에 맞지 않는 tool 이름 표기였다.

## Stable Findings

- `src/.github/agents/tas.agent.md`의 기존 `tools` 목록에는 `runCommands`, `runTasks`, `fetch`, `problems`, `changes`, `testFailure`처럼 구버전 또는 비정규 약식 이름이 남아 있었다.
- 현재 VS Code 공식 문서 기준으로 custom agent frontmatter에는 built-in tool set 또는 정확한 tool name을 써야 하며, 대표적인 built-in tool set은 `search`, `read`, `edit`, `execute`, `web`이다.
- `tas.agent.md` 본문에는 `fetch_webpage`, `functions.fetch_webpage`, `get_errors`처럼 이 저장소의 customization 문법이 아닌 외부 실행 문맥용 표기가 남아 있었다.
- 첨부된 path warning 대상 파일은 실제 워크스페이스 안에 모두 존재했다.
- 활성 `src` 트리는 이미 TAS 전용으로 충분히 축소되어 있다.
- `src/.github/prompts/`는 현재 비어 있으며 즉시 문제는 아니지만 엄격한 TAS-only 최소구성 관점에서는 archive 후보다.

## Scope Investigated

- `src/.github/agents/tas.agent.md`
- `src/.github/instructions/*`
- `src/.github/skills/*`
- `src/README.md`
- `src/docs/agent_docs/request_0000/*`

## Codebase Facts

- 활성 agent는 `tas.agent.md` 하나뿐이다.
- 활성 instructions는 두 개뿐이다.
- 활성 skills는 다섯 개이며 필요한 asset 파일도 모두 존재한다.
- `request_0000`만 존재하고 활성 작업 request는 아직 없었다.

## External or Domain Facts

- VS Code 공식 문서는 custom agent body에서 다른 파일 재사용에 Markdown link를 허용한다.
- VS Code 공식 문서는 skill directory 내부 리소스를 상대경로로 참조하는 방식을 명시적으로 허용한다.
- VS Code 공식 문서는 tool 언급 시 `#tool:<tool-name>` 형식을 사용하도록 안내하며 예시로 `#tool:web/fetch`를 든다.
- VS Code built-in chat tools reference는 `#edit`, `#execute`, `#read`, `#search`, `#web`를 tool set으로 제시하고, 세부 tool 이름으로 `#execute/runInTerminal`, `#execute/testFailure`, `#read/problems`, `#search/changes`, `#search/codebase`, `#web/fetch` 등을 제시한다.
- custom agent frontmatter의 invalid tool은 무시될 수 있으므로 안정적인 공식 tool set 위주로 좁히는 편이 안전하다.

## Constraints for Implementation

- 불필요한 활성 파일 정리는 바로 삭제가 아니라 검토 후 계획으로 남긴다.
- 기존 TAS-only 구조와 artifact 정책은 유지한다.
- 변경은 최소 범위로 적용한다.

## Open Questions

- `src/.github/prompts/` 빈 디렉터리를 즉시 `ref/`로 옮길지 여부는 아직 결정하지 않았다.
- 향후 `.github/copilot-instructions.md`를 추가할 필요가 생길지 여부는 현재로서는 불명확하다.

## Follow-up Research

- 다음 점검 시에는 Chat Customizations diagnostics 화면 기준 warning 재현 여부를 추가 확인할 수 있다.
- active `src` 범위에서 남아 있는 구버전 tool 명칭은 request artifact 기록 안의 과거 서술뿐이며, customization 동작 파일에서는 제거하는 방향이 적절하다.

## Change Log

- 2026-03-31: tool 이름/문법 경고 원인 분석 및 `src` 구조 리뷰 초안 작성.
- 2026-03-31: VS Code 공식 built-in tool set 이름 기준으로 TAS tool 명칭 정정 근거 추가.
