package api

import "github.com/kataras/iris/v12"

const (
	Success    = 0
	Fail       = -1
	ErrParams = -2
)

type Resp struct {
	code int         `json:"code"`
	msg  string      `json:"msg"`
	data interface{} `json:"data"`
}

func (self *Resp) WriteJson(cxt iris.Context) {
	cxt.JSON(iris.Map{
		"code": self.code,
		"msg":  self.msg,
		"data": self.data,
	})
}

func (self *Resp) Success(cxt iris.Context) {
	self.Write(cxt, Success, "ok", nil)
}

func (self *Resp) Fail(cxt iris.Context) {
	self.Write(cxt, Fail, "fail", nil)
}

func (self *Resp) Write(cxt iris.Context, code int, msg string, data interface{}) {
	self.code = code
	self.msg = msg
	self.data = data
	self.WriteJson(cxt)
}
func (self *Resp) GetCode() int {
	return self.code
}

func (self *Resp) GetMsg() string {
	return self.msg
}

func (self *Resp) GetData() interface{} {
	return self.data
}
