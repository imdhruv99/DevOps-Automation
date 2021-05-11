package main


import (
	// Gin is lightweight framework of go, such as Flask in python
	"github.com/gin-gonic/gin"
	// Static library for serving html and static file
	"github.com/gin-gonic/contrib/static"
)

func main() {

	// Creating router object
	router := gin.Default()

	// Handler function called by HTTP GET, simply print "Hello World"
	router.GET("/hello", func(c *gin.Context){
		c.String(200, "Hello World")
	})

	// Creating api object for serving HTML and JSON
	api := router.Group("/api")

	api.GET("/ping", func(c *gin.Context){
		c.JSON(200, gin.H {
			"message": "pong",
		})
	})

	// Serving html files
	router.Use(static.Serve("/", static.LocalFile("./views", true)))

	// Running project on 9009
	router.Run(":9009")

}