# Summary

공식 템플릿 request의 목표는 Beast Mode의 실행 성향을 유지하면서 오케스트레이션 가능한 에이전트 팀 구조를 워크스페이스 커스터마이징으로 구축하는 것이다.

## Scope Investigated

- 현재 저장소의 루트 구조
- 기존 Beast Mode 에이전트 파일
- README에 정의된 협업 워크플로우
- VS Code custom agents, instructions, skills 구성 방식

## Codebase Facts

- 현재 저장소는 커스터마이징 저장소 역할에 가깝고 애플리케이션 소스는 없다.
- .github/agents 안에는 beastmode.agent.md가 존재하고, 나머지 오케스트레이션 에이전트는 새로 설계해야 했다.
- README는 연구, 계획, 실행 중심 구조를 설명하고 있었고 이후 리뷰 단계를 추가하는 방향으로 확장되었다.
- docs/agent_docs/request_0000는 공식 템플릿과 예시 패키지 역할을 한다.

## External or Domain Facts

- VS Code custom agent는 .github/agents 아래 .agent.md 파일로 정의한다.
- instructions는 .github/instructions 아래 .instructions.md로 관리한다.
- skills는 .github/skills/skill-name/SKILL.md 구조를 따른다.
- agent의 description은 자동 발견과 서브에이전트 위임 품질에 직접 영향을 준다.

## Constraints for Implementation

- beastmode.agent.md는 비상용으로 유지해야 한다.
- 리더는 edit 권한을 가지되 애플리케이션 코드를 수정하면 안 된다.
- 이 request는 활성 작업이 아니라 템플릿이므로 실제 후속 작업은 request_0001 이상에서 진행해야 한다.
- 템플릿 문서는 이후 active request의 참조 기준이 될 수 있어야 한다.

## Risks and Open Questions

- 템플릿이 너무 특수하면 실제 운영과 어긋날 수 있다.
- 리서처 수를 늘릴 때 description과 산출물 대상이 겹치면 역할 분리가 흐려질 수 있다.
- docs/agent_docs/request_0000를 공식 예시로 남기면 이후 요청 numbering 규칙과 템플릿 인식이 쉬워진다.
