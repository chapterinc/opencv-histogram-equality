import Flutter
import UIKit

enum FlutterError: Error {
    case runtimeError(String)
}

public class SwiftOpencvHistogramEqualityPlugin: NSObject, FlutterPlugin {
    static let noArgumentsWasPassesError = "no arguments was passed"
    static let wasNotAbleParsImage = "was not able parse image"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "opencv_histogram_equality", binaryMessenger: registrar.messenger())
    let instance = SwiftOpencvHistogramEqualityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    do {
        try next(call, result: result)
    }catch {
        result(["error": "\(error)"])
    }
  }
    
    func next(_ call: FlutterMethodCall, result: @escaping FlutterResult) throws{
      guard let dictionary = call.arguments as? NSDictionary else{
          throw FlutterError.runtimeError(SwiftOpencvHistogramEqualityPlugin.noArgumentsWasPassesError)
      }
      
      guard let first = dictionary["first"] as? FlutterStandardTypedData, let second = dictionary["second"] as? FlutterStandardTypedData else{
          throw FlutterError.runtimeError(SwiftOpencvHistogramEqualityPlugin.noArgumentsWasPassesError)
      }
      
      if let firstImage = UIImage(data:first.data,scale:1.0), let secondImage = UIImage(data:second.data,scale:1.0){
        let similarity = HistogramWrapper.similarity(firstImage, source: secondImage)
            
        result( ["results": ["similarity": similarity]] )
      }else{
        throw FlutterError.runtimeError(SwiftOpencvHistogramEqualityPlugin.wasNotAbleParsImage)
      }
    }
}
