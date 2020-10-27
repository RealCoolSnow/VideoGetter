package api

import (
	"fmt"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/kataras/iris/v12"
	"video.get/m/media"
)

// Router set for app
func Router(db *sqlx.DB) func(iris.Party) {
	return func(r iris.Party) {
		r.Get("/", index())

		r.Get("/parse", parseVideoURL())
	}
}

func index() iris.Handler {
	return func(c iris.Context) {
		msg := fmt.Sprintf("Hello World - %s", time.Now())
		c.WriteString(msg)
	}
}

func parseVideoURL() iris.Handler {
	return func(c iris.Context) {
		url := c.URLParam("url")
		resp := Resp{}
		if url == "" {
			resp.Write(c, ErrParams, "empty url", nil)
		} else {
			v, err := media.GetVideoURL(url)
			if err != nil {
				resp.Write(c, Fail, err.Error(), nil)
			} else {
				resp.Write(c, Success, "ok", v)
			}
		}
	}
}
