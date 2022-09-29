async function init(liff_if){
    liff.init({
        liffId: liff_if, // Use own liffId
//        以下を有効にすれば、liff.login()メソッドが自動で実行されます。
//        withLoginOnExternalBrowser: true, // Enable automatic login process
    })
        .then(() => {
            const idToken = liff.getDecodedIDToken();
            console.log("idToken:"); // print decoded idToken object
            console.log(idToken); // print decoded idToken object
            console.log("liff.id:"); // print decoded idToken object
            console.log(liff.id); // print decoded idToken object
            return idToken;
        })
        .catch((err) => {
            console.log(err);
            return null
        });
}

async function getProfile(){
    liff
      .getProfile()
      .then((profile) => {
        const name = profile.displayName;
        console.log("name:");
        console.log(name);
        return name;
      })
      .catch((err) => {
        console.log("getProfile error", err);

      });
}