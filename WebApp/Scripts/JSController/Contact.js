var app = angular.module("myApp", []);
app.controller("contactController", function ($scope, $http) {
    $scope.contactList = [];
    $scope.typeList = [];
    $scope.FullName = '';
    $scope.ClientExist = false;
    $scope.CaptureInformation = false;
    $scope.ContactInfo = false;
    $scope.AdresstInfo = false;
    $scope.addShow = false;
    $scope.ContactTypeInfor = '';
    $scope.Search = function (client) {
        var value = {
            ID: client
        };
        $scope.ClientExist = false;
        $scope.contactList = [];
        $scope.FullName = '';
        $http.post('/Contacts/GetClientContacts/', value).then(function (response) {
            if (response.data.length > 0) {               
                $scope.contactList = response.data;
                $scope.FullName = response.data[0].FirstName + " " + response.data[0].LastName;
                $scope.ClientExist = true;
                $scope.addShow = true;
            } else {
                $http.post('/Client/GetClientsByID', value).then(function (response) {
                    if (response.data != "") {
                        $scope.FullName = response.data.FirstName + " " + response.data.LastName;
                        $scope.ClientExist = true;
                        $scope.addShow = true;
                    } else {
                        $scope.FullName = '';
                        $scope.ClientExist = false;
                    }
                });
            }
            $scope.Clear();
        });
    }
    $scope.TypeList = function () {
        $http.get("/Contacts/GetContactTypes").then(function (response) {
            $scope.typeList = response.data;
        });
    }
    $scope.TypeList();
    $scope.SetInformation = function (selected) {

        if (!selected) {
            $scope.CaptureInformation = false;
        }
        $scope.ContactTypeInfor = selected.ContactType;
        if (selected.ContactTypeID == 4 || selected.ContactTypeID == 5) {
            $scope.CaptureInformation = true;
            $scope.ContactInfo = true;
            $scope.AdresstInfo = false;
        } else {
            $scope.CaptureInformation = true;
            $scope.AdresstInfo = true;
            $scope.ContactInfo = false;
        }
        $scope.Address = "";
        $scope.ContactNumber = '';
    }
    $scope.Clear = function () {
        $scope.Address = "";
        $scope.ContactNumber = '';
        $scope.SelectedContactTypeID = '';
    }

    $scope.add = function () {
        if ($scope.ClientID != '' &&   $scope.SelectedContactTypeID != '' && ($scope.Address != '' || $scope.ContactNumber != '')) {
            var newinfor =
            {
                FK_ClientID: $scope.ClientID,
                FK_ContactTypeID: $scope.SelectedContactTypeID.ContactTypeID,
                ContactInformation: $scope.Address == '' ? $scope.ContactNumber : $scope.Address
            };
            $http.post('/Contacts/Add', newinfor).then(function (response) {
                $scope.Search($scope.ClientID);
                $scope.updateShow = false;
                $scope.addShow = true;
            });
        }
    }
    $scope.delete = function (contact) {
        var newinfor =
        {
            ClientContactID: contact.ClientContactID
        };
        $http.post('/Contacts/DeleteContact', newinfor).then(function (response) {
            $scope.Search(contact.FK_ClientID);
        });
    }
});
