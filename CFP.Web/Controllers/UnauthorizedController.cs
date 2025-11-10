using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    public class UnauthorizedController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
