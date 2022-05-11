//
//  Created by Антон Лобанов on 06.06.2021.
//

enum Environment {
	enum Appearance {
		/// [DATE] [ORIGIN_SYSTEM] LOG_MESSAGE
		static let defaultLogFormat = "[%@] [%@] %@"

		/// Длина разделителя, который добавляется в лог-файл, после каждой сессии записи.
		static let separatorLength = 96
	}
}
