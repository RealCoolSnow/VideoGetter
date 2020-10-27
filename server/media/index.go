package media

import (
	"errors"
	"strings"

	"video.get/m/media/parser"
)

// GetVideoURL is parse video url
func GetVideoURL(url string) (string, error) {
	// html, err := httputil.GetWebpage(url)
	videoURL := ""
	err := errors.New("Not Support")
	if strings.Contains(url, "weibo.com") {
		videoURL, err = parser.ParseWeiboVideo(url)
	}
	return videoURL, err
}
