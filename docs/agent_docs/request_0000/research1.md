# Summary

공식 템플릿 request의 핵심 목표는 Beast Mode와 내부 Leader 팀을 분리된 운영 계층으로 유지하는 것이다. Beast Mode는 단독 에이전트이므로 활성 request를 만들지 않고, request artifact는 내부 팀 워크플로우의 전용 구조로 남겨야 한다. 내부 팀에서는 Researcher가 연구 payload를 먼저 계산하고 Leader가 그 추천을 승인하는 구조가 더 일관적이다.

## Scope Investigated

- Beast Mode의 현재 운영 규칙
- 내부 오케스트레이션 에이전트 구조
- docs/agent_docs 템플릿의 휴대성 요구사항
- VS Code customization 구조와 공식 문서 방향

## Codebase Facts

- 현재 저장소는 customization 저장소이며 애플리케이션 런타임 코드는 없다.
- Beast Mode와 내부 오케스트레이션 에이전트가 같은 저장소 안에 공존한다.
- docs/agent_docs/request_0000는 공식 템플릿이며 저장소 기본 상태를 설명해야 한다.
- 다른 프로젝트에 이식할 때 활성 request 폴더가 남아 있으면 혼란을 만들 수 있다.

## External or Domain Facts

- VS Code 공식 문서는 custom agents, prompts, skills, instructions를 분리된 customization 타입으로 다룬다.
- Copilot customization은 역할별 agent specialization과 reusable skill 조합을 권장한다.
- conda 공식 문서는 path prefix 환경도 `conda activate <path>`로 활성화할 수 있다고 설명한다.

## Constraints for Implementation

- Beast Mode는 내부 request 생성 규칙의 예외여야 한다.
- 내부 팀 request 구조는 여전히 유지되어야 한다.
- 템플릿은 이식 가능한 기본 상태를 설명해야 한다.
- 리더는 직접 연구하지 않고 Researcher가 연구 단계를 소유해야 한다.
- supporting researcher 활성화는 Researcher 추천과 Leader 승인으로 분리되는 편이 역할상 자연스럽다.

## Risks and Open Questions

- Beast Mode 예외가 README와 instructions에 동시에 반영되지 않으면 운영 모순이 생길 수 있다.
- supporting researcher 구조를 도입하면 request 템플릿도 research3.md까지 설명해야 한다.
- env-like 폴더 이름만으로 conda를 단정하면 오탐이 생길 수 있으므로 native activation fallback 규칙이 필요하다.
