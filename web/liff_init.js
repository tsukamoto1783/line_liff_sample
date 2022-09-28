async function init(liff_if){
    liff.init({
        liffId: liff_if, // Use own liffId
//        以下を有効にすれば、liff.login()メソッドが自動で実行されます。
//        withLoginOnExternalBrowser: true, // Enable automatic login process
    })
        .then(() => {
            const idToken = liff.getDecodedIDToken();
            console.log(idToken); // print decoded idToken object
            return idToken;
        })
        .catch((err) => {
            console.log(err);
            return null
        });
}
