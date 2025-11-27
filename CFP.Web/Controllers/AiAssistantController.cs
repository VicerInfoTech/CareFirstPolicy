using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    public class AiAssistantController : BaseController
    {
        #region Variables
        private readonly IAiAssistantProvider _aiAssistantProvider;
        #endregion

        #region Constructor
        public AiAssistantController(ICommonProvider commonProvider, ISessionManager sessionManager, IAiAssistantProvider aiAssistantProvider) : base(commonProvider, sessionManager)
        {
            _aiAssistantProvider = aiAssistantProvider;
        }
        #endregion
        public IActionResult Index()
        {
            AiAssistantViewModel viewModel = new AiAssistantViewModel();
            return View(viewModel);
        }

        [HttpPost]
        public IActionResult GetChatResponse([FromBody] AiAssistantViewModel request)
        {
            string response = "Hyy , this response come from our ai assistant";
            return Json(new { response });
        }
    }
}
