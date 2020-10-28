package main

import (
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/kataras/iris/v12"
	"video.get/m/api"
	"video.get/m/config"
	"video.get/m/util"
)

func main() {
	config.Init(config.ConfigPath())
	conf := config.Instance()
	/// database init
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?parseTime=true&charset=%s",
		conf.Mysql.Username,
		conf.Mysql.Password,
		conf.Mysql.Host,
		conf.Mysql.Port,
		conf.Mysql.Database,
		conf.Mysql.Charset,
	)
	util.Debug("dsn", dsn)
	db, err := sqlx.Open("mysql", dsn)
	if err != nil {
		log.Fatalf("error connecting to the MySQL database: %v", err)
	}
	defer db.Close()
	/// web init
	app := iris.New()
	// set log
	// f, _ := os.Create("web.log")
	// app.Logger().SetOutput(f)
	// if conf.Debug {
	// 	app.Logger().SetLevel("debug")
	// } else {
	// 	app.Logger().SetLevel("error")
	// }
	subRouter := api.Router(db)
	app.PartyFunc("/", subRouter)

	addr := fmt.Sprintf(":%d", conf.Port)
	app.Listen(addr)
}
