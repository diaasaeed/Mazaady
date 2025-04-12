//
//  moyaProvider.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Foundation
import Moya


let moyaProvider = NetworkClient(transport: MoyaProvider<MoyaAPI>(plugins: [NetworkLoggerPlugin()]))

//let moyaProvider = NetworkClient(transport: MoyaProvider<MoyaAPI>(
//    session: AlamofireSessionManagerBuilder().build(),
//    plugins: [NetworkLoggerPlugin()])
//)




//class AlamofireSessionManagerBuilder {
//    
//    var policies: [String: ServerTrustEvaluating]?
//    var configuration = URLSessionConfiguration.default
//    
//    
//    init(includeSSLPinning: Bool = true) {
//        if includeSSLPinning {
//            //if certificate is not self signed use PublicKeysTrustEvaluator
//            var certificate1 : Data = {
//                let url = Bundle.main.url(forResource: "Real_Estate_Registration_Test_CA", withExtension: "cer")!
//                let data = try! Data(contentsOf: url)
//                print(data)
//                return data
//            }()
//            let stringNS1 = NSData(data: certificate1)
//            let cert1 = SecCertificateCreateWithData(nil, stringNS1)!
//
//
//            let allPublicKeys = PinnedCertificatesTrustEvaluator(
//                certificates: [cert1],
//                acceptSelfSignedCertificates: true,
//                performDefaultValidation: true,
//                validateHost: false
//            )
////            #if QA
//            self.policies = [
////                "test-elm-portal-dev.rer.sa": DisabledTrustEvaluator(),
//                "test-elm-portal-dev.rer.sa": allPublicKeys,
//            ]
////            #elseif DEVELOPMENT
////            self.policies =
////            [
////                "10.33.20.163": DisabledTrustEvaluator(),
////            ]
////            #endif
//        }
//    }
//    
//    func build() -> Session {
//        var serverTrustPolicyManager: ServerTrustManager?
//        if let policies = self.policies {
//            serverTrustPolicyManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: policies)
//        }
//        let session = Session(serverTrustManager: serverTrustPolicyManager)
//        return session
//    }
//}
