using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using JobReadyUtube.Models;
using JobReadyUtube.Controllers;

namespace JobReadyUtube.ViewModels
{
    public class CurrentSession
    {


        public static User CurrentUser
        {
            get { 
                if (HttpContext.Current.Session["CurrentUser"]== null)
                {
                    AccountController.ResetCurrentUserSession();
                }

                return (User)HttpContext.Current.Session["CurrentUser"];
            }

            set {
                HttpContext.Current.Session["CurrentUser"] = value;
            }
        }

    }
}