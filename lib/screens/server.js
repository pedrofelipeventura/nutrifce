import express from "express";
import bodyParser from "body-parser";
import fetch from "node-fetch";
import multer from "multer";
import fs from "fs";

const app = express();
app.use(bodyParser.json());
const upload = multer({ dest: "uploads/" });

// substitua pela sua chave Gemini
const GEMINI_API_KEY = "SUA_CHAVE_AQUI";
const GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

app.post("/chat", upload.single("image"), async (req, res) => {
  try {
    const text = req.body.text;
    let imagePart = null;

    if (req.file) {
      const imageBase64 = fs.readFileSync(req.file.path, { encoding: "base64" });
      imagePart = {
        inlineData: {
          mimeType: req.file.mimetype,
          data: imageBase64,
        },
      };
      fs.unlinkSync(req.file.path);
    }

    const body = {
      contents: [
        {
          parts: [
            text ? { text } : null,
            imagePart,
          ].where((p) => p != null),
        },
      ],
    };

    const response = await fetch(`${GEMINI_URL}?key=${GEMINI_API_KEY}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });

    const data = await response.json();
    const reply = data?.candidates?.[0]?.content?.parts?.[0]?.text ?? "Erro ao processar resposta.";

    res.json({ reply });
  } catch (err) {
    console.error(err);
    res.status(500).json({ reply: "Erro interno no servidor." });
  }
});

app.listen(3000, () => console.log("Servidor rodando em http://localhost:3000"));
