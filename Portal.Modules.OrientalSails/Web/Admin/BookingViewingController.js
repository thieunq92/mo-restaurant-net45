moduleBookingViewing.controller("menuController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $scope.menuGetById = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/MenuGetById",
            data: {
                "menuId": $scope.menuId,
            },
        }).then(function (response) {
            var menu = JSON.parse(response.data.d)
            $("[data-id='txtCostPerPersonAdult']").val(menu.Cost);
            $("[data-id='txtCostPerPersonChild']").val(menu.Cost);
            $("[data-id='txtCostPerPersonBaby']").val(menu.Cost);
            $rootScope.costPerPerson.Adult = menu.Cost.toString();
            $rootScope.costPerPerson.Child = menu.Cost.toString();
            $rootScope.costPerPerson.Baby = menu.Cost.toString();
            $rootScope.calculateTotalPrice();
        }, function (response) {
        })
    }
}])
moduleBookingViewing.controller("priceController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $rootScope.calculateTotalPrice = function () {
        $rootScope.totalPrice =
            (parseInt($rootScope.numberOfPax.Adult) - parseInt($rootScope.numberOfDiscountedPax.Adult)) * parseFloat($rootScope.costPerPerson.Adult.replace(/,/g, ''))
            + (parseInt($rootScope.numberOfPax.Child) - parseInt($rootScope.numberOfDiscountedPax.Child)) * parseFloat($rootScope.costPerPerson.Child.replace(/,/g, ''))
            + (parseInt($rootScope.numberOfPax.Baby) - parseInt($rootScope.numberOfDiscountedPax.Baby)) * parseFloat($rootScope.costPerPerson.Baby.replace(/,/g, ''))
        $rootScope.totalPrice = $rootScope.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}])
moduleBookingViewing.controller("numberOfPaxController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
}])
moduleBookingViewing.controller("numberOfDiscountedPaxController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
}])
moduleBookingViewing.controller("totalPriceController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
}])
moduleBookingViewing.controller("bookerController", ["$rootScope", "$scope", "$http", "$sniffer", function ($rootScope, $scope, $http, $sniffer) {
    $scope.bookerGetByAgencyId = function (ev) {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/BookerGetByAgencyId",
            data: {
                "agencyId": $scope.agencyId,
            },
        }).then(function (response) {
            var menu = JSON.parse(response.data.d);
        }, function (response) {
        })
    }

}])