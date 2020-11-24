package media

import (
	"errors"
	"strings"

	"video.get/m/media/tiktok"
	"video.get/m/media/weibo"
)

const (
	Unknown = 0
	Weibo   = 1
	Tiktok  = 2
)

const (
	NameWeibo  = "Weibo"
	NameTiktok = "Tiktok"
)

// SourceInfo -
type SourceInfo struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// MediaInfo -
type MediaInfo struct {
	URL    string      `json:"url"`
	Info   interface{} `json:"info"`
	Source SourceInfo  `json:"source"`
}

// GetMediaInfo is parse video url
func GetMediaInfo(url string) (MediaInfo, error) {
	videoURL := ""
	err := errors.New("unsupport")
	source := GetMediaSource(url)
	var mediaInfo MediaInfo
	switch source {
	case Weibo:
		{
			var weiboVideoInfo weibo.WeiboVideoInfo
			videoURL, weiboVideoInfo, err = weibo.ParseWeiboVideo(url)
			mediaInfo.URL = videoURL
			mediaInfo.Info = weiboVideoInfo
			mediaInfo.Source = SourceInfo{ID: Weibo, Name: NameWeibo}
		}
	case Tiktok:
		{
			var tiktokVideoInfo tiktok.TiktokVideoInfo
			videoURL, tiktokVideoInfo, err = tiktok.ParseTiktokVideo(url)
			mediaInfo.URL = videoURL
			mediaInfo.Info = tiktokVideoInfo
			mediaInfo.Source = SourceInfo{ID: Tiktok, Name: NameTiktok}
		}
	}
	return mediaInfo, err
}

// GetMediaSource -
func GetMediaSource(url string) int {
	url = strings.ToLower(url)
	if strings.Contains(url, "weibo.com") {
		return Weibo
	} else if strings.Contains(url, "tiktok.com") {
		return Tiktok
	}
	return Unknown
}
