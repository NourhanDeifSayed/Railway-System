// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
const userMessage = [
    
    ["hi", "hey", "hello"],
    ["sure", "yes", "no"],
    ["train schedule", "ticket", "complaints", "help", "complaint","exams"],
    ["are you genius", "are you intelligent", "are you helpful"],
    ["i dislike you", "i don't like you"],
    ["how are you", "how is life", "how are things", "how are you doing"],
    ["what is ticket price", "price"],
    ["what's going on", "what's up"],
    ["how old are you"],
    ["who are you", "are you human", "are you a bot"],
    ["who created you", "who made you", "who is your creator"],
    ["what's your name", "what do you call yourself"],
    ["who is eng sara","sara","eng sara"],
    ["happy", "good", "fun", "wonderful", "fantastic", "cool", "very good"],
    ["bad", "bored", "tired"],
    ["help me", "tell me a story", "tell me a joke"],
    ["ah", "ok", "okay", "nice", "welcome"],
    ["thanks", "thank you"],
    ["what should I eat today"],
    ["bro"],
    ["what", "why", "how", "where", "when"],
    ["corona", "COVID-19", "coronavirus"],
    ["you're funny"],
    ["i don't know"],
    ["tired"],
    
];

const botReply = [
  
    ["Hello!", "Hi!", "Hey!", "Hi there!"],
    ["Okay"],
    [
        "5 Jan 2024 Cairo-> Alexandria 10:30 Am.",
        "To book a ticket, please visit our ticketing platform.",

    ],
    ["Yes, I am!", "I try to be helpful!", "I'm here to assist."],
    ["I'm sorry about that. But I'm here to help you."],
    [
        "I'm doing well, thank you. How about you?",
        "Pretty well, how about you?",
        "Fantastic, how are you?"
    ],
    [
        "The 10 killo M in standard ticket cost 20LE ","The 10 killo M in Premium ticket cost 40LE ",
        "If you are a sudent you can get 30% off "
    ],
    ["Nothing much", "Just here to assist you", "I'm here to help"],
    ["I'm ageless."],
    ["I am just a bot", "I am a bot. What are you?"],
    ["Sabitha Kuppusamy"],
    ["I am nameless", "I don't have a name"],
    ["The best TA <3", "very helpful"],
    ["Glad to hear it!"],
    ["Why?", "Why? You shouldn't!", "Try watching TV", "Chat with me."],
    ["Tell me a story", "Tell me a joke", "Tell me about yourself"],
    ["You're welcome"],
    ["Briyani", "Burger", "Sushi", "Pizza"],
    ["Dude!"],
    ["Yes?"],
    ["Please stay home"],
    ["Glad to hear it!"],
    ["Say something interesting"],
    ["Sorry for that. Let's chat!"],
    ["You are ZEWAILIAN dude! we do not say that here "]

];

const alternative = [
    "Same here!",
    "That's cool! Go on...",
    "Dude...",
    "Ask something else...",
    "Hey, I'm listening..."
];


const synth = window.speechSynthesis;

function voiceControl(string) {
    let u = new SpeechSynthesisUtterance(string);
    u.text = string;
    u.lang = "en-aus";
    u.volume = 1;
    u.rate = 1;
    u.pitch = 1;
    synth.speak(u);
}

function sendMessage() {
    const inputField = document.getElementById("input");
    let input = inputField.value.trim();
    input != "" && output(input);
    inputField.value = "";
}
document.addEventListener("DOMContentLoaded", () => {
    const inputField = document.getElementById("input");
    inputField.addEventListener("keydown", function (e) {
        if (e.code === "Enter") {
            let input = inputField.value.trim();
            input != "" && output(input);
            inputField.value = "";
        }
    });
});

function output(input) {
    let product;

    let text = input.toLowerCase().replace(/[^\w\s\d]/gi, "");

    text = text
        .replace(/[\W_]/g, " ")
        .replace(/ a /g, " ")
        .replace(/i feel /g, "")
        .replace(/whats/g, "what is")
        .replace(/please /g, "")
        .replace(/ please/g, "")
        .trim();

    let comparedText = compare(userMessage, botReply, text);

    product = comparedText
        ? comparedText
        : alternative[Math.floor(Math.random() * alternative.length)];
    addChat(input, product);
}

function compare(triggerArray, replyArray, string) {
    let item;
    for (let x = 0; x < triggerArray.length; x++) {
        for (let y = 0; y < replyArray.length; y++) {
            if (triggerArray[x][y] == string) {
                items = replyArray[x];
                item = items[Math.floor(Math.random() * items.length)];
            }
        }
    }
    //containMessageCheck(string);
    if (item) return item;
    else return containMessageCheck(string);
}

function containMessageCheck(string) {
    let expectedReply = [
        [
            "Good Bye, dude",
            "Bye, See you!",
            "Dude, Bye. Take care of your health in this situation."
        ],
        ["Good Night, dude", "Have a sound sleep", "Sweet dreams"],
        ["Have a pleasant evening!", "Good evening too", "Evening!"],
        ["Good morning, Have a great day!", "Morning, dude!"],
        ["Good Afternoon", "Noon, dude!", "Afternoon, dude!"]
    ];
    let expectedMessage = [
        ["bye", "tc", "take care"],
        ["night", "good night"],
        ["evening", "good evening"],
        ["morning", "good morning"],
        ["noon"]
    ];
    let item;
    for (let x = 0; x < expectedMessage.length; x++) {
        if (expectedMessage[x].includes(string)) {
            items = expectedReply[x];
            item = items[Math.floor(Math.random() * items.length)];
        }
    }
    return item;
}
function addChat(input, product) {
    const mainDiv = document.getElementById("message-section");
    let userDiv = document.createElement("div");
    userDiv.id = "user";
    userDiv.classList.add("message");
    userDiv.innerHTML = `<span id="user-response">${input}</span>`;
    mainDiv.appendChild(userDiv);

    let botDiv = document.createElement("div");
    botDiv.id = "bot";
    botDiv.classList.add("message");
    botDiv.innerHTML = `<span id="bot-response">${product}</span>`;
    mainDiv.appendChild(botDiv);
    var scroll = document.getElementById("message-section");
    scroll.scrollTop = scroll.scrollHeight;
    voiceControl(product);
}
