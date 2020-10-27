package config

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"sync"
)

type MysqlConfig struct {
	Host     string `json:"host"`
	Port     int    `json:"port"`
	Charset  string `json:"charset"`
	Database string `json:"database"`
	Username string `json:"username"`
	Password string `json:"password"`
}
type AppConfig struct {
	Debug bool        `json:"debug"`
	Port  int         `json:"port"`
	Mysql MysqlConfig `json:"mysql"`
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
