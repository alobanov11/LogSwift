//
//  Created by Антон Лобанов on 06.06.2021.
//

import Foundation

public final class Logger {
	private var outputStrategies: [LogWriter] = []

	private static let shared = Logger()

	public class func addDestination(
		_ outputDestination: LogOutputDestination,
		allowedLogTypes: [LogType] = LogType.allCases
	) {
		let outputStrategiesFactory: ILogOutputStrategiesFactory = LogOutputStrategiesFactory()
		let strategy = outputStrategiesFactory.strategy(for: outputDestination)
		let types = Set(allowedLogTypes)
		let writer = LogWriter(strategy: strategy, allowedLogTypes: types)
		Logger.shared.outputStrategies.append(writer)
	}
}

extension Logger: ILogger {
	public static func verbose(
		_ message: String,
		_ file: StaticString = #file,
		_ function: StaticString = #function,
		_ line: UInt = #line
	) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.shared.outputStrategies.forEach { $0.log(.verbose, message: message, callPoint: callPoint) }
	}

	public static func info(
		_ message: String,
		_ file: StaticString = #file,
		_ function: StaticString = #function,
		_ line: UInt = #line
	) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.shared.outputStrategies.forEach { $0.log(.info, message: message, callPoint: callPoint) }
	}

	public static func debug(
		_ message: String,
		_ file: StaticString = #file,
		_ function: StaticString = #function,
		_ line: UInt = #line
	) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.shared.outputStrategies.forEach { $0.log(.debug, message: message, callPoint: callPoint) }
	}

	public static func warning(
		_ message: String,
		_ file: StaticString = #file,
		_ function: StaticString = #function,
		_ line: UInt = #line
	) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.shared.outputStrategies.forEach { $0.log(.warning, message: message, callPoint: callPoint) }
	}

	public static func error(
		_ message: String,
		_ file: StaticString = #file,
		_ function: StaticString = #function,
		_ line: UInt = #line
	) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.shared.outputStrategies.forEach { $0.log(.error, message: message, callPoint: callPoint) }
	}
}

private extension Logger {
	static func callPoint(file: StaticString, function: StaticString, line: UInt) -> String {
		let fileNameWithExtension = URL(fileURLWithPath: "\(file)").lastPathComponent
		return "\(fileNameWithExtension): \(function). line:\(line)"
	}
}

private extension Logger {
	final class LogWriter {
		let strategy: ILogOutputStrategy
		let allowedLogTypes: Set<LogType>

		init(strategy: ILogOutputStrategy, allowedLogTypes: Set<LogType>) {
			self.strategy = strategy
			self.allowedLogTypes = allowedLogTypes
		}

		func log(
			_ logType: LogType,
			message: String,
			callPoint: String
		) {
			guard self.allowedLogTypes.contains(logType) else { return }
			self.strategy.log(logType, message: message, callPoint: callPoint)
		}
	}
}
