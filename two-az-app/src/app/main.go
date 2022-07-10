package main

import "github.com/gin-gonic/gin"

func main() {
	router := gin.Default()

	v1 := router.Group("/v1")
	cache := v1.Group("/cache")
	{
		cache.GET("/", Healthz)
		cache.POST("/put", PutCache)
		cache.GET("/get", GetCache)
	}

	router.Run(":8081")
}
