local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- Типы файлов, которые обозначают корень Java-проекта, они будут использоваться jdtls.
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- jdtls хранит файлы, специфичные для проекта, внутри папки с оным. Если вы работаете с множеством
-- разных проектов, каждый должен будет использовать отдельную папку под такие файлы.
-- Эта переменная используется для конфигурации jdtls на использование названия папки
-- текущего проекта используя root_marker как папку под специфичные файлы проекта.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Вспомогательная функция для создания сочетаний клавиш
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- Функция on_attach используется тут для настройки сочетаний клавиш после того,
-- как языковой сервер подключается к текущему буферу
local on_attach = function(client, bufnr)
  -- Стандартные сочетания для LSP клиента Neovim
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  nnoremap('<C-l>', vim.lsp.buf.definition, bufopts, "Go to definition")
  nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  nnoremap('<S-u>', vim.lsp.buf.hover, bufopts, "Hover text")
  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
  nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  nnoremap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")
  nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
  nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
  nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")

  -- Java расширения, предоставленные jdtls
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })
end


local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- потому что используем плагин vsnip cmp
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<CR>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach,  -- Передаём наши сочетания из on_attach в общие сочетания клавиш конфига
  root_dir = root_dir, -- Устанавливаем корневую папку для найденного root_marker

  -- Тут вы можете настроить специфичные для eclipse.jdt.ls параметры, которые будут передаваться LSP на его старте.
  -- См.: https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- для полного списка опций
  settings = {
    java = {
      format = {
        settings = {
          -- Используем гайд по форматированию Java от Google
          -- Убедитесь, что вы загрузили файл https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- и поместили его в папку ~/.local/share/eclipse, например
          url = "/home/arseniy/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Используем утилиту fernflower для декомпиляции кода библиотек
      -- Указываем опции для авто-дополнения
      completion = {
        importOrder = {
          "com",
          "org",
          "jakarta",
          "java"
        },
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Указываем опции для организации импорта из библиотек
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- Параметры кодо-генерации
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- Если вы разрабатываете проекты используя разные версии Java, то нужно сообщить eclipse.jdt.ls местоположения ваших JDK.
      -- См.: https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- И ищете `interface RuntimeOption`.
	  -- ВАЖНО: Поле `name` НЕ выбирается произвольно, но должно соответствовать одному из элементов в `enum ExecutionEnvironment` по ссылке выше.
      configuration = {
        runtimes = {
        }
      }
    }
  },
  -- cmd это тот набор аргументов, который будет передан в командной строке для старта jdtls
  -- Заметьте, что тот использует Java версии 17 или выше.
  -- См.: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- для полного списка опций.
  cmd = {
    "java",
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- Следующий jar файл расположен внутри папки, в которую вы установили/распаковали jdtls.
    -- ВАЖНО: не забудьте изменить путь до jdtls ниже:
    '-jar', '/home/arseniy/jdt-language-server-1.26.0-202307271613/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',

    -- Стандартная конфигурация для jdtls также расположена внутри его папки.
	-- ВАЖНО: измените путь до jdtls, а также выберите конфиг-папку согласно вашей системе: config_win, config_linux или config_mac:
    '-configuration', '/home/arseniy/jdt-language-server-1.26.0-202307271613/config_linux',

    -- Переиспользуем workspace_folder определённый выше, чтобы хранить специфичные jdtls данные для проекта
    '-data', workspace_folder,
  },
}

-- Наконец, запускаем jdtls. Эта команда запустит языковой сервер с конфигурацией, которую мы предоставили,
-- настроит сочетания клавиш и закрепит LSP клиент за текущим буфером:
jdtls.start_or_attach(config)
