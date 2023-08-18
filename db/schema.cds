using {  Currency, custom.managed, sap.common.CodeList } from './common';

using { 
    master.data.travel.Airline,
    master.data.travel.Passenger,
    master.data.travel.TravelAgency,
    master.data.travel.Supplement,
    master.data.travel.Flight
 } from './master-data';


namespace master.data.travel;


entity Travel : managed {
    key TravelUUID : String(30);
    TravelID : Integer @readonly default 0 @Common.Text: Description;
    BeginDate: Date;
    EndDate :  Date;
    BookingFee : Decimal(16, 3);
    TotalPrice : Decimal(16, 3) @readonly;
    CurrencyCode : Currency;
    Description : String(1024);
    TravelStatus : Association to TravelStatus @readonly @Common.ValueListWithFixedValues;
    GoGreen : Boolean default false;
    GreenFee : Decimal(16, 3) @Core.Computed @readonly;
    TreesPlanted : Integer @Core.Computed @readonly;
    to_Agency : Association to TravelAgency;
    to_Customer : Association to Passenger;
    to_Booking  : Composition of many Booking on to_Booking.to_Travel = $self; 
}

entity Booking : managed {
    key BookingUUID : String(30);
    BookingID : Integer @Core.Computed;
    BookingDate : Date;
    ConnectionID : String(4);
    FlightDate : Date;
    FlightPrice : Decimal(16, 3);
    CurrencyCode : Currency;
    BookingStatus : Association to BookingStatus;
    to_BookSupplement : Composition of  many BookingSupplement on to_BookSupplement.to_Booking = $self;
    to_Carrier : Association to Airline;
    to_Customer : Association to  Passenger;
    to_Travel  : Association to  Travel;
    to_Flight : Association to Flight on  to_Flight.AirlineID = to_Carrier.AirlineID
                                      and to_Flight.FlightDate = FlightDate
                                      and to_Flight.ConnectionID = ConnectionID;

}

entity BookingSupplement : managed {
    key BookSupplUUID : UUID;
    BookingSupplementID : Integer @Core.Computed;
    Price : Decimal(16, 3);
    CurrencyCode : Currency;
    to_Booking : Association to Booking;
    to_Travel  : Association to Travel;
    to_Supplement : Association to Supplement;
}

entity BookingStatus : CodeList {
    key code : String enum {
        New  = 'N';
        Booked = 'B';
        Canceled = 'X';

    }
}
entity TravelStatus : CodeList {
    key code : String enum {
        Open = 'O';
        Accepted = 'A';
        Canceled = 'X';
    } default '0';
    criticality : Integer;
    fieldControl : Integer @odata.Type:'Edm.Byte';
    createDeleteHidden : Boolean;
}


extend Booking with {
    criticality : Integer default 0 @Core.Computed @UI.Hidden;
    BookedFlights : Integer @Core.Computed;
    EligibleForPrime : Integer @Core.Computed @UI.Hidden;
}

extend Airline with {
    VIPCustomerBookings : Integer;
}


define view BookedFlights as select from Booking left join Airline on Airline.AirlineID = Booking.to_Carrier.AirlineID {
    key to_Customer.CustomerID as to_Customer_CustomerID,
    key AirlineID, to_Customer.LastName as LastName, 
    BookingUUID,
    Name,
    VIPCustomerBookings,
    to_Travel
};

extend Travel with {
    to_BookedFlights : Association to many  BookedFlights on to_BookedFlights.to_Travel = $self @readonly;
}


entity Authors {
    key ID : String(10);
    AuthorName : String(50);
    Age : String(3);
    Address : String(50);
    to_Books : Association to many Books on to_Books.to_Authors = $self;
}

entity  Books {
    key ID : String(10);
    Name : String(10);
    PageNumber : String(10);
    Category  : String(50);
    to_Authors : Association to Authors;
}

define view AuthorsAndBooks as select from  Books left join Authors on Authors.ID = Books.to_Authors.ID {
    key Books.ID,
    Name,
    PageNumber,
    AuthorName,
    to_Authors
};

