package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/bketelsen/wide/conf"
)

// must be called in the parent of conf/users/ directory
func main() {
	username := flag.String("u", "", "username")
	password := flag.String("p", "", "password")
	email := flag.String("e", "", "email")
	home := flag.String("h", "", "home")
	flag.Parse()

	_, err := os.Stat("conf/wide.json")
	if err != nil {
		fmt.Println("ERROR: command must be run in the parent directory of wide config")
		os.Exit(-1)
	}

	if *username == "" || *password == "" || *email == "" || *home == "" {
		os.Exit(-1)
	}

	newUser := conf.NewUser(*username, *password, *email, *home)
	if newUser != nil {
		if success := newUser.Save(); !success {
			os.Exit(-1)
		}

		conf.UpdateCustomizedConf(*username)
	} else {
		fmt.Println("new user is nil")
		os.Exit(-1)
	}

}

func printUsage() {
	fmt.Println(usage)
}

const usage = `usage: wuser [username] [password] [email]`
