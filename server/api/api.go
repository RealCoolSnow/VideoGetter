package api

import (
	"encoding/json"
	"fmt"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/kataras/iris/v12"
	"video.get/m/db/entity"
	"video.get/m/db/service"
	"video.get/m/media"
)

// Router set for app
func Router(db *sqlx.DB) func(iris.Party) {
	return func(r iris.Party) {
		r.Get("/", index())

		r.Get("/parse", parseVideoURL(db))
	}
}

func index() iris.Handler {
	return func(c iris.Context) {
		msg := fmt.Sprintf("Hello World - %s", time.Now())
		c.WriteString(msg)
	}
}

func parseVideoURL(db *sqlx.DB) iris.Handler {
	return func(c iris.Context) {
		url := c.URLParam("url")
		resp := Response{}
		if url == "" {
			resp.Write(c, ErrParams, "empty url", nil)
		} else {
			mediaInfo, err := media.GetMediaInfo(url)
			userAgent := c.GetHeader("User-Agent")
			insertParseRecord(db, url, userAgent, mediaInfo, err)
			if err != nil {
				resp.Write(c, Fail, err.Error(), nil)
			} else {
				resp.Write(c, Success, "ok", mediaInfo)
			}
		}
	}
}

func insertParseRecord(db *sqlx.DB, url string, userAgent string, mediaInfo media.MediaInfo, err error) {
	var parseRecord entity.ParseRecord
	if err != nil {
		parseRecord.Result = err.Error()
	} else {
		jsonInfo, err := json.Marshal(mediaInfo)
		if err != nil {
			parseRecord.Result = err.Error()
		} else {
			parseRecord.Result = string(jsonInfo)
		}
	}
	parseRecord.Source = mediaInfo.Source.ID
	parseRecord.URL = url
	parseRecord.UserAgent = userAgent
	service.ParseRecordInsert(db, &parseRecord)
}
