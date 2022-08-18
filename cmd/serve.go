/*
Copyright © 2022 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"

	server "github.com/DaoCloud/public-binary-files-mirror/pkg/server"
)

var port int

// serveCmd represents the serve command
var serveCmd = &cobra.Command{
	Use:   "serve",
	Short: "Run the Mirror Server",
	Run: func(cmd *cobra.Command, args []string) {
		server.LoadConfig(cfgFile)
		server.Run(port)
		fmt.Println(port)
		fmt.Println("serve called")
	},
}

func init() {
	rootCmd.AddCommand(serveCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	serveCmd.PersistentFlags().IntVarP(&port, "port", "p", 8080, "Port to listen on")

}
