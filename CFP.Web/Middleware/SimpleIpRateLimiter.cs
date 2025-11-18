namespace CFP.Web.Middleware
{
    public class SimpleIpRateLimiter
    {
        private static readonly Lazy<SimpleIpRateLimiter> _lazy = new(() => new SimpleIpRateLimiter());
        public static SimpleIpRateLimiter Instance => _lazy.Value;

        private readonly System.Collections.Concurrent.ConcurrentDictionary<string, (int Count, DateTime WindowStart)> _counters
            = new();

        private readonly int _limit = 10;
        private readonly TimeSpan _window = TimeSpan.FromSeconds(10);

        private SimpleIpRateLimiter() { }

        public bool TryRequest(string ip)
        {
            var now = DateTime.UtcNow;

            _counters.AddOrUpdate(ip,
                addValueFactory: _ => (1, now),
                updateValueFactory: (_, tuple) =>
                {
                    var (count, start) = tuple;
                    if (now - start > _window)
                        return (1, now);  // reset window

                    return (count + 1, start);
                });

            var current = _counters[ip];
            return current.Count <= _limit;
        }
    }
}
