//go:build windows
// +build windows

package notify

import (
	"os"
)

func GetFileUid(path string) (int, error) {
	return os.Getuid(), nil
}
