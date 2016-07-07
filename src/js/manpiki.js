var manpiki = {};
manpiki.VERBOSE = true;
manpiki.printv = function (argument) {
  if (manpiki.VERBOSE) {
    console.log(argument);
  }
}

manpiki.watcher = false;
setInterval( function () {
  if (manpiki.watcher) {
    window.location = window.location;
  }
}, 2000);

angular.module("manpiki", ["ui.bootstrap"])
.controller("ViewerController", ["$scope", "$http", "$filter", "$sce", function($scope, $http, $filter, $sce){
  $scope.thing="Hwllo World";
  $scope.words = [
  {
    word: "Some",
    qtrans: "Alguno",
    text: "my penis is quite big"
  },
  {
    word: "piki",
    qtrans: "Pikini",
    text: "Piki is a cool word"
  },
  {
    word: "running",
    qtrans: "corriendo",
    text: "Correr, del verbo correr"
  },
  {
    word: "Sandra",
    qtrans: "Pikipi",
    text: "El piki es muy piki."
  }
  ];
}]);
