package api

import "github.com/kataras/iris/v12"

const (
	Success = 0
	Fail    = -1
)

type Resp struct {
	code int
	msg  string
	data interface{}
}

func (self *Resp) writeJson(cxt iris.Context) {
	cxt.JSON(*self)
}
