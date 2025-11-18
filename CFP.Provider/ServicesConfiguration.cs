using AutoMapper;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Provider.Mapping;
using CFP.Provider.Provider;
using CFP.Repository;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CFP.Provider
{
    public static class ServicesConfiguration
    {
        public static void AddProviderServices(this IServiceCollection services, IConfiguration configuration)
        {
            var mappingConfig = new MapperConfiguration(mc =>
            {
                mc.AddProfile(new MappingProfile());
            });

            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
            services.AddRepositoryService(configuration);
            services.AddTransient<ICommonProvider, CommonProvider>();
            services.AddTransient<IUserMasterProvider, UserMasterProvider>();
            services.AddTransient<IAgentMasterProvider, AgentMasterProvider>();
            services.AddTransient<IDealProvider, DealProvider>();
            services.AddTransient<IChatProvider, ChatProvider>();

            AppCommon.APP_URL = configuration.GetSection("AppCommonSettings:APP_URL").Value;

        }

    }
}
