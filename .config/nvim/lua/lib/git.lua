local GITHUB_PATTERN = "github.com"
local GITLAB_PATTERN = "gitlab.com"
local SCM_PATTERN = "scm.*%.int"

local function getGitRoot()
	-- Get the full path to the root-level of the current git repo
	local git_root =
		vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not in a git repository")
		return
	end

	return git_root
end

local function getHostUrl(url)
	-- HTTPS/SSH conversions
	url = url:gsub("%.git$", "")
	if url:match("git@") then
		-- Ex: git@github.com:myuser/repo
		url = url:gsub(":", "/") -- Do this _before_ replacing `git@` w/ `https://`
		url = url:gsub("^git@", "https://")
	end
	return url
end

local function getFullUrl(url, branch, relative_path)
	-- Used for GitHub + GitLab
	local function gitHubBase(url, branch, rel)
		return url .. "/blob/" .. branch .. "/" .. rel
	end

	local platforms = {
		{ pattern = GITHUB_PATTERN, builder = gitHubBase },
		{ pattern = GITLAB_PATTERN, builder = gitHubBase },
		{
			pattern = SCM_PATTERN,
			builder = function(url, branch, rel)
				url = url:gsub("scm/([^/]+)/", "projects/%1/repos/")
				return url .. "/browse/" .. rel .. "?at=refs%2Fheads%2F" .. branch
			end,
		},
	}

	for _, entry in ipairs(platforms) do
		if url:match(entry.pattern) then
			return entry.builder(url, branch, relative_path)
		end
	end

	print("Unsupported Git host: " .. url)
	print("Supported hosts: github.com, gitlab.com, scm.*.int")
	return nil
end

local function getRemoteUrl(git_root)
	local remote_url =
		vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " config --get remote.origin.url")[1]
	if vim.v.shell_error ~= 0 or not remote_url then
		print("No remote origin found")
		return
	end
	return remote_url
end

local function getGitBranch(git_root)
	local branch = vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " rev-parse --abbrev-ref HEAD")[1]
	if vim.v.shell_error ~= 0 or not branch then
		print("Could not determine branch")
		return
	end
	return branch
end

local function getFileUrl(filepath)
	local git_root = getGitRoot()
	if not git_root then return nil end

	local relative_path = filepath:sub(#git_root + 2)

	local remote_url = getRemoteUrl(git_root)
	if not remote_url then return nil end

	local branch = getGitBranch(git_root)
	if not branch then return nil end

	local host_url = getHostUrl(remote_url)
	return getFullUrl(host_url, branch, relative_path)
end

return {
	getFileUrl = getFileUrl,
}
