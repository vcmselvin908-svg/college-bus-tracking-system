from pydantic import BaseModel

class LocationUpdate(BaseModel):
    bus_id: str
    driver_number: str
    latitude: float
    longitude: float
    timestamp: str

class BusInfo(BaseModel):
    bus_id: str
    driver_number: str
    route_name: str