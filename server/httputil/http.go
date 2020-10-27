package httputil

import (
	"io/ioutil"
	"net/http"
	"net/url"
	"strings"

	browser "github.com/EDDYCJY/fake-useragent"
	"video.get/m/util"
)

func setRandomUA(h http.Header) {
	h.Set("User-Agent", browser.Random())
}

// GetWebpage -
func GetWebpage(url string) (string, error) {
	client := &http.Client{}
	req, _ := http.NewRequest("GET", url, nil)
	setRandomUA(req.Header)
	resp, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	return string(body), err
}

// Post - post data
func Post(url string, data url.Values, headers map[string]string) ([]byte, error) {
	req, err := http.NewRequest(http.MethodPost, url, strings.NewReader(data.Encode()))
	setRandomUA(req.Header)
	for k, v := range headers {
		req.Header.Set(k, v)
	}
	util.Debug(req.Header)
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	return body, err
}
