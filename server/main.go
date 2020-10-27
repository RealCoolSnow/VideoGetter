package main

import (
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/kataras/iris/v12"
	"video.get/m/api"
)

const (
	EnvPrefix string = "VG_"
)

func main() {
	/// database init
	dsn := fmt.Sprintf("%s:%s@tcp(%s:3306)/%s?parseTime=true&charset=utf8",
		getenv("MYSQL_USER", "root"),
		getenv("MYSQL_PASSWORD", "xiaofengMUmu@0927"),
		getenv("MYSQL_HOST", "localhost"),
		getenv("MYSQL_DATABASE", "snow"),
	)

	db, err := sqlx.Open("mysql", dsn)
	if err != nil {
		log.Fatalf("error connecting to the MySQL database: %v", err)
	}
	defer db.Close()
	/// web init
	app := iris.New()
	subRouter := api.Router(db)
	app.PartyFunc("/", subRouter)

	addr := fmt.Sprintf(":%s", getenv("PORT", "8081"))
	app.Listen(addr)
}

func getenv(key string, def string) string {
	v := os.Getenv(EnvPrefix + key)
	if v == "" {
		return def
	}

	return v
}
