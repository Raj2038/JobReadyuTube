using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JobReadyUtube.ViewModels
{
    public class VideoViewModel
    {
        public int ChannelDropDown { get; set; }
        public string VideoName { get; set; }
        public string VideoDescription { get; set; }
        public string VideoUrl { get; set; }
    }

    public class ChannelViewModel
    {
        public string ChannelName { get; set; }
        public string ChannelDescription { get; set; }
    }
}