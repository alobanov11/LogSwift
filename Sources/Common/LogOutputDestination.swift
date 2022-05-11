//
//  Created by Антон Лобанов on 06.06.2021.
//

import Foundation

public enum LogOutputDestination {
	/// Вывод логов в окно среды разработки.
	case debugArea

	/// Вывод в системные логи (os_log).
	/// - Note: При выводе в системные логи, сообщение дублируется в Debug-консоль IDE,
	/// если OS_ACTIVITY_MODE выставлен в debug.
	case systemConsole

	/// Запись логов в указанный файл по пути.
	case file(logFilePath: URL)
}
