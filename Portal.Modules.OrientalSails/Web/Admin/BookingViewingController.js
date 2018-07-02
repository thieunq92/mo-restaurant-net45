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
            $("[data-id='txtMenuDetail']").val(menu.Detail)
            $rootScope.calculateTotalPrice();
        }, function (response) {
        })
    }
}])
moduleBookingViewing.controller("priceController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {

}])
moduleBookingViewing.controller("numberOfPaxController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
}])
moduleBookingViewing.controller("numberOfDiscountedPaxController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
}])
moduleBookingViewing.controller("totalPriceController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $rootScope.calculateTotalPrice = function () {
        var numberOfPaxAdult = 0;
        try {
            numberOfPaxAdult = parseInt($rootScope.numberOfPax.Adult);
        } catch (Exception) { }
        var numberOfDiscountedPaxAdult = 0;
        try {
            numberOfDiscountedPaxAdult = parseInt($rootScope.numberOfDiscountedPax.Adult);
        } catch (Exception) { }
        var costPerPersonAdult = 0.0;
        try {
            costPerPersonAdult = parseFloat($rootScope.costPerPerson.Adult.replace(/,/g, ''));
        } catch (Exception) { }
        try {
            numberOfPaxChild = parseInt($rootScope.numberOfPax.Child);
        } catch (Exception) { }
        var numberOfDiscountedPaxChild = 0;
        try {
            numberOfDiscountedPaxChild = parseInt($rootScope.numberOfDiscountedPax.Child);
        } catch (Exception) { }
        var costPerPersonChild = 0.0;
        try {
            costPerPersonChild = parseFloat($rootScope.costPerPerson.Child.replace(/,/g, ''));
        } catch (Exception) { }
        try {
            numberOfPaxBaby = parseInt($rootScope.numberOfPax.Baby);
        } catch (Exception) { }
        var numberOfDiscountedPaxBaby = 0;
        try {
            numberOfDiscountedPaxBaby = parseInt($rootScope.numberOfDiscountedPax.Baby);
        } catch (Exception) { }
        var costPerPersonBaby = 0.0;
        try {
            costPerPersonBaby = parseFloat($rootScope.costPerPerson.Baby.replace(/,/g, ''));
        } catch (Exception) { }
        $rootScope.totalPrice =
            (numberOfPaxAdult - numberOfDiscountedPaxAdult) * costPerPersonAdult
            + (numberOfPaxChild - numberOfDiscountedPaxChild) * costPerPersonChild
            + (numberOfPaxBaby - numberOfDiscountedPaxBaby) * costPerPersonChild
            + $rootScope.totalServiceOutside;
        $rootScope.totalPrice = $rootScope.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}])
moduleBookingViewing.controller("bookerController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $scope.bookerGetAllByAgencyId = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/BookerGetAllByAgencyId",
            data: {
                "agencyId": $scope.agencyId,
            },
        }).then(function (response) {
            $scope.listBooker = JSON.parse(response.data.d);
        }, function (response) {
        })
    }
}])
moduleBookingViewing.controller("commissionController", ["$rootScope", "$scope", "$http", "$timeout", function ($rootScope, $scope, $http, $timeout) {
    $rootScope.listCommission = []
    $scope.loadCommission = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/CommissionGetAllByBookingId",
            data: {
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $rootScope.listCommission = JSON.parse(response.data.d);
        }, function (response) {
        })
        $timeout(function () {
            $("[data-control='inputmask']").inputmask({
                'alias': 'numeric',
                'groupSeparator': ',',
                'autoGroup': true,
                'digits': 2,
                'digitsOptional': true,
                'placeholder': '0',
                'rightAlign': false
            })
        }, 0);
    }

    $scope.addCommission = function () {
        $rootScope.listCommission.push({ id: -1, payFor: "", amount: 0, restaurantBookingId: $rootScope.restaurantBookingId })
        $timeout(function () {
            $("[data-control='inputmask']").inputmask({
                'alias': 'numeric',
                'groupSeparator': ',',
                'autoGroup': true,
                'digits': 2,
                'digitsOptional': true,
                'placeholder': '0',
                'rightAlign': false
            })
        }, 0);
    }
    $scope.removeCommission = function (index) {
        $rootScope.listCommission.splice(index, 1);
    }
    $rootScope.totalCommission = 0;
    $scope.calculateTotalCommission = function () {
        var total = 0;
        for (var i = 0; i < $rootScope.listCommission.length; i++) {
            var commission = $rootScope.listCommission[i];
            total += parseFloat(commission.amount.toString().replace(/,/g, ''));
        }
        $rootScope.totalCommission = total;
        return total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}])
