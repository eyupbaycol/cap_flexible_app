sap.ui.define(
    [
        'sap/fe/core/PageController',
        'sap/m/MessageToast',
        'sap/ui/model/json/JSONModel'
    ],
    function(PageController,MessageToast,JSONModel) {
        'use strict';

        return PageController.extend('com.travel.flexapp.ext.main.Main', {
            onAfterRendering: function (oEvent) {
				var oView = this.getView();
				var mFBConditions = new JSONModel({
					allFilters: "",
					expanded: false,
					filtersTextInfo: oView.byId("FilterBar").getActiveFiltersText()
				});
				oView.setModel(mFBConditions, "fbConditions");
			},
			handlers: {
				onTilePress: function(oEvent) {
					var oContext = oEvent.getSource().getBindingContext();
					this.routing.navigate(oContext);
				},
				onFiltersChanged: function (oEvent) {
					var oView = this.getView();
					var filterBar = oView.byId("FilterBar");
					var allFilters = filterBar.getFilters();

					var oSource = oEvent.getSource();
					var mFBConditions = oSource.getModel("fbConditions");
					mFBConditions.setProperty("/allFilters", JSON.stringify(allFilters, null, "  "));

					if (Object.keys(allFilters).length > 0) {
						mFBConditions.setProperty("/expanded", true);
					}
					MessageToast.show("FilterBar filters are changed!");
					mFBConditions.setProperty("/filtersTextInfo", oSource.getActiveFiltersText());
				}
			}
        });
    }
);
