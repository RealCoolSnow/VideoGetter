package media

import (
	"errors"
	"strings"

	"video.get/m/media/parser"
)

const (
	Unknown = 0
	Weibo   = 1
)

// MediaInfo -
type MediaInfo struct {
	URL  string      `json:"url"`
	Info interface{} `json:"info"`
}

// GetMediaInfo is parse video url
func GetMediaInfo(url string) (MediaInfo, error) {
	videoURL := ""
	err := errors.New("don't support")
	source := GetMediaSource(url)
	var mediaInfo MediaInfo
	switch source {
	case Weibo:
		{
			var videoInfo parser.WeiboVideoInfo
			videoURL, videoInfo, err = parser.ParseWeiboVideo(url)
			mediaInfo.URL = videoURL
			mediaInfo.Info = videoInfo
		}
	}
	return mediaInfo, err
}

// GetMediaSource -
func GetMediaSource(url string) int {
	if strings.Contains(url, "weibo.com") {
		return Weibo
	}
	return Unknown
}
