# Summary

두 번째 연구 관점에서는 역할 경계, 문서 품질, 연구자 확장 전략이 템플릿 request 기준으로 충돌 없이 작동하는지 점검했다.

## Scope Investigated

- 리더, 리서처, 플래너, 빌더, 리뷰어의 권한 경계
- Markdown 문서 품질 기준
- 리서처 복제 전략과 research2.md 연결 방식

## Codebase Facts

- role-boundaries.instructions.md는 리더의 코드 수정 금지와 빌더의 탐색 제한을 명확히 정의해야 한다.
- markdown-docs.instructions.md는 README, .github 문서, request artifact에 공통으로 적용된다.
- base researcher는 researcher.agent.md 하나로 유지하고, 추가 researcher는 별도 파일로 복제하는 방식이 자연스럽다.

## External or Domain Facts

- VS Code custom agents는 `user-invocable: false`로 두면 서브에이전트 전용으로 운용할 수 있다.
- skill은 절차와 자산을 재사용할 때 적합하고, 권한 경계는 instruction과 agent 본문에 두는 것이 적합하다.

## Constraints for Implementation

- researcher-02.agent.md는 base researcher의 역할을 유지하면서도 `research2.md` 대상이 드러나야 한다.
- request_0000 산출물은 공식 예시이자 템플릿으로 읽힐 수 있어야 한다.
- review.md는 findings 중심 구조를 가져야 한다.

## Risks and Open Questions

- 추가 researcher 파일이 많아지면 agents 목록이 길어질 수 있으므로 리더가 필요 시 정리해야 한다.
- request_0000 예시가 향후 운영 표준으로 굳어질 가능성이 있으므로 과하게 특수한 내용은 피해야 한다.
