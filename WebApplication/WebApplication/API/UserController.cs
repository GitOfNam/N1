using Ionic.Zip;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using WebApplication.Model;
using WG.Model;
using WG.Repository;
using WG.Repository.Interfaces;

namespace WebApplication.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _UserRes;
        private readonly IHostingEnvironment _env;
        public UserController(IUserRepository UserRepository, IHostingEnvironment env)
        {
            _UserRes = UserRepository;
            _env = env;
        }
        public async Task Sentmail()
        {
            try
            {
                SmtpClient smtpClient = new SmtpClient("", 81);

                smtpClient.Credentials = new System.Net.NetworkCredential("tiennamhcm@gmail.com", "0869988767");
                // smtpClient.UseDefaultCredentials = true; // uncomment if you don't want to use the network credentials
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.EnableSsl = true;
                MailMessage mail = new MailMessage();

                //Setting From , To and CC
                mail.From = new MailAddress("tiennamhcm@gmail.com", "MyWeb Site");
                mail.To.Add(new MailAddress("nam0966692816@gmail.com"));
                smtpClient.Send(mail);
            }
            catch(Exception ex)
            {

            }
        }
        public async Task<UserModel> UserApp()
        {
            string loginname = "";
            string pass = "";
            UserModel model = new UserModel();
            string ruta = Path.Combine(_env.ContentRootPath, "conf.ini");
            StreamReader sr = new StreamReader(ruta);
            var conf2 = new INIHelper(sr);
            sr.Close();
            loginname = conf2.GetValue("username");
            pass = conf2.GetValue("password");
            var result = await _UserRes.GetUserinfo(loginname, pass);
            model = result;
            model.Position = model.Position.Trim();
            return model;
        }

        [HttpGet("LoginUser")]
        public async Task<bool> LoginUser(string UserName, string Password)
        {
            var result = await _UserRes.LoginUser(UserName, Password);
            string ruta = Path.Combine(_env.ContentRootPath, "conf.ini");
            var conf = new INIHelper();
            conf.SetValue("username", UserName);
            conf.SetValue("password", Password);
            try
            {
                StreamWriter sw = new StreamWriter(ruta);
                conf.Save(sw);
                sw.Close();
            }
            catch(Exception ex)
            {
               
                
            }
            return result;
        }
        [HttpGet("ttdn")]
        public async Task<UserModel> ttdn()
        {
            UserModel model = new UserModel();
            model = await UserApp();
            return model;
        }
        [HttpGet("CheckKeyValidateUser")]
        public async Task<bool> CheckKeyValidateUser(string UserName, string keyValidate)
        {
            var result = await _UserRes.CheckKeyValidateUser(UserName, keyValidate);
            return result;
        }
        [HttpGet("resetPassword")]
        public async Task<bool> resetPassword(string KeyValidate, string Password, string UserName)
        {
            var result = await _UserRes.resetPassword(KeyValidate, Password, UserName);
            return result;
        }
        [HttpGet("CheckEmail")]
        public async Task<bool> CheckEmail(string Email)
        {
            var result = await _UserRes.CheckEmail(Email);
            return result;
        }

        [HttpGet("CheckUserName")]
        public async Task<bool> CheckUserName(string UserName)
        {
            var result = await _UserRes.CheckUserName(UserName);
            return result;
        }

        [HttpGet("CheckEmailSQL")]
        public async Task<IActionResult> CheckEmailSQL(string Email)
        {
            var rs = 0;
            var result = await _UserRes.CheckEmailSQL(Email);
            if(result.UserName != null)
            {
                rs = 1;
            }
            return Ok(new
            {
                rs = rs,
                result = result,
            });
        }
        //[HttpGet("Download")]
        //public async Task<IActionResult> Download(string Email)
        //{
        //    string ruta = Path.Combine(_env.ContentRootPath, "Upload");
        //    return Ok(new
        //    {
        //        rs = rs,
        //        result = result,
        //    });
        //}
        [HttpGet("getIID")]
        public async Task<string> getIID()
        {
            return await _UserRes.getIID();
        }
        [HttpGet("GetAll")]
        public async Task<ActionResult<Ideas>> GetAll(int PageSize, int page = 1, string Option = "")
        {
            List<Ideas> rs = new List<Ideas>();
            UserModel user = new UserModel();
            user = await UserApp();
            rs = await _UserRes.GetDSAll(Option);
            foreach (var item in rs)
            {
                item.Date_Onlinefrm = item.Date_Online.ToString("yyyy-MM-dd");
            }
            int Offset = ((page - 1) * PageSize);
            return Ok(new
            {
                results = rs.Skip(Offset).Take(PageSize),
                total = rs.Count()
            });
        }
        [HttpGet("statistical")]
        public async Task<statistical> statistical()
        {
            statistical rs = new statistical();
            rs = await _UserRes.statistical();
            return rs;
        }
        [HttpGet("getIdeasByID")]
        public async Task<ActionResult<IdeaViewModel>> getIdeasByID(string ID)
        {
            bool isLike = false;
            bool isDisLike = false;
            IdeaViewModel rs = new IdeaViewModel();
            UserModel user = new UserModel();
            user = await UserApp();
            rs = await _UserRes.GetIdeasbyID(ID);
            rs.ideas.EndDatefrm = rs.ideas.EndDate.ToString("yyyy-MM-dd");
            rs.ideas.StartDatefrm = rs.ideas.StartDate.ToString("yyyy-MM-dd");
            //Comfirm DisLike
            if (rs.ideas.UserDisLike != null || rs.ideas.UserDisLike != "")
            {
                string[] mang = rs.ideas.UserDisLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            isDisLike = true;
                            break;
                        }
                        else
                        {
                           
                        }
                    }
                }
            }
            else
            {
                isDisLike = false;
            }
            //Comfirm Like
            if (rs.ideas.UserLike != null || rs.ideas.UserLike != "")
            {
                string[] mang = rs.ideas.UserLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            isLike = true;
                            break;
                        }
                        else
                        {

                        }
                    }
                }
            }
            else
            {
                isLike = false;
            }
            foreach (var item in rs.ideaComments)
            {
                item.Crt_Datefrm = item.Crt_Date.ToString("dd-MM-yy hh:mm");
            }
            return Ok(new
            {
                results = rs,
                isLike = isLike,
                isDisLike = isDisLike
            });
        }
        [HttpGet("AddViewer")]
        public async Task<string> AddViewer(string IID = "",int view = 0)
        {
            string rs = "";
            view += 1;
            rs = await _UserRes.InsertView(IID, view);
            return rs;
        }
        [HttpGet("downloadFile")]
        public async Task<string> downloadFile(string IID)
        {
            string rs = "";
            string zipPath = "";
            string zipurl = "";
            string NameFolder = IID.Replace(":", "");
            string ruta = Path.Combine(_env.ContentRootPath, "Fileout");
            IdeaViewModel model = new IdeaViewModel();
            UserModel user = new UserModel();
            user = await UserApp();
            model = await _UserRes.GetIdeasbyID(IID);
            if (!System.IO.Directory.Exists(ruta + "/" + user.UserCode))
            {
                System.IO.Directory.CreateDirectory(ruta + "/" + user.UserCode);
            }
            zipurl = ruta + "\\" + user.UserCode + "\\" + NameFolder;
            using (ZipFile zip = new ZipFile())
            {
                string[] mang = model.ideas.FileName.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        zipPath = model.ideas.FilePath + "/" + item;
                        zip.AddFile(zipPath, "");
                    }
                }
                try
                {
                    
                    zip.Save(zipurl + ".zip");
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        [HttpGet("GetAllUser")]
        public async Task<List<UserModel>> GetAllUser()
        {
            List<UserModel> model = new List<UserModel>();
            model = await _UserRes.GetAllUser();
            foreach(var item in model)
            {
                item.Position = item.Position.Trim();
            }
            return model;
        }
        [HttpPost("InsIdeas")]
        public async Task<string> InsIdeas(IdeasModel data)
        {
            await Sentmail();
            string rs = "";
            UserModel user = new UserModel();
            user = await UserApp();
            data.Ideas.Crt_User = user.UserCode;
            var result = await _UserRes.insertIdeas(data.Ideas);
            rs = result;
            return rs;
        }
        [HttpPost("UpdateUser")]
        public async Task<string> UpdateUser(UserModelView data)
        {
            string rs = "";
            rs = await _UserRes.UpdateUser(data.UserModel);
            return rs;
        }
        [HttpPost("Like")]
        public async Task<string> Like(IdeasModel data)
        {
            string rs = "";
            bool kt = false;
            UserModel user = new UserModel();
            user = await UserApp();
            if (data.Ideas.UserLike != null || data.Ideas.UserLike != "")
            {
                string[] mang = data.Ideas.UserLike.Split(";");
                foreach(var item in mang)
                {
                    if(item != "")
                    {
                        if(item == user.UserCode)
                        {
                            kt = true;
                            break;
                        }
                        else
                        {
                            kt = false;
                        }
                    }
                }
            }
            else
            {
                data.Ideas.UserLike += user.UserCode + ";";
                data.Ideas.LikeNumb += 1;
                string[] mang = data.Ideas.UserDisLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            data.Ideas.UserDisLike = data.Ideas.UserDisLike.Replace(user.UserCode + ";", "");
                            if (data.Ideas.DisLikeNumb > 0)
                            {
                                data.Ideas.DisLikeNumb -= 1;
                            }
                            break;
                        }
                        else
                        {
                            
                        }
                    }
                }
            }
            if(kt == false)
            {
                data.Ideas.UserLike += user.UserCode + ";";
                data.Ideas.LikeNumb += 1;
                string[] mang = data.Ideas.UserDisLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            data.Ideas.UserDisLike = data.Ideas.UserDisLike.Replace(user.UserCode + ";", "");
                            if(data.Ideas.DisLikeNumb > 0)
                            {
                                data.Ideas.DisLikeNumb -= 1;
                            }
                            break;
                        }
                        else
                        {

                        }
                    }
                }
            }
            var result = await _UserRes.InsertLikeorDisLike(data.Ideas);
            rs = result;
            return rs;
        }
        [HttpPost("DisLike")]
        public async Task<string> DisLike(IdeasModel data)
        {
            string rs = "";
            bool kt = false;
            UserModel user = new UserModel();
            user = await UserApp();
            if (data.Ideas.UserDisLike != null || data.Ideas.UserDisLike != "")
            {
                string[] mang = data.Ideas.UserDisLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            kt = true;
                            break;
                        }
                        else
                        {
                            kt = false;
                        }
                    }
                }
            }
            else
            {
                data.Ideas.UserDisLike += user.UserCode + ";";
                data.Ideas.DisLikeNumb += 1;
                string[] mang = data.Ideas.UserLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            data.Ideas.UserLike = data.Ideas.UserLike.Replace(user.UserCode + ";", "");
                            if (data.Ideas.LikeNumb > 0)
                            {
                                data.Ideas.LikeNumb -= 1;
                            }
                            break;
                        }
                        else
                        {

                        }
                    }
                }
            }
            if (kt == false)
            {
                data.Ideas.UserDisLike += user.UserCode + ";";
                data.Ideas.DisLikeNumb += 1;
                string[] mang = data.Ideas.UserDisLike.Split(";");
                foreach (var item in mang)
                {
                    if (item != "")
                    {
                        if (item == user.UserCode)
                        {
                            data.Ideas.UserLike = data.Ideas.UserLike.Replace(user.UserCode + ";", "");
                            if (data.Ideas.LikeNumb > 0)
                            {
                                data.Ideas.LikeNumb -= 1;
                            }
                            break;
                        }
                        else
                        {

                        }
                    }
                }
            }
            var result = await _UserRes.InsertLikeorDisLike(data.Ideas);
            rs = result;
            return rs;
        }
        [HttpPost("Browse")]
        public async Task<string> QA_Browse(IdeasModel data)
        {
            string rs = "";
            var result = await _UserRes.QA_Brose(data.Ideas);
            rs = result;
            return rs;
        }
        [HttpPost("DeleteIDeas")]
        public async Task<string> DeleteIDeas(IdeasModel data)
        {
            string rs = "";
            var result = await _UserRes.DeleteIdeas(data.Ideas);
            rs = result;
            return rs;
        }
        [HttpPost("InsIdeaComments")]
        public async Task<List<IdeaComments>> InsIdeaComments(CommentModel data)
        {
            List<IdeaComments> rs = new List<IdeaComments>();
            UserModel user = new UserModel();
            user = await UserApp();
            data.IdeaComments.Crt_User = user.UserCode;
            var result = await _UserRes.insertIdeasComment(data.IdeaComments);
            rs = result;
            foreach (var item in rs)
            {
                item.Crt_Datefrm = item.Crt_Date.ToString("yyyy-MM-dd");
            }
            return rs;
        }
        [HttpPost("SendMailAuto")]
        public async Task SendMailAuto(string Email)
        {
            await _UserRes.SendMailAuto(Email);
        }
        [HttpPost("resetKeyValidate")]
        public async Task resetKeyValidate(string UserName, string Email)
        {
            await _UserRes.resetKeyValidate(UserName, Email);
        }
        [HttpPost("register")]
        public async Task<IActionResult> register(UserModelView data)
        {
            var result = await _UserRes.register(data);
            return Ok(new
            {
                result = result,
            });
        }
        [HttpPost("uploadfile")]
        public async Task<IActionResult> UploadFilesImgEcontract(IFormCollection UploadedFiles)
        {
            string ruta = Path.Combine(_env.ContentRootPath, "Upload");
            string nameZip = "";
            string filename = "";
            string zipURL = "";
            string link = "";
            //string ruta = Path.Combine(_env.ContentRootPath, "");
            try
            {
                foreach (var formFile in UploadedFiles.Files)
                {
                    if (formFile.Length > 0)
                    {
                        string fileName = formFile.FileName;
                        filename += fileName + ";";
                        string NameFolder = formFile.Name;
                        NameFolder = NameFolder.Replace("/", "");
                        NameFolder = NameFolder.Replace(":", "");
                        nameZip = NameFolder;
                        if (!System.IO.Directory.Exists(ruta + "/" + NameFolder))
                        {
                            System.IO.Directory.CreateDirectory(ruta + "/" + NameFolder);
                        }
                        string fullPath = Path.Combine(ruta + "/" + NameFolder, fileName);
                        using (var stream = new FileStream(fullPath, FileMode.Create))
                        {
                            await formFile.CopyToAsync(stream);
                        }
                    }
                }
                //zipURL = "E:\\New Project\\WebApplication\\WebApplication\\Upload\\" + nameZip;
                 link = Path.Combine(_env.ContentRootPath, "Upload\\" + nameZip);
                //using (ZipFile zip = new ZipFile())
                //{
                //    try
                //    {
                //        zip.AddFile(zipURL, "a");
                //        zip.Save(zipURL + ".zip");
                //    }
                //    catch (Exception ex)
                //    {

                //    }
                //}

            }
            catch (Exception ex)
            {

            }
            return Ok(new
            {
                url = link,
                name = filename,
            });
        }
    }
}
