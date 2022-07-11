package main

import (
	"context"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/cache/v8"
	"github.com/go-redis/redis/v8"
	"net/http"
	"time"
	"os"
)

var (
    dp_ip, _ = os.LookupEnv("DB_ADDR")
	redisClient = redis.NewClient(&redis.Options{
		Addr:     dp_ip+":6379",
		Password: "",
		DB:       0,
	})

	redisCache = cache.New(&cache.Options{
		Redis:      redisClient,
		LocalCache: cache.NewTinyLFU(1000, time.Minute),
	})
)

func Healthz(c *gin.Context) {
	c.JSON(http.StatusOK, "available")
}

func PutCache(c *gin.Context) {
	var body struct {
		Key   string `json:"key" binding:"required"`
		Value int    `json:"value" binding:"required"`
	}
	err := c.BindJSON(&body)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	//fmt.Printf("%+v", body)
	fmt.Println(body.Key)
	fmt.Println(body.Value)

	err = redisCache.Set(&cache.Item{
		Ctx:   context.TODO(),
		Key:   body.Key,
		Value: body.Value,
		TTL:   time.Minute,
	})
	if err != nil {
		panic(err)
	}

	c.JSON(http.StatusOK, gin.H{})
	return
}

func GetCache(c *gin.Context) {
	key := c.Query("key")

	var value int
	err := redisCache.Get(context.TODO(), key, &value)
	if err != nil {
		c.JSON(http.StatusNoContent, gin.H{})
		return
	}

	c.JSON(http.StatusOK, gin.H{"value": value})
}
