using {
    Currency,
    Country,
    custom.managed,
    sap
} from './common';

namespace master.data.travel;

aspect MasterData {}

entity Airline : MasterData {
    key AirlineID     : String(3);
        Name          : String(40);
        CurrencyCode  : Currency;
        AirlinePicURL : String @UI: {IsImageURL: true};
}

entity Airport : MasterData {
    key AirportID   : String(3);
        Name        : String(40);
        City        : String(40);
        CountryCode : Country;
}

entity Suplement : managed, MasterData {
    key SupplementID : String(10);
        Price        : Decimal(16, 3);
        Type         : Association to SuplementType;
        Description  : localized String(1024);
        CurrencyCode : Currency;
}

entity Flight : MasterData {
    key AirlineID     : String(3);
    key FlightDate    : Date;
    key ConnectionID  : String(4);
        Price         : Decimal(16, 3);
        CurrencyCode  : Currency;
        PlaneType     : String(10);
        MaximumSeats  : Integer;
        OccupiedSeats : Integer;

        to_Airline    : Association to Airline
                            on to_Airline.AirlineID = AirlineID;
        to_Connection : Association to FlightConnection
                            on  to_Connection.AirlineID    = AirlineID
                            and to_Connection.ConnectionID = ConnectionID;
}


entity FlightConnection : MasterData {

    key ConnectionID       : String(4);
    key AirlineID          : String(3);
        DepartureAirport   : Association to Airport;
        DestinationAirport : Association to Airport;
        DepartureTime      : Time;
        ArrivalTime        : Time;
        Distance           : Integer;
        DistanceUnit       : String(3);

        to_Airline         : Association to Airline
                                 on to_Airline.AirlineID = AirlineID;
}

entity Passenger : managed, MasterData {
    key CustomerID   : String(6);
        FirstName    : String(40);
        LastName     : String(40);
        Title        : String(10);
        Street       : String(60);
        PostalCode   : String(10);
        City         : String(40);
        CountryCode  : Country;
        PhoneNumber  : String(30);
        EmailAddress : String(256);
}

entity TravelAgency : MasterData {
    key AgencyID : String(6);
    Name : String(80);
    Street : String(60);
    PostalCode : String(10);
    City : String(40);
    CountryCode : Country;
    PhoneNumber : String(30);
    EmailAddress: String(256);
    WebAddress : String(256);
}

entity SuplementType : sap.common.CodeList {
    key code : String enum {
            Beverage = 'BV';
            Meal     = 'ML';
            Luggage  = 'LU';
            Extra    = 'Ex';
        }
}
