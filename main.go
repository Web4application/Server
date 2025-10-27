package main

import (
	"fmt"
	"os"

	"github.com/agentio/sidecar"
	"github.com/agentio/translate-io/genproto/translatepb"
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
	var address string
	cmd := &cobra.Command{
		Use:   "translate TEXT",
		Short: "Translate with the Cloud Translation API",
		Args:  cobra.MinimumNArgs(1),
		RunE: func(cmd *cobra.Command, args []string) error {
			client := sidecar.NewClient(address)
			response, err := sidecar.CallUnary[translatepb.TranslateTextRequest, translatepb.TranslateTextResponse](
				cmd.Context(),
				client,
				"/google.cloud.translation.v3.TranslationService/TranslateText",
				sidecar.NewRequest(
					&translatepb.TranslateTextRequest{
						SourceLanguageCode: source,
						TargetLanguageCode: target,
						Contents:           args,
						Parent:             parent,
					}))
			if err != nil {
				return err
			}
			b, err := protojson.MarshalOptions{Indent: "  "}.Marshal(response.Msg)
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
	cmd.Flags().StringVarP(&address, "address", "a", "localhost:4444", "service address")
	return cmd
}
