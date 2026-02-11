import Foundation

actor ScheduleWorker: Sendable {
  private let task: Task<Void, Error>

  init(date: Date?, action: @escaping @Sendable () async throws -> Date?) {
    task = Task {
      var _date: Date? = date
      while let d = _date {
        let interval = max(0, d.timeIntervalSinceNow)
        try await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
        _date = try await action()
      }
    }
  }

  func cancel() {
    task.cancel()
  }
}
