using CFP.Common.Utility;
using CFP.Repository.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CFP.Repository
{
    public static class ServicesConfiguration
    {
        public static void AddRepositoryService(this IServiceCollection services, IConfiguration configuration)
        {
            AppCommon.ConnectionString = configuration.GetConnectionString("DefaultConnection");
            services.AddDbContext<EndeavorCRMContext>(options => options.UseSqlServer(AppCommon.ConnectionString).UseLazyLoadingProxies());
        }
    }
}
