import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeteksiResult extends StatelessWidget {
  final bool isPositive;
  final double confidence;
  final double percentage;
  final String prediction;
  final String confidenceLevel;
  final int totalFrames;
  final int bellsPalsyFrames;

  const DeteksiResult({
    Key? key,
    required this.isPositive,
    this.confidence = 0.0,
    this.percentage = 0.0,
    this.prediction = 'Unknown',
    this.confidenceLevel = 'Unknown',
    this.totalFrames = 0,
    this.bellsPalsyFrames = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Handle Bar
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          
          // Status Icon
          Icon(
            isPositive ? Icons.warning_rounded : Icons.check_circle_rounded,
            size: 80,
            color: isPositive ? Colors.red : Colors.green,
          ),
          const SizedBox(height: 16),
          
          // Title
          Text(
            prediction,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          
          // Subtitle
          Text(
            isPositive 
                ? 'Indikasi Bell\'s Palsy terdeteksi'
                : 'Tidak ada indikasi Bell\'s Palsy',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Confidence Score
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Text(
                  'Tingkat Kepercayaan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isPositive 
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    confidenceLevel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isPositive ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Analysis Details
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Analisis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Total Frame Dianalisis', '$totalFrames'),
                const SizedBox(height: 8),
                _buildDetailRow('Frame dengan Indikasi', '$bellsPalsyFrames'),
                const SizedBox(height: 8),
                _buildDetailRow('Frame Normal', '${totalFrames - bellsPalsyFrames}'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Recommendation
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isPositive 
                  ? Colors.red.withOpacity(0.05)
                  : Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isPositive 
                    ? Colors.red.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isPositive ? Icons.warning : Icons.info,
                      color: isPositive ? Colors.red : Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Rekomendasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? Colors.red[700] : Colors.green[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  isPositive
                      ? 'Disarankan untuk berkonsultasi dengan dokter spesialis neurologi untuk pemeriksaan lebih lanjut. Hasil ini hanya untuk skrining awal, bukan diagnosis medis.'
                      : 'Hasil menunjukkan kondisi normal. Tetap jaga kesehatan wajah dan saraf. Konsultasi dokter jika ada keluhan.',
                  style: TextStyle(
                    fontSize: 14,
                    color: isPositive ? Colors.red[700] : Colors.green[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    // Reset untuk tes ulang
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4285F4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tes Ulang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
