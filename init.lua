local git_branch = '' -- Use a more modern git branch icon
local arrow_up = '↑'
local arrow_down = '↓'
local modified_icon = '●' -- Icon for modified files
local encoding_map = {
    -- Unicode (UTF)
    ['utf-8']        = 'UTF-8',
    ['utf8']         = 'UTF-8',
    ['utf-16']       = 'UTF-16',
    ['utf-16le']     = 'UTF-16LE',
    ['utf-16be']     = 'UTF-16BE',
    ['utf-32']       = 'UTF-32',
    ['utf-32le']     = 'UTF-32LE',
    ['utf-32be']     = 'UTF-32BE',

    -- ISO 8859 family (Western Europe, Latin, etc.)
    ['iso-8859-1']   = 'ISO-8859-1 (Latin-1, Western Europe)',
    ['iso-8859-2']   = 'ISO-8859-2 (Latin-2, Central Europe)',
    ['iso-8859-3']   = 'ISO-8859-3 (Latin-3, South Europe)',
    ['iso-8859-4']   = 'ISO-8859-4 (Latin-4, North Europe)',
    ['iso-8859-5']   = 'ISO-8859-5 (Cyrillic)',
    ['iso-8859-6']   = 'ISO-8859-6 (Arabic)',
    ['iso-8859-7']   = 'ISO-8859-7 (Greek)',
    ['iso-8859-8']   = 'ISO-8859-8 (Hebrew)',
    ['iso-8859-9']   = 'ISO-8859-9 (Turkish)',
    ['iso-8859-10']  = 'ISO-8859-10 (Nordic)',
    ['iso-8859-11']  = 'ISO-8859-11 (Thai)',
    ['iso-8859-13']  = 'ISO-8859-13 (Baltic)',
    ['iso-8859-14']  = 'ISO-8859-14 (Celtic)',
    ['iso-8859-15']  = 'ISO-8859-15 (Latin-9)',
    ['iso-8859-16']  = 'ISO-8859-16 (Romanian)',

    -- Windows encodings
    ['windows-1250'] = 'Windows-1250 (Central Europe)',
    ['windows-1251'] = 'Windows-1251 (Cyrillic)',
    ['windows-1252'] = 'Windows-1252 (Western Europe)',
    ['windows-1253'] = 'Windows-1253 (Greek)',
    ['windows-1254'] = 'Windows-1254 (Turkish)',
    ['windows-1255'] = 'Windows-1255 (Hebrew)',
    ['windows-1256'] = 'Windows-1256 (Arabic)',
    ['windows-1257'] = 'Windows-1257 (Baltic)',
    ['windows-1258'] = 'Windows-1258 (Vietnamese)',

    -- DOS Code Pages
    ['cp437']        = 'CP437 (DOS Latin US)',
    ['cp850']        = 'CP850 (DOS Latin-1)',
    ['cp852']        = 'CP852 (DOS Latin-2)',
    ['cp855']        = 'CP855 (DOS Cyrillic)',
    ['cp857']        = 'CP857 (DOS Turkish)',
    ['cp858']        = 'CP858 (DOS Latin-1 + Euro)',
    ['cp860']        = 'CP860 (Portuguese)',
    ['cp861']        = 'CP861 (Icelandic)',
    ['cp863']        = 'CP863 (French Canada)',
    ['cp865']        = 'CP865 (Nordic)',
    ['cp866']        = 'CP866 (Cyrillic Russian)',
    ['cp869']        = 'CP869 (Greek)',

    -- Macintosh
    ['macroman']     = 'MacRoman (Mac OS Western)',
    ['maccentraleurope'] = 'MacCentralEurope',
    ['macgreek']     = 'MacGreek',
    ['machebrew']    = 'MacHebrew',
    ['macarabic']    = 'MacArabic',
    ['maccyrillic']  = 'MacCyrillic',

    -- Asian encodings
    ['shift_jis']    = 'Shift_JIS (Japanese)',
    ['euc-jp']       = 'EUC-JP (Japanese)',
    ['iso-2022-jp']  = 'ISO-2022-JP (Japanese)',
    ['gbk']          = 'GBK (Simplified Chinese)',
    ['gb2312']       = 'GB2312 (Simplified Chinese)',
    ['gb18030']      = 'GB18030 (Simplified Chinese)',
    ['big5']         = 'Big5 (Traditional Chinese)',
    ['euc-kr']       = 'EUC-KR (Korean)',
    ['iso-2022-kr']  = 'ISO-2022-KR (Korean)',

    -- Universal character set
    ['ucs-2']        = 'UCS-2',
    ['ucs-2le']      = 'UCS-2LE',
    ['ucs-2be']      = 'UCS-2BE',
    ['ucs-4']        = 'UCS-4',

    -- Others
    ['ascii']        = 'ASCII',
    ['ansi']         = 'ANSI',
    ['binary']       = 'Binary/Raw',
    ['latin1']       = 'Latin-1 (ISO-8859-1)',
}
local line_ending_map = {
    ['\n'] = 'LF',
    ['\r\n'] = 'CRLF',
}

