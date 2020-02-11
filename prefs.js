// primeira inicialização
user_pref("browser.startup.homepage_override.mstone", "ignore");

// nova aba vazia
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.enabled", false);

// nova janela vazia
user_pref("browser.startup.homepage", "about:blank");

// não migrar favoritos
user_pref("browser.newtabpage.activity-stream.migrationExpired", true);

// Ordem dos tabs
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// personalizar ferramentas
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[],\"currentVersion\":16,\"newElementCount\":0}");

// abrir ultimas abas ao iniciar
//user_pref("browser.startup.page", 3);

// sempre perguntar download
user_pref("browser.download.useDownloadDir", false);

// sem sugestão de pesquisa
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.discovery.enabled", false);

// não rastrear
user_pref("browser.contentblocking.category", "strict");
user_pref("network.cookie.cookieBehavior", 4);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);

// não notificar privacidade
user_pref("browser.contentblocking.introCount", 20);

// trocar buscador
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");

// não enviar relatórios
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 2);
user_pref("datareporting.policy.dataSubmissionPolicyNotifiedTime", "9000000000999");

// extras
user_pref("browser.download.lastDir.savePerSite", false);
user_pref("browser.sessionstore.max_windows_undo", 0);

// permitir colar no console
user_pref("devtools.selfxss.count", 5);

// manter log de rede quando redirecionar
user_pref("devtools.netmonitor.persistlog", true);

// desligar cache quando monitorar rede
//user_pref("devtools.cache.disabled", true);

// disable captiveportal
user_pref("network.captive-portal-service.enabled", false);

// cabeçalho e rodapé de impressão
user_pref("print.print_footerleft", "");
user_pref("print.print_footercenter", "");
user_pref("print.print_footerright", "");
user_pref("print.print_headerleft", "");
user_pref("print.print_headercenter", "");
user_pref("print.print_headerright", "");
