using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Provider.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
         

            CreateMap<UserMasterModel, UserMaster>();
            CreateMap<UserMaster, UserMasterModel>();

            CreateMap<MenuModel, Menu>();
            CreateMap<Menu, MenuModel>();


        }
    }
}
