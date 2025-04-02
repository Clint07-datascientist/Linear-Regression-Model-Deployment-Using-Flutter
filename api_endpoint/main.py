from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import joblib
import os
from dotenv import load_dotenv
import numpy as np
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
from pathlib import Path
import sklearn
import sys

# Load environment variables from .env
load_dotenv()

# Print version information for debugging
print(f"Python version: {sys.version}")
print(f"NumPy version: {np.__version__}")
print(f"Pandas version: {pd.__version__}")
print(f"Scikit-learn version: {sklearn.__version__}")

# Get the environment variables
model_path = os.getenv("MODEL_PATH", "ml_model/best_model.pkl")

# Initialize FastAPI app
app = FastAPI(
    title="Crop Yield Prediction API",
    description="API for predicting crop yields based on various parameters",
    version="1.0.0"
)

# Add middleware for CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load the model with error handling
try:
    print(f"Attempting to load model from: {model_path}")
    print(f"Current working directory: {os.getcwd()}")
    print(f"Directory contents: {os.listdir('.')}")
    if os.path.exists('ml_model'):
        print(f"ml_model directory contents: {os.listdir('ml_model')}")
    else:
        print("ml_model directory not found!")
    
    # Try to load numpy first to ensure it's properly initialized
    import numpy as np
    print(f"NumPy loaded successfully: {np.__version__}")
    
    # Try to load the model with a different method
    try:
        with open(model_path, 'rb') as f:
            model = joblib.load(f)
    except Exception as e:
        print(f"Error with direct joblib.load: {str(e)}")
        # Try alternative loading method
        import pickle
        with open(model_path, 'rb') as f:
            model = pickle.load(f)
    
    print(f"Model loaded successfully from {model_path}")
    # Print model information for debugging
    print(f"Model type: {type(model)}")
    print(f"Model features: {getattr(model, 'feature_names_in_', 'Not available')}")
    # Print pipeline steps for debugging
    if hasattr(model, 'named_steps'):
        print("Pipeline steps:", model.named_steps)
except Exception as e:
    print(f"Error loading model: {str(e)}")
    print(f"Error type: {type(e)}")
    import traceback
    print(f"Full traceback: {traceback.format_exc()}")
    raise RuntimeError(f"Failed to load model from {model_path}")

# Define input data schema with Pydantic
class PredictionInput(BaseModel):
    country: str = Field(..., description="Country name or code")
    province: str = Field(..., description="Province name or code")
    product: str = Field(..., description="Product name or code")
    season_name: str = Field(..., description="Season name")
    time_to_harvest: int = Field(..., ge=0, description="Number of days between planting and harvest")
    area: float = Field(..., ge=0, description="Cultivated area in hectares")
    production: float = Field(..., ge=0, description="Production volume in metric tons")

    class Config:
        json_schema_extra = {
            "example": {
                "country": "0",
                "province": "0",
                "product": "0",
                "season_name": "0",
                "time_to_harvest": 120,
                "area": 100.0,
                "production": 500.0
            }
        }

@app.get("/")
def root():
    return {
        "message": "Welcome to the Crop Yield Prediction API",
        "endpoints": {
            "predict": "/predict - POST endpoint for making predictions"
        }
    }

@app.post("/predict")
async def predict(input_data: PredictionInput):
    try:
        # Create a DataFrame with the input data
        input_df = pd.DataFrame({
            'country': [input_data.country],
            'province': [input_data.province],
            'product': [input_data.product],
            'season_name': [input_data.season_name],
            'time_to_harvest': [input_data.time_to_harvest],
            'area': [input_data.area],
            'production': [input_data.production]
        })

        # Ensure the DataFrame has the correct column order as expected by the model
        expected_columns = ['country', 'province', 'product', 'season_name', 
                          'time_to_harvest', 'area', 'production']
        input_df = input_df[expected_columns]

        # Print input data for debugging
        print("Input DataFrame:\n", input_df)
        print("Input DataFrame types:\n", input_df.dtypes)
        print("Input DataFrame columns:\n", input_df.columns.tolist())

        # Make the prediction using the DataFrame
        predicted_yield = model.predict(input_df)

        return {
            "status": "success",
            "predicted_yield": float(predicted_yield[0]),
            "input_data": {
                "country": input_data.country,
                "province": input_data.province,
                "product": input_data.product,
                "season_name": input_data.season_name,
                "time_to_harvest": int(input_data.time_to_harvest),
                "area": float(input_data.area),
                "production": float(input_data.production)
            }
        }

    except Exception as e:
        print(f"Error during prediction: {str(e)}")
        print(f"Error type: {type(e)}")
        import traceback
        print(f"Traceback: {traceback.format_exc()}")
        raise HTTPException(
            status_code=500,
            detail=f"Error making prediction: {str(e)}"
        )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        app,
        host=os.getenv("HOST", "0.0.0.0"),
        port=int(os.getenv("PORT", 8000)),
        reload=True  # Enable auto-reload for development
    )
