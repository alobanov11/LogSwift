//
//  Created by Антон Лобанов on 06.06.2021.
//

public enum LogType: String, CaseIterable {
	case verbose
	case info
	case debug
	case warning
	case error

	var emoji: String {
		switch self {
		case .verbose:
			return "📗"
		case .info:
			return "📔"
		case .debug:
			return "📘"
		case .warning:
			return "📙"
		case .error:
			return "📕"
		}
	}
}
