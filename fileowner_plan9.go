//go:build plan9
// +build plan9

package notify

import (
	"os"
	"os/user"
	"strconv"
	"syscall"
)

func GetFileUID(path string) (int, error) {
	stat, err := os.Stat(path)
	if err != nil {
		return -1, err
	}
	s := stat.Sys().(*syscall.Dir)
	u, err := user.Lookup(s.Uid)
	if err != nil {
		return -1, err
	}
	uid, err := strconv.Atoi(u.Uid)
	if err != nil {
		return -1, err
	}
	return uid, nil
}
