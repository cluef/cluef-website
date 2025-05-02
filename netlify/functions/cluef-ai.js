const fetch = require('node-fetch');

exports.handler = async function(event) {
  const { prompt } = JSON.parse(event.body);

  const apiKey = process.env.OPENAI_API_KEY;

  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model: "gpt-3.5-turbo",
      messages: [
        { role: "system", content: "Du bist ein neutraler Cloud-Experte. Empfiehl dem Nutzer die passende Cloud-Lösung (SaaS, PaaS, IaaS) und stelle ggf. Rückfragen, falls Informationen fehlen. Gib konkrete Anbieter und Preisspannen an. Antworte auf Deutsch." },
        { role: "user", content: prompt }
      ],
      max_tokens: 400
    })
  });

  const data = await response.json();
  return {
    statusCode: 200,
    body: JSON.stringify({ reply: data.choices[0].message.content })
  };
};