moduleBookingViewing.controller("serviceOutsideController", ["$rootScope", "$scope", "$http", "$timeout", function ($rootScope, $scope, $http, $timeout) {
    $rootScope.listServiceOutside = []
    $scope.loadServiceOutside = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/ServiceOutsideGetAllByBookingId",
            data: {
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $rootScope.listServiceOutside = JSON.parse(response.data.d);
        }, function (response) {
        })
        $timeout(function () {
            $("[data-control='inputmask']").inputmask({
                'alias': 'numeric',
                'groupSeparator': ',',
                'autoGroup': true,
                'digits': 2,
                'digitsOptional': true,
                'placeholder': '0',
                'rightAlign': false
            })
        }, 0);
    }
    var id = -1;
    $scope.addServiceOutside = function () {
        $rootScope.listServiceOutside.push({ id: id, service: "", unitPrice: 0, quantity: 0, totalPrice: 0, restaurantBookingId: $rootScope.restaurantBookingId, vat: $rootScope.bookingVAT, listServiceOutsideDetailDTO: [] })
        id += -1;
        $timeout(function () {
            $("[data-control='inputmask']").inputmask({
                'alias': 'numeric',
                'groupSeparator': ',',
                'autoGroup': true,
                'digits': 2,
                'digitsOptional': true,
                'placeholder': '0',
                'rightAlign': false
            })
        }, 0);
    }
    $scope.removeServiceOutside = function (index) {
        $rootScope.listServiceOutside.splice(index, 1);
    }
    $scope.calculateServiceOutside = function (index, unitPrice, quantity) {
        $rootScope.listServiceOutside[index].totalPrice = parseFloat(unitPrice.replace(/,/g, '')) * parseInt(quantity);
        $rootScope.listServiceOutside[index].totalPrice = $rootScope.listServiceOutside[index].totalPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    $rootScope.totalServiceOutside = 0;
    $rootScope.$watch('$root.totalServiceOutside', function () {
        $rootScope.calculateTotalPrice();
    })
    $rootScope.calculateTotalServiceOutside = function () {
        var total = 0;
        for (var i = 0; i < $rootScope.listServiceOutside.length; i++) {
            var serviceOutside = $rootScope.listServiceOutside[i];
            total += parseFloat(serviceOutside.totalPrice.toString().replace(/,/g, ''));
        }
        $rootScope.totalServiceOutside = total;
        return total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}])
