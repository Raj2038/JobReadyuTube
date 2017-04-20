using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using JobReadyUtube.Models;
using JobReadyUtube.ViewModels;
using System.Data.Entity;

namespace JobReadyUtube.Controllers
{
    public class VideoController : Controller
    {
        // GET: Video
        public ActionResult Index()
        {
            return View();
        }


        [HttpGet]
        public ActionResult UploadVideo()
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                //TODO find all channel of current user
                //ToDO add to ViewBag.ChannelList
                // go to the view
                var allChannel =
                    db.Channels.Where(x => x.UserId == CurrentSession.CurrentUser.Id).ToList();
                ViewBag.ChannelList = allChannel;
                return View();
            }
        }
        [HttpPost]
        public ActionResult CreateNewChannel(ChannelViewModel model)
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var newChannel = new Channel
                {
                    Name = model.ChannelName,
                    Description = model.ChannelDescription,
                    UserId = CurrentSession.CurrentUser.Id

                };
                db.Channels.Add(newChannel);
                db.SaveChanges();
                return Json(new
                {
                    Success = true,
                    ChannelId = newChannel.Id,
                    ChannelName = newChannel.Name
                });
            }
        }

        [HttpPost]
        public ActionResult UploadVideo(VideoViewModel model)
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var newVideo = new Video
                {
                    Name = model.VideoName,
                    Description = model.VideoDescription,
                    URL = model.VideoUrl,
                    ChannelId = model.ChannelDropDown,
                    UserId = CurrentSession.CurrentUser.Id,
                    CreatedOn = DateTime.Now,
                    CreatedBy = CurrentSession.CurrentUser.Id,
                    IsActive = true
                };
                db.Videos.Add(newVideo);
                db.SaveChanges();
                return Json(new { Success = true, VideoId = newVideo.Id });
            }
        }

        public ActionResult VideoManagement()
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var allVideo = db.Videos.Include(x => x.Channel)
                                        .Where(x => x.UserId == CurrentSession.CurrentUser.Id).ToList();

                return View(allVideo);

            }
        }

        public ActionResult DisplayVideo(int id)
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var video = db.Videos.Find(id);
                return View(video);
            }
        }

        public ActionResult AddComment(int videoId, string comment)
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var commentObj = new Comment
                {
                    Content = comment,
                    VideoId = videoId,
                    UserId = CurrentSession.CurrentUser.Id,
                    //Cr = CurrentSession.CurrentUser.Id,
                    //CreatedOn = DateTime.Now,
                    //IsActive = true,
                };
                db.Comments.Add(commentObj);
                db.SaveChanges();
                return Json(new { Success = true });
            }
        }

        public ActionResult LoadVideoComment(int videoId)
        {
            using (var db = new MyUtubeDatabaseEntities())
            {
                var allComments = db.Comments.Where(x => x.VideoId == videoId).ToList();
                return PartialView("CommentListPartial", allComments);
            }
        }
    }
}