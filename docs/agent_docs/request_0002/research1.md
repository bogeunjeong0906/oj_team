# Summary

이번 요청의 핵심은 리더가 직접 수행한 작업과 서브에이전트가 수행한 작업을 사용자가 분명하게 구분할 수 있도록 오케스트레이션 규칙을 강화하는 것이다.

## Scope Investigated

- 리더 응답에서 실행 주체를 노출하는 방식
- 서브에이전트 위임 결과를 사용자에게 설명하는 규칙
- 현재 leader.agent.md, orchestration.instructions.md, researcher-scaling skill의 갭

## Codebase Facts

- 현재 리더 정의에는 허용 subagent 목록인 `agents` frontmatter가 없다.
- 현재 오케스트레이션 규칙에는 사용자가 stage별 실행 주체를 식별해야 한다는 요구가 없다.
- 현재 researcher scaling skill은 researcher 복제와 제거 규칙은 있지만 leader의 허용 subagent 목록 동기화 규칙은 없다.

## External or Domain Facts

- VS Code custom agents는 `agents` frontmatter로 허용 subagent를 제한할 수 있다.
- custom agent 설명과 frontmatter name은 서브에이전트 선택 품질에 영향을 준다.
- subagent orchestration은 coordinator가 각 stage의 소유권과 결과를 명확히 드러낼수록 사용자가 감사하기 쉬워진다.

## Constraints for Implementation

- 리더는 사용자에게 직접 보이는 응답 형식을 바꿔야 하지만 product code는 건드리면 안 된다.
- 실행 주체 식별 규칙은 leader agent, instructions, skill에 중복 배치되어야 한다.
- 새 규칙은 researcher scaling과 충돌하지 않아야 한다.

## Risks and Open Questions

- ledger가 너무 무거우면 단순 요청에도 과도한 응답 형식이 될 수 있다.
- 따라서 non-trivial orchestration 작업에 우선 적용하는 기준이 필요하다.
