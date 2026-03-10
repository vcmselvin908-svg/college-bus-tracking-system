from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models import LocationUpdate, BusInfo
from database import init_firebase, get_db
from datetime import datetime

app = FastAPI()

# CORS - Flutter app connect ஆக
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Firebase init
init_firebase()

# Driver location update பண்ணும்
@app.post("/update-location")
async def update_location(data: LocationUpdate):
    ref = get_db()
    ref.child(data.bus_id).set({
        "driver_number": data.driver_number,
        "latitude": data.latitude,
        "longitude": data.longitude,
        "timestamp": datetime.now().isoformat(),
        "is_active": True
    })
    return {"status": "success", "message": "Location updated"}

# Student — bus location get பண்ணும்
@app.get("/bus-location/{bus_id}")
async def get_bus_location(bus_id: str):
    ref = get_db()
    data = ref.child(bus_id).get()
    if data:
        return {"status": "success", "data": data}
    return {"status": "error", "message": "Bus not found"}

# எல்லா buses-உம் get பண்ணும்
@app.get("/all-buses")
async def get_all_buses():
    ref = get_db()
    data = ref.get()
    return {"status": "success", "data": data}

# Health check
@app.get("/")
async def root():
    return {"message": "Bus Tracking API Running!"}