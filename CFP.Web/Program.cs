using CFP.Common.Utility;
using CFP.Provider;
using CFP.Web.Hubs;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.HttpOverrides;
using CFP.Web.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews().AddRazorRuntimeCompilation();

builder.Services.AddSignalR(options =>
{
    options.KeepAliveInterval = TimeSpan.FromSeconds(10);
    options.ClientTimeoutInterval = TimeSpan.FromSeconds(20);
    options.HandshakeTimeout = TimeSpan.FromSeconds(5);
});

builder.Services.AddProviderServices(builder.Configuration);

#region Session
builder.Services.AddSession(options =>
{
    options.Cookie.Name = "CFP.Session";
    options.IdleTimeout = TimeSpan.FromHours(9);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

builder.Services.AddCors(options =>
{
    options.AddPolicy("CFPCors", policy =>
    {
        policy
            .WithOrigins(AppCommon.APP_URL)
            .AllowAnyHeader()
            .AllowAnyMethod()
            .AllowCredentials();
    });
});

// Cookie settings for same-origin
// Authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Index";
        options.AccessDeniedPath = "/Unauthorized/Index";
        options.Cookie.Name = "CFPAuth";
        options.Cookie.HttpOnly = true;
        options.Cookie.SameSite = SameSiteMode.None; // REQUIRED for SignalR + cookies
        options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
    });

builder.Services.AddAuthorization();
builder.Services.AddHttpContextAccessor();
builder.Services.AddTransient<ISessionManager, SessionManager>();
// No need to register IHttpContextAccessor again - AddHttpContextAccessor() already does this
#endregion

var app = builder.Build();

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
});

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

// Rate limiter middleware - place early in pipeline
app.Use(async (context, next) =>
{
    if (context.Request.Path.StartsWithSegments("/chathub/negotiate", StringComparison.OrdinalIgnoreCase))
    {
        var limiter = SimpleIpRateLimiter.Instance;
        var remoteIp = context.Connection.RemoteIpAddress?.ToString() ?? "unknown";
        if (!limiter.TryRequest(remoteIp))
        {
            context.Response.StatusCode = StatusCodes.Status429TooManyRequests;
            await context.Response.WriteAsync("Too many requests");
            return;
        }
    }
    await next();
});

app.UseRouting();
app.UseCors("CFPCors");
app.UseSession();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Index}/{id?}"
);

app.MapHub<ChatHub>("/chathub").RequireAuthorization();

app.Run();