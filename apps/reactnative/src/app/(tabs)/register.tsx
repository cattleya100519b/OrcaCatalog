import * as ImagePicker from "expo-image-picker";
import { useState } from "react";
import {
  Image,
  Pressable,
  SafeAreaView,
  StyleSheet,
  Text,
  View,
} from "react-native";

export default function RegisterScreen() {
  const [imageUri, setImageUri] = useState<string | null>(null);

  const pickImage = async () => {
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ["images"],
      allowsEditing: false,
      quality: 1,
    });

    if (!result.canceled) {
      setImageUri(result.assets[0].uri);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.eyebrow}>OrcaCatalog</Text>
        <Text style={styles.title}>写真を登録</Text>

        {!imageUri ? (
          <Pressable style={styles.fileInput} onPress={pickImage}>
            <Text style={styles.fileInputText}>写真を選択</Text>
          </Pressable>
        ) : (
          <>
            <View style={styles.preview}>
              <Image
                source={{ uri: imageUri }}
                style={styles.previewImage}
              />
            </View>

            <Pressable style={styles.changeButton} onPress={pickImage}>
              <Text>写真を変更</Text>
            </Pressable>
          </>
        )}

        <View style={styles.formActions}>
          <Pressable
            style={[
              styles.registerButton,
              !imageUri && styles.registerButtonDisabled,
            ]}
            disabled={!imageUri}
          >
            <Text style={styles.registerButtonText}>登録する</Text>
          </Pressable>
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f7f7f5",
  },
  content: {
    padding: 24,
  },
  eyebrow: {
    marginBottom: 8,
    fontSize: 14,
    fontWeight: "600",
    color: "#666",
  },
  title: {
    marginBottom: 32,
    fontSize: 32,
    fontWeight: "700",
    color: "#222",
  },
  fileInput: {
    padding: 40,
    borderWidth: 2,
    borderStyle: "dashed",
    borderColor: "#ccc",
    borderRadius: 12,
    alignItems: "center",
  },
  fileInputText: {
    fontSize: 16,
  },
  preview: {
    overflow: "hidden",
    borderRadius: 12,
    backgroundColor: "#eee",
  },
  previewImage: {
    width: "100%",
    aspectRatio: 4 / 3,
  },
  changeButton: {
    alignSelf: "flex-start",
    marginTop: 16,
    paddingVertical: 10,
    paddingHorizontal: 16,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 8,
    backgroundColor: "#fff",
  },
  formActions: {
    alignItems: "flex-end",
    marginTop: 24,
  },
  registerButton: {
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 8,
    backgroundColor: "#222",
  },
  registerButtonDisabled: {
    opacity: 0.4,
  },
  registerButtonText: {
    color: "#fff",
    fontSize: 16,
  },
});