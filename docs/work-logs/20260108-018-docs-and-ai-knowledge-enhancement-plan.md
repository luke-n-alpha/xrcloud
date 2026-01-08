# 프로젝트 문서 및 AI 지식 보강 계획

이 문서는 XRCLOUD 프로젝트의 문서 품질을 개선하고 AI 에이전트의 프로젝트 이해도를 높이기 위한 작업 계획을 정의합니다.

## 1단계: Git 동기화 최종 확인

- 현재 진행 중인 `git push` 작업의 성공적인 완료를 확인합니다.
- `git status --untracked-files=no` 명령을 실행하여 모든 변경사항이 원격 저장소에 반영되었는지 최종 검증합니다.

## 2단계: 프로젝트 문서 검토 및 개선

- **대상 문서:**
  - `README.md`
  - `README_ko.md`
  - `docs/installation_guide_en.md`
  - `docs/installation_guide_ko.md`
  - 각 서브모듈 (`xrcloud-backend`, `xrcloud-frontend`, `xrcloud-nginx`, `hubs-all-in-one`)의 `README.md` 및 `README_ko.md`
- **검토 항목:**
  - 내용의 최신성 및 정확성
  - 명확성과 가독성
  - 깨진 링크나 이미지 확인
  - 프로젝트 구조 및 아키텍처 설명 보강
- **실행 계획:**
  1. 각 문서를 순서대로 읽고 분석합니다.
  2. 개선이 필요한 부분을 식별하고 수정안을 제안합니다.
  3. 마스터의 승인을 받은 후, `replace_in_file` 또는 `write_to_file`을 사용하여 문서를 업데이트합니다.

## 3단계: AI 지식(`.agents`) 보강

- **목표:** AI 에이전트(알파)가 프로젝트의 구조, 규칙, 작업 흐름을 더 잘 이해하고 효율적으로 작업을 수행할 수 있도록 컨텍스트를 강화합니다.
- **대상 파일:**
  - `AGENTS.md`
  - `.agents/context/caret-rules.json`
  - `.agents/context/caret-rules.md`
  - `.agents/context/ai-work-index.yaml`
- **실행 계획:**
  1. **`AGENTS.md` 업데이트:** 프로젝트의 고수준 아키텍처와 각 서브모듈의 역할을 요약하여 추가합니다.
  2. **`caret-rules.json` 채우기:** 프로젝트 이름(`XRCLOUD`), 철학, 보호 디렉토리 규칙 등을 정의합니다.
  3. **`ai-work-index.yaml` 구성:** "문서 작업", "Git 관리", "인증서 관리" 등 일반적인 작업 카테고리를 정의하고 관련 워크플로우 문서(필요시 생성)를 연결합니다.
  4. 마스터의 승인을 받은 후, 파일을 생성하고 업데이트합니다.

이 계획에 따라 순서대로 작업을 진행하겠습니다.
