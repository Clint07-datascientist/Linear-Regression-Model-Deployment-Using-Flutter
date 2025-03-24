import { useState } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TextInput,
  TouchableOpacity,
  ScrollView,
  ActivityIndicator,
  Alert,
  Image,
  Platform,
} from 'react-native';
import { z } from 'zod';
import { Brain } from 'lucide-react-native';

// Validation schema
const predictionSchema = z.object({
  country: z.string().min(1, 'Country is required'),
  province: z.string().min(1, 'Province is required'),
  product: z.string().min(1, 'Product is required'),
  season_name: z.string().min(1, 'Season is required'),
  time_to_harvest: z.number().min(0, 'Time to harvest must be positive'),
  area: z.number().min(0, 'Area must be positive'),
  production: z.number().min(0, 'Production must be positive'),
});

type PredictionInput = z.infer<typeof predictionSchema>;

const API_URL = 'https://linear-regression-model-deployment-using-0l6f.onrender.com';
const SEASONS = ['Spring', 'Summer', 'Fall', 'Winter'];
const PRODUCTS = ['Rice', 'Wheat', 'Corn', 'Soybeans', 'Potatoes'];

export default function PredictScreen() {
  const [loading, setLoading] = useState(false);
  const [prediction, setPrediction] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [formData, setFormData] = useState<PredictionInput>({
    country: '',
    province: '',
    product: '',
    season_name: '',
    time_to_harvest: 0,
    area: 0,
    production: 0,
  });

  const handleSubmit = async () => {
    try {
      setError(null);
      setPrediction(null);
      
      // Validate the form data
      const validatedData = predictionSchema.parse(formData);
      setLoading(true);

      console.log('Sending request to:', `${API_URL}/predict`);
      console.log('Request data:', JSON.stringify(validatedData, null, 2));
      
      const response = await fetch(`${API_URL}/predict`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify(validatedData),
      });

      const responseData = await response.json();
      console.log('API Response:', JSON.stringify(responseData, null, 2));

      if (!response.ok) {
        throw new Error(
          responseData.detail || 
          (typeof responseData === 'object' ? JSON.stringify(responseData) : 'Failed to get prediction')
        );
      }

      setPrediction(responseData.prediction);
    } catch (error) {
      console.error('Error details:', error);
      
      if (error instanceof z.ZodError) {
        setError(error.errors[0].message);
      } else if (error instanceof Error) {
        setError(error.message);
      } else {
        setError('An unexpected error occurred');
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.main}>
        <View style={styles.header}>
          <Image
            source={{ uri: 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?q=80&w=2940&auto=format&fit=crop' }}
            style={styles.headerImage}
          />
          <View style={styles.headerOverlay}>
            <Brain size={48} color="#fff" />
            <Text style={styles.title}>Crop Yield Prediction</Text>
            <Text style={styles.subtitle}>
              Use machine learning to predict your crop yield
            </Text>
          </View>
        </View>
        
        <View style={styles.form}>
          {error && (
            <View style={styles.errorContainer}>
              <Text style={styles.errorText}>{error}</Text>
            </View>
          )}

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Country</Text>
            <TextInput
              style={styles.input}
              value={formData.country}
              onChangeText={(text) => setFormData({ ...formData, country: text })}
              placeholder="Enter country"
              placeholderTextColor="#666"
            />
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Province</Text>
            <TextInput
              style={styles.input}
              value={formData.province}
              onChangeText={(text) => setFormData({ ...formData, province: text })}
              placeholder="Enter province"
              placeholderTextColor="#666"
            />
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Product</Text>
            <View style={styles.chipContainer}>
              {PRODUCTS.map((product) => (
                <TouchableOpacity
                  key={product}
                  style={[
                    styles.chip,
                    formData.product === product && styles.chipSelected,
                  ]}
                  onPress={() => setFormData({ ...formData, product })}
                >
                  <Text
                    style={[
                      styles.chipText,
                      formData.product === product && styles.chipTextSelected,
                    ]}
                  >
                    {product}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Season</Text>
            <View style={styles.chipContainer}>
              {SEASONS.map((season) => (
                <TouchableOpacity
                  key={season}
                  style={[
                    styles.chip,
                    formData.season_name === season && styles.chipSelected,
                  ]}
                  onPress={() => setFormData({ ...formData, season_name: season })}
                >
                  <Text
                    style={[
                      styles.chipText,
                      formData.season_name === season && styles.chipTextSelected,
                    ]}
                  >
                    {season}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Time to Harvest (days)</Text>
            <TextInput
              style={styles.input}
              value={formData.time_to_harvest.toString()}
              onChangeText={(text) => 
                setFormData({ ...formData, time_to_harvest: Number(text) || 0 })
              }
              keyboardType="numeric"
              placeholder="Enter time to harvest"
              placeholderTextColor="#666"
            />
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Area (hectares)</Text>
            <TextInput
              style={styles.input}
              value={formData.area.toString()}
              onChangeText={(text) => 
                setFormData({ ...formData, area: Number(text) || 0 })
              }
              keyboardType="numeric"
              placeholder="Enter area"
              placeholderTextColor="#666"
            />
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.label}>Production (tons)</Text>
            <TextInput
              style={styles.input}
              value={formData.production.toString()}
              onChangeText={(text) => 
                setFormData({ ...formData, production: Number(text) || 0 })
              }
              keyboardType="numeric"
              placeholder="Enter production"
              placeholderTextColor="#666"
            />
          </View>

          <TouchableOpacity
            style={styles.button}
            onPress={handleSubmit}
            disabled={loading}
          >
            {loading ? (
              <ActivityIndicator color="#fff" />
            ) : (
              <Text style={styles.buttonText}>Predict Yield</Text>
            )}
          </TouchableOpacity>

          {prediction !== null && (
            <View style={styles.result}>
              <Text style={styles.resultTitle}>Predicted Yield</Text>
              <Text style={styles.resultValue}>{prediction.toFixed(2)} tons</Text>
              <Text style={styles.resultNote}>
                Based on historical data and current conditions
              </Text>
            </View>
          )}
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  main: {
    flex: 1,
    maxWidth: Platform.select({ web: 960, default: '100%' }),
    marginHorizontal: 'auto',
  },
  header: {
    height: 200,
    position: 'relative',
  },
  headerImage: {
    width: '100%',
    height: '100%',
  },
  headerOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#fff',
    textAlign: 'center',
    marginTop: 12,
  },
  subtitle: {
    fontSize: 16,
    color: '#fff',
    textAlign: 'center',
    marginTop: 8,
  },
  form: {
    padding: 20,
    gap: 16,
  },
  errorContainer: {
    backgroundColor: '#fee2e2',
    padding: 12,
    borderRadius: 8,
    marginBottom: 16,
  },
  errorText: {
    color: '#dc2626',
    fontSize: 14,
  },
  inputGroup: {
    marginBottom: 16,
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 8,
    color: '#38434D',
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  chipContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  chip: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: '#f3f4f6',
  },
  chipSelected: {
    backgroundColor: '#007AFF',
  },
  chipText: {
    fontSize: 14,
    color: '#374151',
  },
  chipTextSelected: {
    color: '#fff',
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 16,
    borderRadius: 8,
    marginTop: 20,
  },
  buttonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  result: {
    marginTop: 24,
    padding: 20,
    backgroundColor: '#f0f9ff',
    borderRadius: 12,
    alignItems: 'center',
  },
  resultTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#38434D',
    marginBottom: 8,
  },
  resultValue: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  resultNote: {
    fontSize: 14,
    color: '#6b7280',
    marginTop: 8,
    textAlign: 'center',
  },
});