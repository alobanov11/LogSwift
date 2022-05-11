//
//  Created by Антон Лобанов on 06.06.2021.
//

import Foundation
import os.log

// MARK: - SystemLogOutputStrategy & ILogOutputStrategy

final class SystemLogOutputStrategy: ILogOutputStrategy {
	private let maxLenghtMessageInConcole = 900

	func log(_ logType: LogType, message: String, callPoint: String) {
		let fullMessage = "\n\(callPoint) (\(logType.rawValue)):\n\(message)"

		let origin = Bundle.main.bundleIdentifier ?? "-"
		let osLog = OSLog(subsystem: origin, category: "common")

		if self.amIBeingDebugged() {
			os_log("%{public}@", log: osLog, type: logType.osLogType, fullMessage)
		}
		else {
			fullMessage.split(by: self.maxLenghtMessageInConcole).forEach {
				os_log("%{public}@", log: osLog, type: logType.osLogType, $0)
			}
		}
	}
}

private extension SystemLogOutputStrategy {
	// тут определяем подключен xcode как дебагер или нет
	// https://developer.apple.com/library/archive/qa/qa1361/_index.html
	// https://stackoverflow.com/questions/33177182/detect-if-swift-app-is-being-run-from-xcode
	func amIBeingDebugged() -> Bool {
		var info = kinfo_proc()
		var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
		var size = MemoryLayout<kinfo_proc>.stride
		let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
		assert(junk == 0, "sysctl failed")
		return (info.kp_proc.p_flag & P_TRACED) != 0
	}
}

// MARK: - LogType + OSLogType

private extension LogType {
	var osLogType: OSLogType {
		switch self {
		case .verbose:
			return .default
		case .info:
			return .info
		case .debug, .warning:
			return .debug
		case .error:
			return .error
		}
	}
}
