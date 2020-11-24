package tiktok

import (
	"video.get/m/util"
)

const (
	tag = "tiktok"
)

// TiktokVideoInfo - struct of tiktok video
type TiktokVideoInfo struct {
}

// ParseTiktokVideo - parse tiktok video
func ParseTiktokVideo(URL string) (string, TiktokVideoInfo, error) {
	var videoInfo TiktokVideoInfo
	return "", videoInfo, util.MakeError(tag, "")
}
