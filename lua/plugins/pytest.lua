-- RECONSTRUCTED from ~/.cache/nvim/luac bytecode (source was 679 B, 2026-04-25).
return {
  "richardhapb/pytest.nvim",
  ft = "python",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    docker = {
      enabled = true,
      container = "dev-gripper-ros",
      docker_path = "/root/ROS_Gripper/src",
      local_path_prefix = "home/piotrekjanisz/work/monomagic/gripper-ros",
      enable_docker_compose = true,
      docker_compose_file = "docker-compose.yml",
      docker_compose_service = "dev-gripper-ros",
    },
    open_output_onfail = true,
    add_args = {},
  },
}
