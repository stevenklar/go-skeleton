package main

import (
	"fmt"
	"os/exec"
)

func main() {
	cmdPtr := exec.Command("whoami")
	byt, err := cmdPtr.Output()
	if err != nil {
		panic(err)
	}

	fmt.Println(string(byt))
}
