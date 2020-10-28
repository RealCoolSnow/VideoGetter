package parser

import (
	"encoding/json"
	"fmt"
	"net/url"
	"regexp"
	"strings"

	"video.get/m/util"
	"video.get/m/util/httpx"
)

const (
	tag  = "weibo"
	vurl = "http://h5.video.weibo.com/api/component?page="
)

// WeiboVideoInfo - for video list
type WeiboVideoInfo struct {
	P360      string `json:"p360"`
	P480      string `json:"p480"`
	P720      string `json:"p720"`
	P1080     string `json:"p1080"`
	P1080Plus string `json:"p1080plus"`
	//
	ComponentPlayInfo WeiboComponentPlayInfo `json:"info"`
}

// WeiboComponentPlayInfo -
type WeiboComponentPlayInfo struct {
	Mid        int64             `json:"mid"`
	ID         string            `json:"id"`
	Author     string            `json:"author"`
	Nickname   string            `json:"nickname"`
	Avatar     string            `json:"avatar"`
	Title      string            `json:"title"`
	CoverImage string            `json:"cover_image"`
	URLs       map[string]string `json:"urLs"`
}
type weiboPlayInfo struct {
	ComponentPlayInfo WeiboComponentPlayInfo `json:"Component_Play_Playinfo"`
}
type weiboObject struct {
	Code string        `json:"code"`
	Msg  string        `json:"msg"`
	Data weiboPlayInfo `json:"data"`
}

// ParseWeiboVideo - parse weibo video
func ParseWeiboVideo(wbURL string) (string, WeiboVideoInfo, error) {
	re := regexp.MustCompile(`[0-9]+:[0-9]+`)
	oid := re.FindString(wbURL)
	var videoInfo WeiboVideoInfo

	if oid == "" {
		return "", videoInfo, util.MakeError(tag, "parse error")
	}
	// get video
	apiURL := fmt.Sprintf("%s/show/%s", vurl, oid)
	payload := url.Values{}
	payloadData := fmt.Sprintf("{\"Component_Play_Playinfo\":{\"oid\":\"%s\"}}", oid)
	payload.Set("data", payloadData)
	headers := map[string]string{
		"Content-Type": "application/x-www-form-urlencoded",
		"Host":         "h5.video.weibo.com",
		"Origin":       "https://h5.video.weibo.com",
		"Referer":      "https://h5.video.weibo.com",
	}
	data, err := httpx.Post(apiURL, payload, headers)
	if err != nil {
		return "", videoInfo, err
	}
	var weiboData weiboObject
	err = json.Unmarshal(data, &weiboData)
	if err != nil {
		return "", videoInfo, err
	}
	videoInfo.ComponentPlayInfo = weiboData.Data.ComponentPlayInfo
	for k, v := range weiboData.Data.ComponentPlayInfo.URLs {
		v = fullURL(v)
		switch k {
		case "流畅 360P":
			videoInfo.P360 = v
		case "标清 480P":
			videoInfo.P480 = v
		case "高清 720P":
			videoInfo.P720 = v
		case "高清 1080P":
			videoInfo.P1080 = v
		case "高清 1080P+":
			videoInfo.P1080Plus = v
		}
	}
	return getRecommendVideo(videoInfo), videoInfo, err
}

func getRecommendVideo(videoInfo WeiboVideoInfo) string {
	if videoInfo.P720 != "" {
		return videoInfo.P720
	}
	if videoInfo.P480 != "" {
		return videoInfo.P480
	}
	if videoInfo.P1080 != "" {
		return videoInfo.P1080
	}
	if videoInfo.P1080Plus != "" {
		return videoInfo.P1080Plus
	}
	if videoInfo.P360 != "" {
		return videoInfo.P360
	}
	return ""
}

func fullURL(url string) string {
	if strings.HasPrefix(url, "//") {
		return "https:" + url
	}
	return url
}
