require 'html-proofer'

module Jekyll
    module GitMtime
        class GitError < StandardError; end

        # run before most other hooks
        LOW_PRIORITY = Jekyll::Hooks::PRIORITY_MAP[:low]

        # Various constants
        MTIME_PAGE_VAR = 'mtime'

        Jekyll::Hooks.register(:pages, :post_init, priority: LOW_PRIORITY) do |page|
            if (page.data[MTIME_PAGE_VAR] == 'site.time' || page.data[MTIME_PAGE_VAR] == 'build')
                # mtime has been explicitly set to site.time (time of current build)
                page.data[MTIME_PAGE_VAR] = page.site.time
            elsif (page.data[MTIME_PAGE_VAR] == nil)
                git_status_str = `git status --porcelain -uall --ignored -- #{page.path}`
                if ($? != 0)
                    raise GitError, "git status failed"
                end

                if (!git_status_str.empty?)
                    # git status reported that the file has been modified/ignored/staged/...
                    # => report file mtime instead of the last commit's time
                    page.data['mtime'] = File.mtime page.path
                else
                    git_log_str = `git log -1 --format=format:"%ct" -- #{page.path}`
                    if ($? != 0 || git_log_str.empty?)
                        raise GitError, "git log failed"
                    end

                    page.data['mtime'] = Time.at git_log_str.to_i
                end
            end
        end
    end
end