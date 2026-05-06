# Current Objective

이 문서는 TAS의 plan 단계 산출물 템플릿이다. 목적은 analysis 결과를 실행 가능한 순서와 검증 조건으로 바꾸고, 후속 수정 시 기존 계획의 흔적을 보존하는 것이다.

## Locked Decisions

- plan 단계는 `prompt.md`와 `research.md`를 먼저 읽은 뒤 시작한다.
- plan 단계에서는 product code를 수정하지 않는다.
- execution 단계가 넓은 재탐색 없이 구현할 수 있을 정도로 구체성을 확보해야 한다.

## Scope and Assumptions

- 현재 request에서 구현할 범위
- analysis 단계에서 확정된 사실
- fallback으로 채택한 가정

## Ordered Steps

1. 구현 또는 문서 변경의 직접 대상 파일을 확정한다.
2. 성공 조건을 만족시키는 절차 체인과 우선 확인할 실패 링크를 정한다.
3. 필요한 수정 순서를 결정한다.
4. 각 수정 후 검증 방법을 정한다.
5. 완료 기준과 롤백 조건을 정한다.

## Event Chain Focus

- 어떤 링크를 정상으로 가정하는지
- 어떤 링크를 현재 실패 지점 후보로 보는지
- 가장 먼저 실행할 검증 하나

## Target Files

- 실제 수정 또는 검토 대상 파일 목록

## Validation Plan

- 실행 후 확인할 테스트, Problems, lint, 수동 검증 항목
- customization 파일인 경우 frontmatter와 Markdown 구조 검사

## Completion Criteria

- execution 단계가 추가 대규모 탐색 없이 구현 가능하다.
- 대상 파일, 변경 순서, 검증 방법이 모두 명시된다.
- 남아 있는 불확실성이 기록된다.

## Rollback Triggers

- 구현 방향이 materially changed 되는 경우 plan 재작성
- analysis 누락 사실이 드러나는 경우 research로 롤백

## Plan Changes

- 계획 수정 시 이전 결정을 삭제하지 말고 변경 이유와 함께 기록한다.

## Change Log

- Initial plan template created.
