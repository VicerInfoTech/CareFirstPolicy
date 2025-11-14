using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

namespace CFP.Web.Controllers
{
    public class ChatController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
