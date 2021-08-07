var app = angular.module('myclientApp', []);
app.controller("clientsController", function ($scope, $http) {

    $scope.updateShow = false;
    $scope.addShow = true;   
    $scope.gender = [];
    $scope.clientList = [];
    $scope.add = function () {

        var newclient = 
        {
            "FK_GenderID" : $scope.SelectedGenderID.GenderID,
            "FirstName" :$scope.FirstName,
            "LastName" : $scope.LastName
        };
        $http.post('/Client/AddClient', newclient).then(function (response) {
            $scope.GetAllClients();
            $scope.updateShow = false;
            $scope.addShow = true;
        });
    }
    $scope.GetAllClients = function () {
        $http.get('/Client/GetClients').then(function (response) {
            $scope.clientList = [];
            $scope.clientList = response.data;
        });
    }
    $scope.GetAllClients();
    $scope.GetGenderList = function () {
        $http.get('/Client/GetGender').then(function (response) {
            $scope.gender = response.data;
        });
    }
    $scope.GetGenderList();
    $scope.update = function () {
        var clients =
        {
            "ClientID": $scope.ClientID,
            "FK_GenderID": $scope.SelectedGenderID.GenderID,
            "FirstName": $scope.FirstName,
            "LastName": $scope.LastName
        };
        $http.post('/Client/UpdateClient', clients).then(function (response) {
            $scope.GetAllClients();
            $scope.updateShow = false;
            $scope.addShow = true;
        });
    }
    $scope.edit = function (client) {
        $scope.FirstName = client.FirstName;
        $scope.LastName = client.LastName;
        $scope.ClientID = client.ClientID;
        $scope.SelectedGenderID = "1";
        $scope.gender.GenderID = 1;
        $scope.updateShow = true;
        $scope.addShow = false;
    }
    $scope.cancel = function () {
        $scope.updateShow = false;
        $scope.addShow = true;
        $scope.FirstName = '';
        $scope.LastName ='';
        $scope.LastName ='';
    }
    $scope.delete = function (client) {

        $http.post('/Client/DeleteClient', client).then(function (response) {
            $scope.GetAllClients();
        });
    } 
    $scope.delete = function (contact) {
        $http.get('/Client/GetAllClients').then(function (response) {
            $scope.Search(contact.FK_ClientID);
        });
    }
});   