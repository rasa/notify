//go:build !windows && !plan9
// +build !windows,!plan9

package notify

import (
	"os"
	"syscall"
)

func GetFileUID(path string) (int, error) {
	stat, err := os.Stat(path)
	if err != nil {
		return -1, err
	}
	return int(stat.Sys().(*syscall.Stat_t).Uid), nil
}
