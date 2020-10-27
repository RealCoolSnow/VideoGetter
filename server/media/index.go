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

// GetVideoURL is parse video url
func GetVideoURL(url string) (string, error) {
	videoURL := ""
	err := errors.New("don't support")
	source := GetMediaSource(url)
	switch source {
	case Weibo:
		videoURL, err = parser.ParseWeiboVideo(url)
	}
	return videoURL, err
}

// GetMediaSource -
func GetMediaSource(url string) int {
	if strings.Contains(url, "weibo.com") {
		return Weibo
	}
	return Unknown
}
