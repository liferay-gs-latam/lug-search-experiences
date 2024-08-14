<#function getFieldValueByName entry fieldName>
    <#if entry.getFieldDisplayContexts()?has_content>
        <#list entry.getFieldDisplayContexts() as fieldDisplayContext>
            <#if fieldDisplayContext.getName() == fieldName>
                <#return fieldDisplayContext.getValuesToString()?trim>
            </#if>
        </#list>
    </#if>
    <#return "">
</#function>

<div class="c-mb-4 c-mt-4 search-total-label">
    <#if searchContainer.getTotal() == 1>
        ${languageUtil.format(locale, "x-result-for-x", [searchContainer.getTotal(), "<strong>" + htmlUtil.escape(searchResultsPortletDisplayContext.getKeywords()) + "</strong>"], false)}
    <#else>
        ${languageUtil.format(locale, "x-results-for-x", [searchContainer.getTotal(), "<strong>" + htmlUtil.escape(searchResultsPortletDisplayContext.getKeywords()) + "</strong>"], false)}
    </#if>
</div>

<div class="display-compact">
    <ul class="list-unstyled">
        <#if entries?has_content>
            <#list entries as entry>
                <#assign wikipediaPageId = getFieldValueByName(entry, "wikipediaPageId")>
                <#if wikipediaPageId?has_content>
                    <#assign title = getFieldValueByName(entry, "title")>
                    <li class="align-items-center d-flex">
                        <div class="c-mb-2 c-mt-2">
                            <a class="link-primary single-link" href="http://en.wikipedia.org/?curid=${wikipediaPageId}" target="_blank">
                                ${title}
                            </a>
                        </div>
                    </li>
                <#else>
                    <li class="align-items-center d-flex">
                        <div class="c-mb-2 c-mt-2">
                            <a class="link-primary single-link" href="${entry.getViewURL()}">
                                ${entry.getHighlightedTitle()}
                            </a>
                        </div>

                        <#if entry.isAssetRendererURLDownloadVisible()>
                            <span
                                class="lfr-portal-tooltip c-ml-1"
                                title="${languageUtil.format(locale, 'download-x', ['(' + languageUtil.formatStorageSize(entry.getAssetRendererDownloadSize(), locale) + ')'])}"
                            >
                                <@clay.link
                                    aria\-label="${languageUtil.format(locale, 'download-x', [entry.getTitle()])}"
                                    cssClass="link-monospaced link-outline link-outline-borderless link-outline-secondary"
                                    displayType="secondary"
                                    href="${entry.getAssetRendererURLDownload()}"
                                >
                                    <@clay.icon symbol="download" />
                                </@clay.link>
                            </span>
                        </#if>
                    </li>
                </#if>
            </#list>
        </#if>
    </ul>
</div>