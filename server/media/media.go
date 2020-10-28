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

const (
	NameWeibo = "Weibo"
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
			var videoInfo parser.WeiboVideoInfo
			videoURL, videoInfo, err = parser.ParseWeiboVideo(url)
			mediaInfo.URL = videoURL
			mediaInfo.Info = videoInfo
			mediaInfo.Source = SourceInfo{ID: Weibo, Name: NameWeibo}
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
