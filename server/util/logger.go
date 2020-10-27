package util

import (
	"log"

	"video.get/m/config"
)

// Debug - just print log in debug mode
func Debug(v ...interface{}) {
	if config.Instance().Debug {
		log.Println(v)
	}
}
