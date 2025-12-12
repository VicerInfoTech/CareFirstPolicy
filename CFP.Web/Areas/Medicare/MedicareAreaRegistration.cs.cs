using Microsoft.AspNetCore.Mvc;

namespace Web.Areas.Medicare
{
    public class MedicareAreaRegistration : AreaAttribute
    {
        public MedicareAreaRegistration() : base("Medicare") { }
    }
}
