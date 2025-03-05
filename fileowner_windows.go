//go:build windows
// +build windows

package notify

import (
	"os"
)

func GetFileUID(path string) (int, error) {
	return os.Getuid(), nil
}
