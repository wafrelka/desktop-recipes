KEY_URL = "https://apt.releases.hashicorp.com/gpg"
APT_URL = "https://apt.releases.hashicorp.com"

code_name = run_command("lsb_release -cs").stdout.chomp
repository = "deb [arch=amd64] #{APT_URL} #{code_name} main"

execute "curl -fsSL #{escape(KEY_URL)} | apt-key add -" do
    not_if "cat /etc/apt/sources.list | grep -x -F #{escape(repository)}"
end

execute "add-apt-repository #{escape(repository)}" do
    not_if "cat /etc/apt/sources.list | grep -x -F #{escape(repository)}"
    notifies :run, "execute[apt-get update]"
end

execute "apt-get update" do
    action :nothing
end

package "terraform"
