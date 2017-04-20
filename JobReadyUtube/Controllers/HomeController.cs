using JobReadyUtube.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace JobReadyUtube.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (var db = new MyUtubeDatabaseEntities())
            {

                var allVideo = db.Videos.Where(x => x.IsActive).ToList();
                return View(allVideo);
            }
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}