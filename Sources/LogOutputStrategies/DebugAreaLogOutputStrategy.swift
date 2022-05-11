//
//  Created by Антон Лобанов on 06.06.2021.
//

import Foundation

// MARK: - SystemLogOutputStrategy & ILogOutputStrategy

final class DebugAreaLogOutputStrategy: ILogOutputStrategy {
	func log(_ logType: LogType, message: String, callPoint: String) {
		let separator = String(repeating: "-", count: Environment.Appearance.separatorLength)

		let fullMessage = """
		\(separator)
		\(logType.emoji) \(logType.rawValue). \(callPoint):\n\(message)\n
		"""

		print(fullMessage)
	}
}