-- Language detection based on file extension
local function get_file_language(filename)
    local ext = filename:match('%.([^%.]+)$') or ''
    local language_map = {
        -- Linguagens de Programação
        ['lua']   = 'Lua',
        ['py']    = 'Python',
        ['js']    = 'JavaScript',
        ['ts']    = 'TypeScript',
        ['c']     = 'C',
        ['h']     = 'C Header',
        ['cpp']   = 'C++',
        ['cxx']   = 'C++',
        ['cc']    = 'C++',
        ['hpp']   = 'C++ Header',
        ['cs']    = 'C#',
        ['java']  = 'Java',
        ['kt']    = 'Kotlin',
        ['swift'] = 'Swift',
        ['rs']    = 'Rust',
        ['go']    = 'Go',
        ['rb']    = 'Ruby',
        ['php']   = 'PHP',
        ['pl']    = 'Perl',
        ['r']     = 'R',
        ['sh']    = 'Shell',
        ['bash']  = 'Shell',
        ['zsh']   = 'Shell',
        ['fish']  = 'Shell',
        ['ps1']   = 'PowerShell',
        ['asm']   = 'Assembly',
        ['s']     = 'Assembly',
        ['scm']   = 'Scheme',
        ['lisp']  = 'Lisp',
        ['clj']   = 'Clojure',
        ['ex']    = 'Elixir',
        ['exs']   = 'Elixir',
        ['erl']   = 'Erlang',
        ['ml']    = 'OCaml',
        ['fs']    = 'F#',
        ['d']     = 'D',
        ['nim']   = 'Nim',
        ['zig']   = 'Zig',
        ['v']     = 'V Lang',
        ['vala']  = 'Vala',
        ['dart']  = 'Dart',
        ['sql']   = 'SQL',
        ['adb']   = 'Ada',
        ['ads']   = 'Ada',
        ['m']     = 'Objective-C',
        ['mm']    = 'Objective-C++',

        -- Web
        ['html']  = 'HTML',
        ['htm']   = 'HTML',
        ['css']   = 'CSS',
        ['scss']  = 'SCSS',
        ['sass']  = 'SASS',
        ['xml']   = 'XML',
        ['json']  = 'JSON',
        ['yaml']  = 'YAML',
        ['yml']   = 'YAML',
        ['toml']  = 'TOML',
        ['ini']   = 'INI',
        ['vue']   = 'Vue',
        ['tsx']   = 'TSX',
        ['jsx']   = 'JSX',

        -- Make e Build
        ['makefile'] = 'Makefile',
        ['mk']       = 'Makefile',
        ['cmake']    = 'CMake',
        ['gradle']   = 'Gradle',
        ['gyp']      = 'GYP',
        ['bazel']    = 'Bazel',
        ['ninja']    = 'Ninja',

        -- Scripts e Configurações
        ['bat']   = 'Batch',
        ['conf']  = 'Config',
        ['cfg']   = 'Config',
        ['rc']    = 'Run Commands',
        ['env']   = 'Environment',
        ['service'] = 'Systemd Service',

        -- Documentação e Texto
        ['txt']   = 'Text',
        ['md']    = 'Markdown',
        ['rst']   = 'reStructuredText',
        ['org']   = 'Org Mode',
        ['tex']   = 'LaTeX',
        ['bib']   = 'BibTeX',
        ['log']   = 'Log File',
        ['csv']   = 'CSV',
        ['tsv']   = 'TSV',

        -- Outros comuns
        ['lock']  = 'Lockfile',
        ['gitignore'] = 'Git Ignore',
        ['gitattributes'] = 'Git Attributes',
        ['dockerfile'] = 'Dockerfile',
        ['license'] = 'License',
        ['readme']  = 'Readme',
    }

    return language_map[ext:lower()] or ext:upper() or 'Unknown'
end


