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

// Response is a common json format
type Response struct {
	code int
	msg  string
	data interface{}
}

func (r *Response) writeJSON(cxt iris.Context) {
	cxt.JSON(iris.Map{
		"code": r.code,
		"msg":  r.msg,
		"data": r.data,
	})
}

// Success for normal Resp
func (r *Response) Success(cxt iris.Context) {
	r.Write(cxt, Success, "ok", nil)
}

// Fail for normal Resp
func (r *Response) Fail(cxt iris.Context) {
	r.Write(cxt, Fail, "fail", nil)
}

// Write is Response the "Resp" Struct
func (r *Response) Write(cxt iris.Context, code int, msg string, data interface{}) {
	r.code = code
	r.msg = msg
	r.data = data
	r.writeJSON(cxt)
}

// GetCode return Response.code
func (r Response) GetCode() int {
	return r.code
}

// GetMsg return Response.msg
func (r Response) GetMsg() string {
	return r.msg
}

// GetData return Response.data
func (r Response) GetData() interface{} {
	return r.data
}
