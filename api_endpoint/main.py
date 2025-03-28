from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import joblib
import os
from dotenv import load_dotenv
import numpy as np
from fastapi.middleware.cors import CORSMiddleware

# Load environment variables from .env
load_dotenv()

# Get the environment variables
model_path = os.getenv("MODEL_PATH", "../ml_model/best_model.pkl")  # Default path if not set

# Initialize FastAPI app
app = FastAPI(title="Crop Yield Prediction API")

# Add middleware for CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load the model
model = joblib.load(model_path)

# Define input data schema with Pydantic
class PredictionInput(BaseModel):
    country: int = Field(..., ge=0, description="Encoded value for country")
    province: int = Field(..., ge=0, description="Encoded value for province")
    product: int = Field(..., ge=0, description="Encoded value for product")
    season_name: int = Field(..., ge=0, description="Encoded value for season")
    time_to_harvest: int = Field(..., ge=0, description="Number of days between planting and harvest")
    area: float = Field(..., ge=0, description="Cultivated area in hectares")
    production: float = Field(..., ge=0, description="Production volume in metric tons")

@app.get("/")
def root():
    return {"message": "Welcome to the Crop Yield Prediction API. Use /predict to make predictions."}


@app.post("/predict")
def predict(input_data: PredictionInput):
    # Convert input data to numpy array for prediction
    data_array = np.array([[input_data.country, input_data.province, input_data.product,
                            input_data.season_name, input_data.time_to_harvest,
                            input_data.area, input_data.production]])

    # Make the prediction
    try:
        predicted_yield = model.predict(data_array)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error making prediction: {e}")

    # Return the prediction
    return {"predicted_yield": predicted_yield[0]}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host=os.getenv("HOST", "0.0.0.0"), port=int(os.getenv("PORT", 8000)))
