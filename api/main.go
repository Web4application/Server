package main

import (
	"fmt"
	"os"

	translate "cloud.google.com/go/translate/apiv3"
	"cloud.google.com/go/translate/apiv3/translatepb"
	"github.com/spf13/cobra"
	"google.golang.org/protobuf/encoding/protojson"
)

func main() {
	if err := cmd().Execute(); err != nil {
		os.Exit(1)
	}
}

func cmd() *cobra.Command {
	var source string
	var target string
	var parent string
	cmd := &cobra.Command{
		Use:   "translate TEXT",
		Short: "Translate with the Cloud Translation API",
		Args:  cobra.MinimumNArgs(1),
		RunE: func(cmd *cobra.Command, args []string) error {
			ctx := cmd.Context()
			c, err := translate.NewTranslationClient(ctx)
			if err != nil {
				return err
			}
			defer c.Close()
			response, err := c.TranslateText(ctx, &translatepb.TranslateTextRequest{
				SourceLanguageCode: source,
				TargetLanguageCode: target,
				Contents:           args,
				Parent:             parent,
			})
			if err != nil {
				return err
			}
			b, err := protojson.MarshalOptions{Indent: "  "}.Marshal(response)
			if err != nil {
				return err
			}
			fmt.Fprintf(cmd.OutOrStdout(), "%s\n", string(b))
			return nil
		},
	}
	cmd.Flags().StringVar(&source, "source", "en-us", "source language")
	cmd.Flags().StringVar(&target, "target", "es-mx", "target language")
	cmd.Flags().StringVarP(&parent, "parent", "p", "", "parent project (format: projects/PROJECTID)")
	return cmd
}
