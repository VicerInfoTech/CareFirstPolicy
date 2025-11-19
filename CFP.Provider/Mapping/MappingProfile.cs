using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Repository.Models;

namespace CFP.Provider.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {       

           CreateMap<AgentMaster, AgentMasterModel>();
           CreateMap<AgentMasterModel, AgentMaster>();

            CreateMap<UserMasterModel, UserMaster>();
            CreateMap<UserMaster, UserMasterModel>();

            CreateMap<MenuModel, Menu>();
            CreateMap<Menu, MenuModel>();

            CreateMap<DealModel, Deal>();
            CreateMap<Deal, DealModel>();

            CreateMap<ChatMessageModel, ChatMessage>();
            CreateMap<ChatMessage, ChatMessageModel>();

            CreateMap<ChatRoomModel, ChatRoom>();
            CreateMap<ChatRoom, ChatRoomModel>();

            CreateMap<DealDocModel, DealDocument>();
            CreateMap<DealDocument, DealDocModel>();


        }
    }
}
