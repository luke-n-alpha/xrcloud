# 최종 커밋 및 푸시 계획

이 문서는 모든 서브모듈과 상위 프로젝트의 변경사항을 원격 저장소에 푸시하는 작업의 남은 단계를 기록합니다.

## 작업 상태

- [x] `xrcloud-nginx` 서브모듈 처리 완료
- [ ] `hubs-all-in-one` 서브모듈 처리 (진행중)
- [ ] `xrcloud-backend` 서브모듈 처리
- [ ] `xrcloud-frontend` 서브모듈 처리
- [ ] 상위 프로젝트(`xrcloud`) 처리

## 다음 단계

1.  `hubs-all-in-one` 작업이 완료되면, `xrcloud-backend` 디렉토리로 이동하여 모든 변경사항을 커밋하고 푸시합니다.
    - `cd ../xrcloud-backend && git add . && git commit -m "chore: 저작자 정보 업데이트" && git push`
2.  `xrcloud-backend` 작업이 완료되면, `xrcloud-frontend` 디렉토리로 이동하여 모든 변경사항을 커밋하고 푸시합니다.
    - `cd ../xrcloud-frontend && git add . && git commit -m "chore: 저작자 정보 업데이트" && git push`
3.  모든 서브모듈 작업이 완료되면, 상위 프로젝트(`xrcloud`) 루트 디렉토리로 이동하여 모든 변경사항(Untracked 파일 포함)을 커밋하고 푸시합니다.
    - `cd .. && git add . && git commit -m "feat: Nginx 스토리지 경로 문제 해결 및 전체 프로젝트 저작자 정보 업데이트" && git push`