moduleBookingViewing.controller("guideController", ["$rootScope", "$scope", "$http", "$timeout", function ($rootScope, $scope, $http, $timeout) {
    $rootScope.listGuide = []
    $scope.loadGuide = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/GuideGetAllByBookingId",
            data: {
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $rootScope.listGuide = JSON.parse(response.data.d);
        }, function (response) {
        })
    }

    $scope.addGuide = function () {
        $rootScope.listGuide.push({ id: -1, name: "", phone: "", restaurantBookingId: $rootScope.restaurantBookingId })
    }
    $scope.removeGuide = function (index) {
        $rootScope.listGuide.splice(index, 1);
    }
}])
moduleBookingViewing.controller("actuallyCollectedController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $rootScope.actuallyCollected = 0;
    $rootScope.totalCommission = 0;
    $rootScope.calculateActuallyCollected = function () {
        $rootScope.actuallyCollected = parseFloat($rootScope.totalPrice.toString().replace(/,/g, '')) - parseFloat($rootScope.totalCommission.toString().replace(/,/g, ''));
        $rootScope.actuallyCollected = $rootScope.actuallyCollected.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }
    $rootScope.$watch('$root.totalPrice', function () {
        $rootScope.calculateActuallyCollected();
    })
    $rootScope.$watch('$root.totalCommission', function () {
        $rootScope.calculateActuallyCollected();
    })
}])
moduleBookingViewing.controller("vatController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $scope.serviceOutsideChangeValueVAT = function () {
        for (var i = 0; i < $rootScope.listServiceOutside.length; i++) {
            $rootScope.listServiceOutside[i].vat = $rootScope.bookingVAT;
        }
    }
}])
moduleBookingViewing.controller("serviceOutsideDetailController", ["$rootScope", "$scope", "$http", "$timeout", function ($rootScope, $scope, $http, $timeout) {
    $scope.loadServiceOutsideDetail = function (serviceOutsideId) {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/ServiceOutsideDetailGetAllByServiceOutsideId",
            data: {
                "serviceOutsideId": serviceOutsideId,
            },
        }).then(function (response) {
            for (var i = 0; i < $rootScope.listServiceOutside.length; i++) {
                if ($rootScope.listServiceOutside[i].id == serviceOutsideId) {
                    $rootScope.listServiceOutside[i].listServiceOutsideDetailDTO = JSON.parse(response.data.d);
                }
            }
        }, function (response) {
        })
        $timeout(function () {
            $("[data-control='inputmask']").inputmask({
                'alias': 'numeric',
                'groupSeparator': ',',
                'autoGroup': true,
                'digits': 2,
                'digitsOptional': true,
                'placeholder': '0',
                'rightAlign': false
            })
        }, 0);
    }
    $scope.addServiceOutsideDetail = function (serviceOutsideId) {
        for (var i = 0; i < $rootScope.listServiceOutside.length; i++) {
            if ($rootScope.listServiceOutside[i].id == serviceOutsideId) {
                $rootScope.listServiceOutside[i].listServiceOutsideDetailDTO.push({ id: -1, name: "", unitPrice: 0, quantity: 0, totalPrice: 0 })
                $timeout(function () {
                    $("[data-control='inputmask']").inputmask({
                        'alias': 'numeric',
                        'groupSeparator': ',',
                        'autoGroup': true,
                        'digits': 2,
                        'digitsOptional': true,
                        'placeholder': '0',
                        'rightAlign': false
                    })
                }, 0);
            }
        }
    }
    $scope.removeServiceOutsideDetail = function (index, serviceOutsideId) {
        for (var i = 0; i < $rootScope.listServiceOutside.length; i++) {
            if ($rootScope.listServiceOutside[i].id == serviceOutsideId) {
                $rootScope.listServiceOutside[i].listServiceOutsideDetailDTO.splice(index, 1);
            }
        }

    }
}])
moduleBookingViewing.controller("saveController", ["$rootScope", "$scope", "$http", function ($rootScope, $scope, $http) {
    $scope.commissionSaveState = "undone";
    $scope.serviceOutsideSaveState = "undone";
    $scope.guideSaveState = "undone";
    $scope.bookerSaveState = "undone";
    $scope.save = function () {
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/CommissionSave",
            data: {
                "listCommissionDTO": $rootScope.listCommission,
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $scope.commissionSaveState = "done";
        }, function (response) {
        })
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/ServiceOutsideSave",
            data: {
                "listServiceOutsideDTO": $rootScope.listServiceOutside,
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $scope.serviceOutsideSaveState = "done";
        }, function (response) {
        })
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/GuideSave",
            data: {
                "listGuideDTO": $rootScope.listGuide,
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $scope.guideSaveState = "done"
        }, function (response) {
        })
        $http({
            method: "POST",
            url: "WebMethod/BookingViewingWebMethod.asmx/BookerSave",
            data: {
                "bookerId": $rootScope.bookerId,
                "restaurantBookingId": $rootScope.restaurantBookingId,
            },
        }).then(function (response) {
            $scope.bookerSaveState = "done"
        }, function (response) {
            alert(response);
        })
        $scope.$watchGroup(["commissionSaveState", "serviceOutsideSaveState", "guideSaveState", "bookerSaveState"], function (newValues, oldValues, scope) {
            if ($scope.commissionSaveState == "done"
                && $scope.serviceOutsideSaveState == "done"
                && $scope.guideSaveState == "done"
                && $scope.bookerSaveState == "done") {
                setTimeout(function () { __doPostBack($("#btnSave").attr("data-uniqueId"), "OnClick"); }, 1);
            }
        })
    };
}])

