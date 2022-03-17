using Dapper;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using WebApplication.Controllers;
using WebApplication.Model;
using WG.Model;
using WG.Repository.Interfaces;

namespace WG.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly IWGConnection _WGConnection;

        public UserRepository(IWGConnection WGConnection)
        {
            _WGConnection = WGConnection;
        }
        public async Task<string> getIID()
        {
            string IID = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"sp_oid";
                conn.Open();
                var result = await conn.QueryAsync<string>(sQuery, commandType: CommandType.StoredProcedure);
                conn.Close();
                IID = result.First();
            }
            return IID;
        }
        public async Task<List<UserModel>> GetAllUser()
        {
            List<UserModel> rs = new List<UserModel>();
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"GetAllUser";
                conn.Open();
                var result = await conn.QueryAsync<UserModel>(sQuery, commandType: CommandType.StoredProcedure);
                conn.Close();
                rs = result.ToList();
            }
            return rs;
        }
        public async Task<string> insertIdeas(Ideas model)
        {
            string rs = "";  
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"sp_insertIdeas";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@IID", model.IID);
                    parameters.Add("@Title", model.Title);
                    parameters.Add("@Content", model.Content);
                    parameters.Add("@Crt_User", model.Crt_User);
                    parameters.Add("@Crt_Date", DateTime.Now);
                    parameters.Add("@IsActive", true);
                    parameters.Add("@IsOnline", false);
                    parameters.Add("@View_numb", model.View_numb);
                    parameters.Add("@StartDate", DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"));
                    parameters.Add("@EndDate", DateTime.Now.AddDays(90).ToString("yyyy-MM-dd"));
                    parameters.Add("@LikeNumb", 0);
                    parameters.Add("@DisLikeNumb", 0);
                    parameters.Add("@FileName", model.FileName);
                    parameters.Add("@FilePath", model.FilePath);
                    parameters.Add("@isOption", model.isOption);
                    parameters.Add("@Date_Online", DateTime.Now);
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Đăng ký tài khoản thành công!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        public async Task<string> UpdateUser(UserModel model)
        {
            string rs = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"UpdateStaffInfo";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@UserCode", model.UserCode);
                    parameters.Add("@Password", model.Password);
                    parameters.Add("@FullName", model.FullName);
                    parameters.Add("@Email", model.Email);
                    parameters.Add("@Address", model.Address);
                    parameters.Add("@NumberPhone", model.NumberPhone);
                    parameters.Add("@Position", model.Position);
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Update thành công!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        public async Task<string> QA_Brose(Ideas model)
        {
            string rs = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"QA_Update";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@Tag", model.Tag);
                    parameters.Add("@IID", model.IID); 
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Đăng ký tài khoản thành công!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        public async Task<string> DeleteIdeas(Ideas model)
        {
            string rs = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"DeleteIdeas";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@IID", model.IID);
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Xóa!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        public async Task<string> InsertLikeorDisLike(Ideas model)
        {
            string rs = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"Like_Dis_View";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@IID", model.IID);
                    parameters.Add("@Option", "LikeorDisLike");
                    parameters.Add("@UserLike", model.UserLike);
                    parameters.Add("@LikeNumb", model.LikeNumb);
                    parameters.Add("@UserDisLike", model.UserDisLike);
                    parameters.Add("@DisLikeNumb", model.DisLikeNumb);
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Success!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        
        public async Task<string> InsertView(string IDD,int viewer)
        {
            string rs = "";
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                try
                {
                    string sQuery = @"Like_Dis_View";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@IID", IDD);
                    parameters.Add("@Option", "View");
                    parameters.Add("@ViewNumb", viewer);
                    conn.Open();
                    await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    rs = "Success!";
                }
                catch (Exception ex)
                {

                }
            }
            return rs;
        }
        public async Task<IdeaViewModel> GetIdeasbyID(string ID)
        {
            IdeaViewModel rs = new IdeaViewModel();
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"getIdeasByID";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@IID", ID);
                conn.Open();
                var result = await conn.QueryMultipleAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                rs.ideas = result.Read<Ideas>().First();
                rs.ideaComments = result.Read<IdeaComments>().ToList();
                conn.Close();
            }
            return rs;
        }
        public async Task<List<Ideas>> GetDSAll(string option)
        {
            List<Ideas> rs = new List<Ideas>();
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"GetListIdeas";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@isOption", option);
                conn.Open();
                var result = await conn.QueryAsync<Ideas>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                rs = result.ToList();
                conn.Close();
            }
            return rs;
        }
        public async Task<statistical> statistical()
        {
            statistical rs = new statistical();
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"statistical";
                conn.Open();
                var result = await conn.QueryAsync<statistical>(sQuery, commandType: CommandType.StoredProcedure);
                rs = result.FirstOrDefault();
                conn.Close();
            }
            return rs;
        }
        public async Task<List<IdeaComments>> insertIdeasComment(IdeaComments model)
        {
            List<IdeaComments> rs = new List<IdeaComments>();
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"sp_insertIdeaComments";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@IID", model.IID);
                parameters.Add("@Comment", model.Comment);
                parameters.Add("@Crt_User", model.Crt_User);
                parameters.Add("@Crt_Date", DateTime.Now);
                conn.Open();
                var result = await conn.QueryAsync<IdeaComments>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                rs = result.ToList();
                conn.Close();
            }
            return rs;
        }
        public async Task<bool> LoginUser(string UserName, string Password)
        {
            UserModel model = new UserModel();
            bool login = false;
            # region Mã hóa
            using (System.Security.Cryptography.MD5CryptoServiceProvider md5 = new System.Security.Cryptography.MD5CryptoServiceProvider())
            {
                using (IDbConnection conn = _WGConnection.GetConnection())
                {
                    {
                        string sQuery = @"getKeyEnCrypt";
                        DynamicParameters parameters = new DynamicParameters();
                        parameters.Add("@UserName", UserName.Trim());
                        conn.Open();
                        var res = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                        conn.Close();
                        if (res.Count() > 0)
                        {
                            model = res.First();
                            //if (model.KeyEnCrypt != null)
                            //{
                            //    byte[] keyArr;
                            //    byte[] EnCryptArr = UTF8Encoding.UTF8.GetBytes(Password.Trim());
                            //    keyArr = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(model.KeyEnCrypt));
                            //    // mã hóa
                            //    TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
                            //    tripDes.Key = keyArr;
                            //    tripDes.Mode = CipherMode.ECB;
                            //    tripDes.Padding = PaddingMode.PKCS7;
                            //    System.Security.Cryptography.ICryptoTransform transform = tripDes.CreateEncryptor();
                            //    byte[] arrResult = transform.TransformFinalBlock(EnCryptArr, 0, EnCryptArr.Length);
                            //    Password = Convert.ToBase64String(arrResult, 0, arrResult.Length);
                            //}
                        }
                    }
                }
                #endregion
                if (model.KeyEnCrypt != null)
                {
                    using (IDbConnection conn = _WGConnection.GetConnection())
                    {
                        string sQuery = @"LoginUser";
                        DynamicParameters parameters = new DynamicParameters();
                        parameters.Add("@UserName", UserName.Trim());
                        parameters.Add("@Password", Password.Trim());
                        conn.Open();
                        var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                        conn.Close();
                        if (result.Count() > 0)
                        {
                            login = true;
                        }
                    }
                }
                return login;
            }
        }

        public async Task<bool> CheckKeyValidateUser(string UserName, string keyValidate)
        {
            bool login = false;
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"CheckKeyValidateUser";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserName", UserName.Trim());
                parameters.Add("@keyValidate", keyValidate.Trim());
                conn.Open();
                var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                conn.Close();
                if (result.Count() > 0)
                {
                    login = true;
                }
            }
            return login;
        }
        public async Task<UserModel> GetUserinfo(string UserName,string Password)
        {
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                UserModel model = new UserModel();
                string sQuery = @"LoginUser";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserName", UserName.Trim());
                parameters.Add("@Password", Password.Trim());
                conn.Open();
                var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                conn.Close();
                model = result.First();
                return model;
            }
        }
        public async Task<bool> CheckEmail(string Email)
        {
            bool login = false;
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"GetUserNameByEmail";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Email", Email.Trim());
                conn.Open();
                var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                conn.Close();
                if (result.Count() > 0)
                {
                    login = true;
                }
            }
            return login;
        }
        public async Task<bool> CheckUserName(string UserName)
        {
            bool login = false;
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"checkUserName";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserName", UserName.Trim());
                conn.Open();
                var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                conn.Close();
                if (result.Count() > 0)
                {
                    login = true;
                }
            }
            return login;
        }

        public async Task<bool> resetPassword(string KeyValidate, string Password, string UserName)
        {
            UserModel model = new UserModel();
            bool login = false;
            # region Mã hóa
            using (System.Security.Cryptography.MD5CryptoServiceProvider md5 = new System.Security.Cryptography.MD5CryptoServiceProvider())
            {
                using (IDbConnection conn = _WGConnection.GetConnection())
                {
                    {
                        string sQuery = @"getKeyEnCrypt";
                        DynamicParameters parameters = new DynamicParameters();
                        parameters.Add("@UserName", UserName.Trim());
                        conn.Open();
                        var res = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                        conn.Close();
                        if (res.Count() > 0)
                        {
                            model = res.First();
                            if (model.KeyEnCrypt != null)
                            {
                                byte[] keyArr;
                                byte[] EnCryptArr = UTF8Encoding.UTF8.GetBytes(Password.Trim());
                                keyArr = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(model.KeyEnCrypt));
                                // mã hóa
                                TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
                                tripDes.Key = keyArr;
                                tripDes.Mode = CipherMode.ECB;
                                tripDes.Padding = PaddingMode.PKCS7;
                                System.Security.Cryptography.ICryptoTransform transform = tripDes.CreateEncryptor();
                                byte[] arrResult = transform.TransformFinalBlock(EnCryptArr, 0, EnCryptArr.Length);
                                Password = Convert.ToBase64String(arrResult, 0, arrResult.Length);
                            }
                        }
                    }
                }
                #endregion
                if (model.KeyEnCrypt != null)
                {
                    using (IDbConnection conn = _WGConnection.GetConnection())
                    {
                        string sQuery = @"resetPassword";
                        DynamicParameters parameters = new DynamicParameters();
                        parameters.Add("@KeyValidate", KeyValidate.Trim());
                        parameters.Add("@Password", Password.Trim());
                        parameters.Add("@UserName", UserName.Trim());
                        conn.Open();
                        var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                        conn.Close();
                        if (result.Count() > 0)
                        {
                            login = true;
                        }
                    }
                }
            }
         return login;
        }

        public async Task<UserModel> CheckEmailSQL(string Email)
        {
            UserModel model = new UserModel();
            model.msg = "Email không có trong hệ thống!!!\nVui lòng kiểm tra lại.";
            try
            {
                using (IDbConnection conn = _WGConnection.GetConnection())
                {
                    string sQuery = @"GetUserNameByEmail";
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@Email", Email.Trim());
                    conn.Open();
                    var result = await conn.QueryAsync<UserModel>(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    if (result.Count() == 1)
                    {
                        model = result.First();
                        model.msg = "Mã xác nhận của bạn, đã được gửi vào địa chỉ Email:\n" + Email + ".";
                    }
                }
                return model;
            }
            catch (Exception ex)
            {
                model.msg = "Gửi Email thất bại.\nLý do: " + ex + "!";
                return model;
            }
        }
        public async Task resetKeyValidate(string UserName, string Email)
        {
            try
            {
                using (IDbConnection conn = _WGConnection.GetConnection())
                {
                    #region resetKeyValidate
                    string sQuery1 = @"resetKeyValidate";
                    DynamicParameters parameters1 = new DynamicParameters();
                    parameters1.Add("@UserName", UserName);
                    parameters1.Add("@Email", Email);
                    conn.Open();
                    await conn.QueryAsync(sQuery1, param: parameters1, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    #endregion 
                }
            }
            catch (Exception ex)
            {
            }
        }
        public async Task SendMailAuto(string Email)
        {
            try
            {
                using (IDbConnection conn = _WGConnection.GetConnection())
                {
                    #region create key random 
                    //var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    var chars = "0123456789";
                    var stringChars = new char[6];
                    var random = new Random();
                    for (int i = 0; i < stringChars.Length; i++)
                    {
                        stringChars[i] = chars[random.Next(chars.Length)];
                    }
                    var KeyValidate = new String(stringChars);
                    #endregion

                    #region create KeyValidate
                    string sQuery1 = @"updateCreateKeyValidate";
                    DynamicParameters parameters1 = new DynamicParameters();
                    parameters1.Add("@Email", Email);
                    parameters1.Add("@KeyValidate", KeyValidate);
                    conn.Open();
                    var res = await conn.QueryAsync<UserModel>(sQuery1, param: parameters1, commandType: CommandType.StoredProcedure);
                    conn.Close();
                    #endregion
                    if (res.Count() > 0)
                    {
                        #region send mail
                        using (MailMessage mail = new MailMessage())
                        {
                            mail.From = new MailAddress(ADMIN.Email, "WEB sắp có");
                            mail.To.Add(Email);
                            mail.Subject = "QUÊN MẬT KHẨU";
                            mail.Body = "Dear Quý khách,<br/>Xin vui lòng không cung cấp mã cho bất kỳ ai.<br/>Mã số của bạn là: " + KeyValidate + "<br/>Xin cảm ơn!";
                            mail.IsBodyHtml = true;
                            //mail.Attachments.Add(new Attachment("C:\\file.zip"));
                            using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
                            {
                                client.EnableSsl = true;
                                client.UseDefaultCredentials = false;
                                client.Credentials = new NetworkCredential(ADMIN.Email, ADMIN.Password);
                                client.Host = "smtp.gmail.com";
                                client.Port = 587;
                                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                                client.Send(mail);
                            }
                        }
                        #endregion
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        public async Task<UserModel> register(UserModelView data)
        {
            UserModel model = new UserModel();
            UserModel rs = new UserModel();
            UserModel model_KeyEnCrypt = new UserModel();
            model = data.UserModel;
            #region create KeyEnCrypt 
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"createKeyEnCrypt";
                DynamicParameters parameters = new DynamicParameters();
                conn.Open();
                var res = await conn.QueryAsync<UserModel>(sQuery, commandType: CommandType.StoredProcedure);
                conn.Close();
                model_KeyEnCrypt = res.First();
                model.KeyEnCrypt = model_KeyEnCrypt.KeyEnCrypt;
            }
            #endregion
            #region EnCrypt
            using (System.Security.Cryptography.MD5CryptoServiceProvider md5 = new System.Security.Cryptography.MD5CryptoServiceProvider())
            {
                byte[] keyArr;
                byte[] EnCryptArr = UTF8Encoding.UTF8.GetBytes(model.Password.Trim());
                keyArr = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(model.KeyEnCrypt));
                TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
                tripDes.Key = keyArr;
                tripDes.Mode = CipherMode.ECB;
                tripDes.Padding = PaddingMode.PKCS7;
                System.Security.Cryptography.ICryptoTransform transform = tripDes.CreateEncryptor();
                byte[] arrResult = transform.TransformFinalBlock(EnCryptArr, 0, EnCryptArr.Length);
                model.Password = Convert.ToBase64String(arrResult, 0, arrResult.Length);

                #region
                //// giải mã hóa 
                //byte[] DeCryptArr = Convert.FromBase64String(model.Password);
                //tripDes.Key = keyArr;
                //tripDes.Mode = CipherMode.ECB;
                //tripDes.Padding = PaddingMode.PKCS7;
                //System.Security.Cryptography.ICryptoTransform transforms = tripDes.CreateDecryptor();
                //byte[] arrResults = transforms.TransformFinalBlock(DeCryptArr, 0, DeCryptArr.Length);
                //var GiaiMH = UTF8Encoding.UTF8.GetString(arrResults);
                #endregion
            }
            #endregion
            using (IDbConnection conn = _WGConnection.GetConnection())
            {
                string sQuery = @"inserUser";
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@UserName", model.UserName.Trim());
                parameters.Add("@Password", model.Password.Trim());
                parameters.Add("@Email", model.Email.Trim());
                parameters.Add("@KeyEnCrypt", model.KeyEnCrypt);
                conn.Open();
                await conn.QueryAsync(sQuery, param: parameters, commandType: CommandType.StoredProcedure);
                conn.Close();
                rs.msg = "Đăng ký tài khoản thành công!";
            }
            return rs;
        }
    }
}
