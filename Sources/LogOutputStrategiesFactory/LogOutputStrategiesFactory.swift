//
//  Created by Антон Лобанов on 06.06.2021.
//

final class LogOutputStrategiesFactory: ILogOutputStrategiesFactory {
	func strategy(for destination: LogOutputDestination) -> ILogOutputStrategy {
		switch destination {
		case .debugArea:
			return DebugAreaLogOutputStrategy()
		case .systemConsole:
			return SystemLogOutputStrategy()
		case let .file(logFilePath):
			return FileLogOutputStrategy(logFilePath: logFilePath)
		}
	}
}
