package service

import (
	"github.com/jmoiron/sqlx"
	"video.get/m/db/entity"
)

// ParseRecordInsert - insert a record
func ParseRecordInsert(db *sqlx.DB, record *entity.ParseRecord) (int64, error) {
	result, err := db.NamedExec(`INSERT INTO parse_record (url,result,source,user_agent) VALUES (:url,:result,:source,:user_agent)`, record)
	if err != nil {
		return 0, nil
	}
	insertID, err := result.LastInsertId()
	return insertID, err
}
