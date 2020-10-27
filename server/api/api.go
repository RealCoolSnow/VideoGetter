package api

import (
	"fmt"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/kataras/iris/v12"
)

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
		if url == "" {
			c.WriteString("url empty")
		} else {
			c.WriteString(url)
		}
	}
}
