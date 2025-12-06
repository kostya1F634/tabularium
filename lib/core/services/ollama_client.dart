import 'dart:convert';
import 'package:http/http.dart' as http;

/// Client for Ollama API
class OllamaClient {
  final String baseUrl;
  final String model;

  OllamaClient({required this.baseUrl, required this.model});

  /// Generate completion from Ollama
  /// Returns the generated text
  Future<String> generate({
    required String prompt,
    double temperature = 0.7,
  }) async {
    final url = Uri.parse('$baseUrl/api/generate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': model,
          'prompt': prompt,
          'stream': false,
          'options': {'temperature': temperature},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] as String? ?? '';
      } else {
        throw Exception(
          'Ollama API error: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to Ollama: $e');
    }
  }

  /// Test connection to Ollama
  Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$baseUrl/api/tags');
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Parse JSON from AI response
  /// Extracts JSON from markdown code blocks or raw JSON
  Map<String, dynamic> parseJsonResponse(String response) {
    // Remove markdown code blocks if present
    String cleaned = response.trim();

    // Try to find JSON in code blocks
    final codeBlockRegex = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```');
    final match = codeBlockRegex.firstMatch(cleaned);
    if (match != null) {
      cleaned = match.group(1)!.trim();
    }

    // Try to extract JSON object
    final jsonRegex = RegExp(r'\{[\s\S]*\}');
    final jsonMatch = jsonRegex.firstMatch(cleaned);
    if (jsonMatch != null) {
      cleaned = jsonMatch.group(0)!;
    }

    try {
      return jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (e) {
      throw Exception(
        'Failed to parse JSON from AI response: $e\nResponse: $response',
      );
    }
  }
}
