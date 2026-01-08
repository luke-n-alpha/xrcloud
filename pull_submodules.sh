#!/bin/bash
# 이 스크립트는 non-fast-forward 오류 해결을 위해 각 서브모듈에서 'git pull'을 실행합니다.
# 충돌 상태를 초기화하고, 알려진 충돌은 자동으로 해결하며, 병합 커밋 메시지 편집기를 띄우지 않습니다.
set -e # 오류 발생 시 즉시 중단
set -x # 실행되는 명령어 출력

pull_in_dir() {
    echo "--- Processing submodule: $1 ---"
    (
        cd "$1"

        # 1. 이전 실행에서 남은 충돌 상태를 초기화합니다.
        echo "--- Aborting any pending merge ---"
        git merge --abort || true

        # 2. --no-edit 옵션을 추가하여 편집기가 뜨는 것을 방지하고, merge 전략을 사용합니다.
        echo "--- Pulling remote changes ---"
        # 충돌이 발생해도 스크립트가 중단되지 않도록 '|| true'를 추가합니다.
        git pull --no-rebase --no-edit || true

        # 3. 'proxy/error.log'에서 modify/delete 충돌(UD)이 발생했는지 확인하고 해결합니다.
        if git status --porcelain | grep -q "UD proxy/error.log"; then
            echo "--- Resolving known conflict for proxy/error.log in $1 ---"
            # 로컬의 변경사항(삭제)을 선택하여 충돌을 해결합니다.
            git rm proxy/error.log
            echo "--- Committing merge resolution ---"
            # --no-edit으로 편집기 없이 병합 커밋을 완료합니다.
            git commit --no-edit
        fi
    )
}

# 푸시 실패가 발생한 서브모듈 목록
pull_in_dir "hubs-all-in-one"
pull_in_dir "xrcloud-backend"
pull_in_dir "xrcloud-frontend"
pull_in_dir "xrcloud-nginx"

echo "--- Submodule pull process finished successfully. ---"
