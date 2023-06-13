package params

import (
	serverconfig "github.com/cosmos/cosmos-sdk/server/config"
)

var (
	// CustomConfigTemplate defines blackCore's custom application configuration TOML
	// template. It extends the core SDK template.
	CustomConfigTemplate = serverconfig.DefaultConfigTemplate
)

// CustomAppConfig defines blackCore's custom application configuration.
type CustomAppConfig struct {
	serverconfig.Config
}
