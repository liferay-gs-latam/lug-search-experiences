package lug.search.request.contributor;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.search.searcher.SearchRequest;
import com.liferay.portal.search.searcher.SearchRequestBuilder;
import com.liferay.portal.search.searcher.SearchRequestBuilderFactory;
import com.liferay.portal.search.spi.searcher.SearchRequestContributor;

@Component(immediate = true, property = "search.request.contributor.id=com.liferay.lug.br", service = SearchRequestContributor.class)
public class CustomSearchRequestContributor implements SearchRequestContributor {

	@Override
	public SearchRequest contribute(SearchRequest searchRequest) {

		SearchRequestBuilder searchRequestBuilder = searchRequestBuilderFactory.builder(searchRequest);

		_log.info("Federated Search Key: " + searchRequest.getFederatedSearchKey());
		_log.info("Fetch Source Value: " + searchRequest.getFetchSource());

		searchRequestBuilder.fetchSource(true);

		_log.info("Fetch Source New Value: true");

		return searchRequestBuilder.build();
	}

	@Reference
	protected SearchRequestBuilderFactory searchRequestBuilderFactory;

	private static final Log _log = LogFactoryUtil.getLog(CustomSearchRequestContributor.class);

}
