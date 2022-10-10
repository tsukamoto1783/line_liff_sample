async function init(liffId){
    await liff.init({
        liffId: liffId, // Use own liffId
//        以下を有効にすれば、liff.login()メソッドが自動で実行されます。
        withLoginOnExternalBrowser: true, // Enable automatic login process
    })
        .then(() => {
            console.log('liff.init() success')
        })
        .catch((err) => {
            console.log(err)
        });
}

async function getProfile(){
    const profile = await liff.getProfile()
    console.log('liff.getProfile() success')
    console.log('profile typeof:'+typeof profile)
    console.log('profile["displayName"] typeof:'+typeof profile["displayName"])
    const list = [profile["userId"],profile["displayName"],profile["pictureUrl"]]
    console.log('list typeof: '+typeof list)
    return list
}