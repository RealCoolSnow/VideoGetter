package util

import (
	"errors"
	"fmt"
)

// MakeError - error with tag
func MakeError(tag string, msg string) error {
	errmsg := fmt.Sprintf("[%s] %s", tag, msg)
	return errors.New(errmsg)
}
