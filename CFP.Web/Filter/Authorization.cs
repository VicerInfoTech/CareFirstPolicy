using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Filter
{
    public class Authorization : Attribute, IAuthorizationFilter
    {

        public int MenuId { get; set; } = 0;
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var sessionManager = (ISessionManager)context.HttpContext.RequestServices.GetService(typeof(ISessionManager));
            var commonProvider = (ICommonProvider)context.HttpContext.RequestServices.GetService(typeof(ICommonProvider));

            if (commonProvider == null || sessionManager == null)
            {
                context.Result = new RedirectToRouteResult(
                 new RouteValueDictionary { { "controller", "Account" }, { "action", "Index" } });
                return;
            }

            bool isUnauthorized = false;
            int userId = sessionManager.UserId;
            int roleId = sessionManager.RoleId;
            if (userId == 0 || roleId == 0)
            {
                if (IsAjaxRequest(context.HttpContext.Request))
                    context.Result = new ForbidResult();
                else
                {
                    context.Result = new RedirectToRouteResult(
                    new RouteValueDictionary { { "controller", "Account" }, { "action", "Index" } });
                    return;
                }

            }
            if (roleId > 0)
                isUnauthorized = !commonProvider.IsAuthorized(roleId, MenuId);
            else
                isUnauthorized = true;

            if (isUnauthorized)
            {
                if (IsAjaxRequest(context.HttpContext.Request))
                    context.Result = new UnauthorizedResult();
                else
                {
                    context.Result = new RedirectToRouteResult(new RouteValueDictionary { { "controller", "Unauthorized" }, { "action", "Index" } });
                    return;
                }
            }

        }

        public static bool IsAjaxRequest(Microsoft.AspNetCore.Http.HttpRequest request)
        {
            if (request.Headers != null)
                return request.Headers["X-Requested-With"] == "XMLHttpRequest";
            else
                return false;
        }
    }
}
