class BookingEntity{

  final int id;
  final bool isHouse;
  final String address;
  final DateTime entryDate;
  final DateTime exitDate;

  BookingEntity(this.id, this.isHouse, this.address, this.entryDate, this.exitDate);
}