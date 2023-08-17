using TravelService as service from '../../srv/travel-service';

annotate service.Travel with @(
    UI.SelectionFields : [
        to_Agency_AgencyID,
        to_Customer_CustomerID,
        TravelStatus_code,
    ],
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : TravelID,
            Label : 'Travel Id'
        },
        {
            $Type : 'UI.DataField',
            Value : TravelStatus_code,
            Criticality: TravelStatus.criticality,
            Label : 'Travel Status'
        },
        {
            $Type : 'UI.DataField',
            Value : BeginDate,
            Label : 'Begin Date'
        },
        {
            $Type : 'UI.DataField',
            Value : EndDate,
            Label : 'End Date'
        },
        {
            $Type : 'UI.DataField',
            Value : to_Agency_AgencyID,
            Label : 'Agency Id'
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
            Label : 'Customer Id'
        },
        {
            $Type : 'UI.DataField',
            Value : TotalPrice,
            Label : 'Total Price'
        },
        {
            $Type: 'UI.DataFieldForAction',
            Label: '{i18n>AcceptTravel}',
            Action: 'TravelService.acceptTravel'
        },
        {
            $Type: 'UI.DataFieldForAction',
            Label: '{i18n>RejectTravel}',
            Action: 'TravelService.rejectTravel'
        }

    ]
);
annotate service.Travel with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>Travel}',
        TypeNamePlural : '{i18n>Travels}',
        Title : {
            $Type : 'UI.DataField',
            Value : TravelID,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    }
);
annotate service.Travel with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.acceptTravel',
            Label : 'Accept Travel',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.rejectTravel',
            Label : 'Reject Travel',
        },
    ]
);
annotate service.Travel with @(
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Travel}',
            ID : 'i18nTravel',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Travel',
                    ID : 'Travel',
                    Target : '@UI.FieldGroup#Travel',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Prices}',
                    ID : 'i18nPrices',
                    Target : '@UI.FieldGroup#i18nPrices',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Dates}',
                    ID : 'i18nDates',
                    Target : '@UI.FieldGroup#i18nDates',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Sustainabilty}',
                    ID : 'i18nSustainabilty',
                    Target : '@UI.FieldGroup#i18nSustainabilty',
                },],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>MyItinearay}',
            ID : 'i18nMyItinearay',
            Target : 'to_Booking/@UI.LineItem#i18nMyItinearay',
        },
    ]
);
annotate service.Travel with @(
    UI.FieldGroup #Travel : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : TravelID,
                Label : 'TravelID',
            },{
                $Type : 'UI.DataField',
                Value : to_Agency_AgencyID,
                Label : 'to_Agency_AgencyID',
            },{
                $Type : 'UI.DataField',
                Value : to_Customer_CustomerID,
                Label : 'to_Customer_CustomerID',
            },{
                $Type : 'UI.DataField',
                Value : TravelStatus_code,
                Label : 'TravelStatus_code',
            },],
    }
);
annotate service.Travel with @(
    UI.FieldGroup #i18nPrices : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BookingFee,
                Label : 'BookingFee',
            },{
                $Type : 'UI.DataField',
                Value : TotalPrice,
                Label : 'TotalPrice',
            },],
    }
);
annotate service.Travel with @(
    UI.FieldGroup #i18nDates : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BeginDate,
                Label : 'BeginDate',
            },{
                $Type : 'UI.DataField',
                Value : EndDate,
                Label : 'EndDate',
            },],
    }
);
annotate service.Travel with @(
    UI.FieldGroup #i18nSustainabilty : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GoGreen,
                Label : 'GoGreen',
            },{
                $Type : 'UI.DataField',
                Value : GreenFee,
                Label : 'GreenFee',
            },{
                $Type : 'UI.DataField',
                Value : TreePlanted,
                Label : 'TreePlanted',
            },],
    }
);
annotate service.Booking with @(
    UI.LineItem #i18nMyItinearay : [
        {
            $Type : 'UI.DataField',
            Value : to_Carrier.AirlinePicURL,
            Label : 'AirlinePicURL',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#BookedFlights',
            Label : 'BookedFlights',
        },
        {
            $Type : 'UI.DataField',
            Value : BookingID,
            Label : 'BookingID',
        },{
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
            Label : 'to_Customer_CustomerID',
        },{
            $Type : 'UI.DataField',
            Value : to_Carrier_AirlineID,
            Label : 'to_Carrier_AirlineID',
        },{
            $Type : 'UI.DataField',
            Value : ConnectionID,
            Label : 'ConnectionID',
        },{
            $Type : 'UI.DataField',
            Value : FlightDate,
            Label : 'FlightDate',
        },{
            $Type : 'UI.DataField',
            Value : FlightPrice,
            Label : 'FlightPrice',
        },{
            $Type : 'UI.DataField',
            Value : BookingStatus_code,
            Label : 'BookingStatus_code',
        },
    ]
);
annotate service.Booking with @(
    UI.DataPoint #BookedFlights : {
        Value : BookedFlights,
        TargetValue : to_Carrier.VIPCustomerBookings,
        Criticality : EligibleForPrime,
    },
    UI.Chart #BookedFlights : {
        ChartType : #Donut,
        Measures : [
            BookedFlights,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#BookedFlights',
                Role : #Axis1,
                Measure : BookedFlights,
            },
        ],
    }
);
