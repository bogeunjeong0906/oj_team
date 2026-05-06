# Current Summary

이 문서는 TAS의 analysis 단계 산출물 템플릿이다. 핵심 목적은 구현 경계를 정리하고, 후속 연구가 들어와도 기존 findings가 소실되지 않도록 누적 기록을 유지하는 것이다.

## Stable Findings

- TAS는 비단순 작업에서 request artifact를 사용한다.
- active work는 `request_0001` 이상에서 수행한다.
- analysis 단계는 필요한 정보만 조사하고 product code는 수정하지 않는다.
- 후속 연구는 기존 내용을 지우지 않고 같은 문서에 누적 갱신한다.

## Scope Investigated

- 사용자 요청의 목표와 범위
- 관련 customization 파일과 문서 구조
- 구현 또는 수정에 필요한 로컬 코드베이스 사실
- 필요 시 외부 문서나 레퍼런스

## Target Success Condition

- 이번 request가 성공으로 간주되는 최종 조건

## Event Chain or Procedural Sequence

- 성공을 위해 필요한 최소 절차 체인
- 각 링크의 입력, 출력, 또는 관측 가능 신호

## Current Failure Signal

- 현재 보이는 실패, 이상 징후, 또는 미충족 조건
- 어디까지는 정상으로 확인되었는지

## Active Hypothesis and Cheapest Check

- 현재 가장 유력한 로컬 가설 하나
- 그 가설을 가장 싸게 반증할 수 있는 다음 확인 방법 하나

## Validation Targets

- 이후 plan이나 execution에서 어떤 링크를 검증해야 하는지
- mock, fixture, trace, 직접 실행 중 어떤 방식이 적절한지

## Replacement and Cleanup Risks

- 이번 변경으로 obsolete path가 생길 가능성이 있는지
- 정리해야 할 후보 경로가 무엇인지

## Codebase Facts

- 관련 파일과 경로
- 현재 동작 또는 현재 규칙
- 이미 존재하는 제약사항

## External or Domain Facts

- 외부 문서에서 확인한 사실
- 라이브러리, 프레임워크, 도구 관련 최신 정보

## Constraints for Implementation

- plan 단계가 지켜야 할 구현 경계
- execution 단계가 지켜야 할 검증 조건
- 사용자 요구, 저장소 정책, 호환성 요구사항

## Open Questions

- 아직 남아 있는 불확실성
- 필요 시 사용자 확인이 필요한 지점
- fallback으로 처리 가능한 항목
- 현재 사용할 수 없는 환경 또는 외부 의존성

## Analysis Completion Gate

- 트러블슈팅 작업이라면 success condition, event chain, current failure signal, active hypothesis, cheapest check가 모두 구체적으로 기록되어야 한다.
- 위 항목이 비어 있거나 추상적이면 plan 단계로 넘어가지 않는다.

## Follow-up Research

- 추가 조사 요청이 들어오면 기존 findings를 보존한 채 이 섹션이나 관련 섹션을 확장한다.
- 특정 항목만 재조사하더라도 이전 항목의 기록은 유지한다.

## Change Log

- Initial analysis template created.
