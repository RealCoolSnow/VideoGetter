package api

import "github.com/kataras/iris/v12"

const (
	// Success - ok
	Success = 0
	// Fail - error
	Fail = -1
	// ErrParams - params error
	ErrParams = -2
)

// Resp is a common json format
type Resp struct {
	code int
	msg  string
	data interface{}
}

func (r Resp) writeJSON(cxt iris.Context) {
	cxt.JSON(iris.Map{
		"code": r.code,
		"msg":  r.msg,
		"data": r.data,
	})
}

// Success for normal Resp
func (r Resp) Success(cxt iris.Context) {
	r.Write(cxt, Success, "ok", nil)
}

// Fail for normal Resp
func (r Resp) Fail(cxt iris.Context) {
	r.Write(cxt, Fail, "fail", nil)
}

// Write is Response the "Resp" Struct
func (r Resp) Write(cxt iris.Context, code int, msg string, data interface{}) {
	r.code = code
	r.msg = msg
	r.data = data
	r.writeJSON(cxt)
}

// GetCode return Resp.code
func (r Resp) GetCode() int {
	return r.code
}

// GetMsg return Resp.msg
func (r Resp) GetMsg() string {
	return r.msg
}

// GetData return Resp.data
func (r Resp) GetData() interface{} {
	return r.data
}
