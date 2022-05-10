package main

import (
	"fmt"
	"os"
)

func main() {

	er := os.MkdirAll("bin/zzzzz.json", 0777)

	if er != nil {
		panic(er)
	}

	fmt.Println("all ok")
}
