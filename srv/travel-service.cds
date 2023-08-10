using { master.data.travel as my } from '../db/schema';


service TravelService @(path:'/processer', requires : 'authenticated-user') {

   @odata.draft.enabled
   entity Travel as projection on my.Travel actions  {
      action rejectTravel();
      action acceptTravel();
   }
   entity Authors as projection on my.Authors;
   entity Books as projection on my.Books;
   entity AuthorsAndBooks as projection on my.AuthorsAndBooks;
   entity BookedFlights as projection on my.BookedFlights;
   entity Booking as projection on my.Booking;

   annotate my.MasterData with @cds.autoexpose @readonly ;
   
}
type Percentage : Integer @assert.range: [1,100];
