using BL.API;
using BL.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;

namespace WebApp.Controllers
{
    public class ClientController : Controller
    {
        // GET: Client
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// get gender types
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetGender()
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.GetList("GetGender");
                response.EnsureSuccessStatusCode();
                List<GenderModel> list = response.Content.ReadAsAsync<List<GenderModel>>().Result;
                return Json(list.ToList(), JsonRequestBehavior.AllowGet);
            }
            catch(Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// get list of clients
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetClients()
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.GetList("GetAll");
                response.EnsureSuccessStatusCode();
                List<ClientModel> list = response.Content.ReadAsAsync<List<ClientModel>>().Result;
                return Json(list.ToList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// get clients
        /// </summary>
        /// <returns></returns>
        public JsonResult GetClientsByID(int ID)
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.GetList("GetByID/?clientID="+ ID);
                response.EnsureSuccessStatusCode();
                ClientModel list = response.Content.ReadAsAsync<ClientModel>().Result;
                return Json(list, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// download all clients
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetAllClients()
        {
            try
            {
                ApiRepository objcontact = new ApiRepository();
                HttpResponseMessage objresponse = new HttpResponseMessage();
                objresponse = objcontact.GetList("GetContactTypes");
                objresponse.EnsureSuccessStatusCode();
                List<ContactTypes> list = objresponse.Content.ReadAsAsync<List<ContactTypes>>().Result.ToList();
                return Json(list, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// add new client
        /// </summary>
        /// <param name="client"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult AddClient(ClientModel client)
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.Add("Add",client);
                response.EnsureSuccessStatusCode();
                ApiResponse returnvalue = response.Content.ReadAsAsync<ApiResponse>().Result;
                return Json(returnvalue, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// update client information
        /// </summary>
        /// <param name="client"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult UpdateClient(ClientModel client)
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.Update("Update", client);
                response.EnsureSuccessStatusCode();
                ApiResponse returnvalue = response.Content.ReadAsAsync<ApiResponse>().Result;
                return Json(returnvalue, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// delete client
        /// </summary>
        /// <param name="client"></param>
        /// <returns></returns>
        // POST: Client/Delete/5
        [HttpPost]
        public JsonResult DeleteClient(ClientModel client)
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.Delete("Delete/?clientID=" + client.ClientID);
                response.EnsureSuccessStatusCode();
                ApiResponse returnvalue = response.Content.ReadAsAsync<ApiResponse>().Result;
                return Json(returnvalue, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
