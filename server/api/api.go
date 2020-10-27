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
	}
}

func index() iris.Handler {
	return func(c iris.Context) {
		msg := fmt.Sprintf("Hello World - %s", time.Now())
		c.WriteString(msg)
	}
}
