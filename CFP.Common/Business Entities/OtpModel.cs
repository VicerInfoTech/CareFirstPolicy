using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CFP.Common.Business_Entities
{
    public class OtpModel
    {
        public long OtpId { get; set; }
        [Required(ErrorMessage = "Please specify OTP")]
        [MaxLength(6, ErrorMessage = "OTP should be 6 digits")]
        [MinLength(6, ErrorMessage = "OTP should be 6 digits")]
        [DisplayName("OTP Value")]
        public string OtpValue { get; set; }
        public int UserMasterId { get; set; }
        public bool IsExpire { get; set; }
        public DateTime CreatedOn { get; set; }
        public string Ip { get; set; }

        public string EncUserMasterId { get; set; }
    }
}
