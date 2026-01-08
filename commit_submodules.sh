#!/bin/bash
# 이 스크립트는 변경된 모든 서브모듈의 변경사항을 자동으로 커밋합니다.
set -e # 오류 발생 시 즉시 중단
set -x # 실행되는 명령어 출력

# 특정 디렉토리에서 변경사항을 커밋하는 함수
commit_in_dir() {
    echo "--- Processing submodule: $1 ---"
    (
        cd "$1"
        git add .
        # 커밋할 내용이 없으면 오류가 발생할 수 있으므로, `|| true`를 추가하여 스크립트가 중단되지 않도록 합니다.
        git commit -m "chore: Sync all uncommitted local changes" || true
    )
}

# 로그 파일 분석을 통해 변경이 확인된 서브모듈 목록
commit_in_dir "hubs-all-in-one"
commit_in_dir "hubs-all-in-one/reticulum"
commit_in_dir "hubs-all-in-one/spoke"
commit_in_dir "xrcloud-backend"
commit_in_dir "xrcloud-frontend"
commit_in_dir "xrcloud-nginx"

echo "--- Submodule commit process finished successfully. ---"
