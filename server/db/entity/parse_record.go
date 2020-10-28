package entity

import "time"

// ParseRecord - table `parse_record`
type ParseRecord struct {
	ID         int32      `db:"id" json:"id"`
	URL        string     `db:"url" json:"url"`
	Result     string     `db:"result" json:"result"`
	Source     int        `db:"source" json:"source"`
	UserAgent  string     `db:"user_agent" json:"user_agent"`
	CreateTime *time.Time `db:"create_time" json:"create_time"`
	UpdateTime *time.Time `db:"update_time" json:"update_time"`
}

// TableName - `parse_record`
func (t *ParseRecord) TableName() string {
	return "parse_record"
}

// PrimaryKey - `ID`
func (t *ParseRecord) PrimaryKey() string {
	return "id"
}

// ParseRecords - array of ParseRecord
type ParseRecords []*ParseRecord
