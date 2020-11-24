package twitter

import (
	"video.get/m/util"
)

const (
	tag = "twitter"
)

// TwitterVideoInfo - struct of twitter video
type TwitterVideoInfo struct {
}

// ParseTwitterVideo - parse tiktok video
func ParseTwitterVideo(URL string) (string, TwitterVideoInfo, error) {
	var videoInfo TwitterVideoInfo
	return "", videoInfo, util.MakeError(tag, "")
}
