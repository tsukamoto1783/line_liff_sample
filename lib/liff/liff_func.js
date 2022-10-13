// 引数のLiffIdを基に初期化処理
async function liffInit(liffId){
    await liff.init({
        liffId: liffId,
        // 以下のプロパティをtrueで自動ログイン処理が有効に
        withLoginOnExternalBrowser: true,
    })
}

// profile情報を取得し、Listにして返却
async function liffGetProfile(){
    const profile = await liff.getProfile()
    const profileList = [profile["userId"], profile["displayName"], profile["pictureUrl"]]
    return profileList
}