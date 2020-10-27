package config

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"sync"
)

type AppConfig struct {
	Debug bool `json:"debug"`
}

var configPath string = "config.json"

var conf *AppConfig
var instanceOnce sync.Once

func LoadConfig(path string) *AppConfig {
	buf, err := ioutil.ReadFile(path)
	if err != nil {
		log.Panicln("load config conf failed: ", err)
	}
	mainConfig := &AppConfig{}
	err = json.Unmarshal(buf, mainConfig)
	if err != nil {
		log.Panicln("decode config file failed:", string(buf), err)
	}
	return mainConfig
}

// SetConfig -
func SetConfig(path string) {
	appConfig := LoadConfig(path)
	configPath = path
	conf = appConfig
}

func Init(path string) *AppConfig {
	if conf != nil && path != configPath {
		log.Printf("the config is already initialized, oldPath=%s, path=%s", configPath, path)
	}
	instanceOnce.Do(func() {
		mainConfig := LoadConfig(path)
		configPath = path
		conf = mainConfig
	})
	return conf
}

func Instance() *AppConfig {
	if conf == nil {
		Init(configPath)
	}
	return conf
}

func ConfigPath() string {
	return configPath
}
