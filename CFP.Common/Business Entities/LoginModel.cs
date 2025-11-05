using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Text;
using System.Xml.Linq;

namespace CFP.Common.Business_Entities
{
    public class LoginModel
    { 
        [Required(ErrorMessage ="Please specify email")]
        [DisplayName("Email ")]
        public string UserName { get; set; }
        [Required(ErrorMessage = "Please specify password")]
        [DisplayName("Password")]
        public string UserPassword { get; set; }

    }
    public class ForgotPasswordModel
    {
        [Required(ErrorMessage = "Please specify email address")]
        [Display(Name = "Email")]
        public string Username { get; set; }

    }
    public class ResetPasswordModel
    {
        public int UserMasterId { get; set; }
        public string EncId { get; set; }
        public string Username { get; set; }
        
        
        [Display(Name = "Old Password")]
        [Required(ErrorMessage = "Please specify old password")]
        public string OldPassword{ get; set; }
        
        [Display(Name = "Password")]
        [Required(ErrorMessage = "Please specify password")]
        [MinLength(8,ErrorMessage ="Password must be 8 character long")]
        public string Password { get; set; }

        [Display(Name = "Confirm Password")]
        [Required(ErrorMessage = "Please specify confirm password")]
        [MinLength(8,ErrorMessage ="Password must be 8 character long")]
        [System.ComponentModel.DataAnnotations.Compare("Password", ErrorMessage = "Confirm password does not match with password.")]
        public string ConfirmPassword { get; set; }
         
    }
}
