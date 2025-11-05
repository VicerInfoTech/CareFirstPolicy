using CFP.Common.Utility;
using CFP.Provider;
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddControllersWithViews().AddRazorRuntimeCompilation();


builder.Services.AddProviderServices(builder.Configuration);

#region Session
builder.Services.AddSession(options =>
{
    options.Cookie.Name = AppCommon.SessionName;
    options.IdleTimeout = TimeSpan.FromHours(9);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

builder.Services.AddHttpContextAccessor();
builder.Services.AddTransient<ISessionManager, SessionManager>();
builder.Services.AddTransient<IHttpContextAccessor, HttpContextAccessor>();
#endregion

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();
app.UseSession();
app.MapControllerRoute(
    name: "default",
       pattern: "{controller=Account}/{action=Index}/{id?}");

app.Run();
