package parser

import (
	"encoding/json"
	"fmt"
	"net/url"
	"regexp"

	"video.get/m/httputil"
	"video.get/m/util"
)

const (
	tag  = "weibo"
	vurl = "http://h5.video.weibo.com/api/component?page="
)

type JSONObject map[string]interface{}

// ParseWeiboVideo - parse weibo video
func ParseWeiboVideo(wbURL string) (string, error) {
	re := regexp.MustCompile(`[0-9]+:[0-9]+`)
	oid := re.FindString(wbURL)
	if oid == "" {
		return "", util.MakeError(tag, "parse error")
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
	data, err := httputil.Post(apiURL, payload, headers)
	if err != nil {
		return "", err
	}
	var jsonData JSONObject
	err = json.Unmarshal(data, &jsonData)
	if err != nil {
		return "", err
	}
	dataJson := jsonData["data"].(JSONObject)
	if dataJson != nil {
		infoJson := dataJson["Component_Play_Playinfo"].(JSONObject)
		util.Debug(infoJson)
	}
	return string(data), err
}
