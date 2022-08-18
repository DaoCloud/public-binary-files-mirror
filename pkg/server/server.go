package mirror

import (
	"fmt"
	"io/ioutil"
	"net/http"

	yaml "gopkg.in/yaml.v3"

	"github.com/gin-gonic/gin"
)

type Mirror struct {
	source string `yaml:"source"`
	url    string `yaml:"url"`
}

var Mirrors []Mirror

func setupRouter() *gin.Engine {
	// Disable Console Color
	// gin.DisableConsoleColor()
	r := gin.Default()

	for _, m := range Mirrors {
		// Ping test
		x := m
		r.GET("/"+x.source+"/*path", func(c *gin.Context) {
			path := c.Param("path")
			c.Redirect(http.StatusTemporaryRedirect, x.url+path)
		})
	}

	return r
}
func Run(port int) {
	r := setupRouter()
	r.Run(fmt.Sprintf("0.0.0.0:%v", port))
}

// Load the configuration file.
func LoadConfig(filename string) (err error) {

	// Read contents from configuration file.
	var contents []byte
	if contents, err = ioutil.ReadFile(filename); nil != err {
		return
	}
	data := make(map[string]map[string]string)

	// Parse contents into 'Get' configuration.
	yaml.Unmarshal(contents, &data)

	for v, k := range data["mirrors"] {
		var m = Mirror{v, k}
		Mirrors = append(Mirrors, m)
	}

	return
}
