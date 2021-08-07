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
    public class ContactsController : Controller
    {
        // GET: Contacts
        public ActionResult Index()
        {
            return View();
        }
      /// <summary>
      /// get  client contacts
      /// </summary>
      /// <param name="ID"></param>
      /// <returns></returns>
        public JsonResult GetClientContacts(int? ID)
        {
            try
            {
                ApiRepository objcontact = new ApiRepository();
                HttpResponseMessage objreponse = new HttpResponseMessage();
                objreponse = objcontact.GetList("GetContactByID/?clientID=" + ID);
                objreponse.EnsureSuccessStatusCode();
                List<ContactDetails> list = objreponse.Content.ReadAsAsync<List<ContactDetails>>().Result.ToList();
                return Json(list, JsonRequestBehavior.AllowGet);
            }
            catch(Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// get contacy types
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetContactTypes()
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
            catch(Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// add new client contact
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Add(ContactDetails model)
        {
            try
            {
                ApiRepository objcontact = new ApiRepository();
                HttpResponseMessage objresponse = new HttpResponseMessage();
                objresponse = objcontact.Add("AddContact",model);
                objresponse.EnsureSuccessStatusCode();
                ApiResponse result = objresponse.Content.ReadAsAsync<ApiResponse>().Result;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// update client contact
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Update(ContactDetails model)
        {
            try
            {
                ApiRepository objcontact = new ApiRepository();
                HttpResponseMessage objresponse = new HttpResponseMessage();
                objresponse = objcontact.Update("UpdateContact", model);
                objresponse.EnsureSuccessStatusCode();
                ApiResponse result = objresponse.Content.ReadAsAsync<ApiResponse>().Result;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// delete contact
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public JsonResult DeleteContact(ContactDetails model)
        {
            try
            {
                ApiRepository objclient = new ApiRepository();
                HttpResponseMessage response = new HttpResponseMessage();
                response = objclient.Delete("DeleteContact/?clientContactID=" + model.ClientContactID);
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