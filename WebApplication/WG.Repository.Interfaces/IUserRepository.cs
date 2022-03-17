using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using WebApplication.Model;
using WG.Model;

namespace WG.Repository.Interfaces
{
    public interface IUserRepository
    {
        Task<bool> LoginUser(string UserName, string Password);
        Task<bool> CheckEmail(string Email);
        Task<bool> CheckUserName(string UserName);
        Task<UserModel> CheckEmailSQL(string Email);
        Task<bool> CheckKeyValidateUser(string UserName, string keyValidate);
        Task<bool> resetPassword(string KeyValidate, string Password, string UserName);
        Task<UserModel> register(UserModelView data);
        Task SendMailAuto(string Email);
        Task resetKeyValidate(string UserName, string Email);
        Task<UserModel> GetUserinfo(string UserName, string Password);
        Task<List<IdeaComments>> insertIdeasComment(IdeaComments model);
        Task<string> insertIdeas(Ideas model);
        Task<string> getIID();
        Task<string> QA_Brose(Ideas model);
        Task<string> DeleteIdeas(Ideas model);
        Task<string> InsertLikeorDisLike(Ideas model);
        Task<IdeaViewModel> GetIdeasbyID(string ID);
        Task<List<Ideas>> GetDSAll(string option);
        Task<statistical> statistical();
        Task<string> InsertView(string IDD, int viewer);
        Task<List<UserModel>> GetAllUser();
        Task<string> UpdateUser(UserModel model);
    }
}
