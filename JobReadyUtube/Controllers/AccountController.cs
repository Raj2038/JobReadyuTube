using JobReadyUtube.Models;
using JobReadyUtube.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace JobReadyUtube.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
   

        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(RegisterViewModel model)
        {
            //logic saving register detail in the User table

            using (var db = new MyUtubeDatabaseEntities())
            {
                var newUser = new User
                {
                    Username = model.Username,
                    Email = model.Email,                  
                    Password = model.Password,
                    CreatedOn = DateTime.Now,                  
                    IsActive = true,                 
                };
                db.Users.Add(newUser);
                db.SaveChanges();
                //save the cookie in browers
                FormsAuthentication.SetAuthCookie(model.Username, true);
                ResetCurrentUserSession(model.Username);

                return RedirectToAction("Index", "Home");
            }

           
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(LoginViewModel model)
        {
            //logic compare want username / password with User table

            using (var db = new MyUtubeDatabaseEntities())
            {
                var existUser = db.Users.Where(x => x.Username == model.Username 
                                     && x.Password == model.Password).FirstOrDefault();
                if (existUser == null)
                {
                    ViewBag.IncorrectLogin = "Sorry incorrect Username / Password";
                    return View();
                }
                else
                {
                    FormsAuthentication.SetAuthCookie(model.Username,false);
                    ResetCurrentUserSession(model.Username);
                    return RedirectToAction("Index","Home");
                }

            }

               
        }
        public static void ResetCurrentUserSession(string userName = null)
        {
            if (string.IsNullOrEmpty(userName))
            {
                userName = System.Web.HttpContext.Current.User.Identity.Name;
            }

            using (var db = new MyUtubeDatabaseEntities())
            {
                var user = db.Users.FirstOrDefault(n => n.Username == userName);
                // modified for forgot password
                if (user == null)
                {
                    return;
                }
                // Generic of CurrentUser that can user across system
                CurrentSession.CurrentUser = user;
            }
        }

        public ActionResult LogOff()
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            CurrentSession.CurrentUser = null;
            return RedirectToAction("Index", "Home");
        }
    }
}