-- Detect file encoding (simplified, assumes vis provides file content)
local function get_file_encoding(file)
    -- This is a placeholder; vis may not expose encoding directly.
    -- You may need to read the file content or use an external tool like `file`.
    return 'UTF-8' -- Default assumption
end

-- Detect line ending style
local function get_line_ending(file)
    -- Simplified: assumes access to file content
    local content = file:content(0, 1024) or '' -- Read first 1KB
    if content:find('\r\n') then return 'CRLF' end
    if content:find('\n') then return 'LF' end
    return 'Unknown'
end

-- Cache for git branch information
local branch_info = {}
local function update_branch_info(file)
    if not file or not file.name then return end
    -- local fname = file.name
    local fname = file.name:gsub("'", "'\\''")
    local script =  [=[
        pushd . > /dev/null
        dir=$(dirname "$PWD/]=] .. fname .. [=[")
        while [[ "$dir" != "/" && ! -d "$dir/.git" ]]; do
            dir=$(dirname "$dir")
        done
        cd "$dir" || exit 1
        [[ -d ".git" ]] || exit 1

        git_eng="env LANG=C git"
        arrow_up='__ARROW_UP'
        arrow_down='__ARROW_DOWN'
        branch=$($git_eng symbolic-ref --short HEAD 2>/dev/null)
        
        mod=$($git_eng status --porcelain)
        if [[ -n "$mod" ]]; then
            out="$branch ]=] .. modified_icon .. [=["
        else
            out="$branch"
        fi

        stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"

        [[ -n "$behindN" ]] && out+=" $behindN$arrow_down"
        [[ -n "$aheadN" ]] && out+=" $aheadN$arrow_up"

        popd > /dev/null
        [[ -n "$branch" ]] && echo "__GIT_BRANCH $out"
    ]=]

    local p = io.popen(script)
    local r = p:read("*a")
        :gsub("\n", "")                   -- Remove trailing newline
        :gsub("__GIT_BRANCH", git_branch) -- Insert git branch unicode character
        :gsub("__ARROW_UP", arrow_up)     -- Insert arrow up unicode character
        :gsub("__ARROW_DOWN", arrow_down) -- Insert arrow down unicode character
    p:close()
    if r ~= "" then
        branch_info[fname] = r
    else
        branch_info[fname] = nil -- Clear cache if no git repo
    end
end

-- Subscribe to file open and save events
vis.events.subscribe(vis.events.FILE_OPEN, update_branch_info)
vis.events.subscribe(vis.events.FILE_SAVE_POST, update_branch_info)

-- Status bar rendering
vis.events.subscribe(vis.events.WIN_STATUS, function(win)
    local left_parts = {}
    local right_parts = {}
    local file = win.file
    local selection = win.selection

    -- Editor mode
    local modes = {
        [vis.modes.NORMAL] = 'NORMAL',
        [vis.modes.OPERATOR_PENDING] = '',
        [vis.modes.VISUAL] = 'VISUAL',
        [vis.modes.VISUAL_LINE] = 'VISUAL-LINE',
        [vis.modes.INSERT] = 'INSERT',
        [vis.modes.REPLACE] = 'REPLACE',
    }
    local mode = modes[vis.mode]
    if mode ~= '' and vis.win == win then
        table.insert(left_parts, mode)
    end

    -- Git branch
    local branch = branch_info[file.name]
    if branch then
        table.insert(left_parts, branch)
    end

    -- File name and modification status
    table.insert(left_parts, (file.name or '[No Name]') ..
        (file.modified and ' ' .. modified_icon or '') .. (vis.recording and ' @' or ''))

    -- File language
    table.insert(right_parts, get_file_language(file.name or ''))

    -- File encoding
    table.insert(right_parts, get_file_encoding(file))

    -- Line ending
    table.insert(right_parts, get_line_ending(file))

    -- Selection and cursor position
    if #win.selections > 1 then
        table.insert(right_parts, selection.number .. '/' .. #win.selections)
    end

    local size = file.size
    local pos = selection.pos or 0
    table.insert(right_parts, (size == 0 and '0' or math.ceil(pos/size*100)) .. '%')

    if not win.large then
        local col = selection.col
        table.insert(right_parts, selection.line .. ':' .. col)
        if size > 33554432 or col > 65536 then
            win.large = true
        end
    end

    -- Format status bar to resemble VSCode
    local left = ' ' .. table.concat(left_parts, '  ') .. ' '
    local right = ' ' .. table.concat(right_parts, '  ') .. ' '
    win:status(left, right)
end)