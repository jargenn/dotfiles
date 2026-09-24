{ inputs, ... }:
{
  imports = [ inputs.pi.homeModules.default ];

  programs.pi.coding-agent = {
    enable = true;
    rules = "Be concise.";
    # skills = [ ./skills/my-skill ];
    # models = ./models.json;
    # settings.model = "gpt-5";
    # environment.PI_CODING_AGENT_DIR.value = "${config.home.homeDirectory}/.pi/agent";
    # environment.OPENAI_API_KEY.file = config.sops.secrets.openai-api-key.path;
  };
}
