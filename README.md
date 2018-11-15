# # 청출어람

블록체인 기반의 온/오프라인 귀농교육 애플리케이션

## # Languages, libraries and tools used

* Development Environment
	* Xcode 10
	* Swift

* Web3 Pods
	* [web3swift](https://github.com/BANKEX/web3swift)
	* [BigInt](https://github.com/attaswift/BigInt)

* Network Pods
	* [Alamofire](https://github.com/Alamofire/Alamofire)
	* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
	* [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
	* [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper)

* UI Pods
	* [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
	* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
	* [lottie-ios](https://github.com/airbnb/lottie-ios)

## # 아키텍처

MVC (Model-View-Controller) 패턴을 사용합니다.


## # Caver Singleton

web3 인스턴스가 뷰마다 재사용되어 유지보수와 효율측면에서 비효율적이라 생각되어 Singleton 패턴을 사용했습니다.

* Instance 생성전에 CaverSingleton.setUserAddress(userAddress)로 userAddress Setup
* private init()을 사용해 thread-safe한 Singleton임을 보장.
* keystoreMangaerInDevice()를 이용해 App Sandbox내에 생성된 Keystore 폴더를 호출하여 caver에 추가할 수 있도록 함.

```
import web3swift

final class CaverSingleton {
    
    static let sharedInstance: CaverSingleton = CaverSingleton()
    
    private init(){
        Web3.default = .init(provider: Web3HttpProvider.init(URL(string: "http://192.168.0.33:8551")!)!)
        guard let setupUserAddress = CaverSingleton.user.address else {
            fatalError("Error - you must call setup before accessing CaverSingleton.sharedInstance")
        }
        userAddress = setupUserAddress
    }
    
    private class User {
        var address: Address?
    }
    
    private static let user = User()
    
    class func setUserAddress(_ userAddress: Address){
        CaverSingleton.user.address = userAddress
    }
    
    let caver: Web3 = Web3(url: URL(string: "http://192.168.0.33:8551")!)!
    let contractAddress = Address("0x96a277b958988d9b4207dda53067fbd787b0e2db")
    let userAddress: Address
    
    func keystoreMangaerInDevice() -> KeystoreManager?{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore"
        let keystoreManager =  KeystoreManager.managerForPath(path)
        return keystoreManager
    }
}
```

## # Unit Test

### calculateEvaluationAveragePoint(uint256)

Smart Contract의 calculateEvaluationAveragePoint를 호출하는 Unit Test 입니다.
iOS GCD 클래스의 Global Queue를 이용해 호출하므로 UI를 처리하는 Main Thread에서 호출되지 않도록 했습니다.
Klaytn에서 메소드를 Call하는것 자체가 모바일 환경에서는 큰 액션이라고 판단되어 QOS를 Utility로 설정하여 호출하였습니다.



```
    func testCalculateEvaluationAveragePoint() {
        var value: Int?
        let lectureNumber: Int = 0
        DispatchQueue.global(qos: .utility).async {
            do {
                let contractAddress = CaverSingleton.sharedInstance.contractAddress
                value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber).wait().intCount()
                print(value!)
            } catch{
                print("Get Function Result Fail!")
                print(error.localizedDescription)
            }
        }
    }

    // Test Case '-[ChungChul_iOSTests.ChungChul_iOSTests testCalculateEvaluationAveragePoint]' passed (0.005 seconds).
```

### GetKlayBalances


```
    func testGetKlayBalances(){
        let caver = CaverSingleton.sharedInstance.caver
        let userAddress = CaverSingleton.sharedInstance.userAddress
        let keystore = CaverSingleton.sharedInstance.keystoreMangaerInDevice()
        var userKlay: BigUInt = 0
        var privateKey: Data?
        DispatchQueue.global(qos: .utility).async {
            do{
                userKlay = try caver.eth.getBalance(address: userAddress)
                privateKey = try keystore?.UNSAFE_getPrivateKeyData(password: "비밀번호", account: userAddress)
                print(userKlay)
                print(privateKey?.toHexString())
            }catch{
                print("Get Klay Balance Fail")
            }
        }
    }

    // Test Case '-[ChungChul_iOSTests.ChungChul_iOSTests testGetKlayBalances]' passed (0.224 seconds).
```

###

