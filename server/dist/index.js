"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const node_http_1 = require("node:http");
require("dotenv/config");
require("express-async-errors");
const socket_io_1 = require("socket.io");
const variables_1 = require("./utils/variables");
const errors_1 = require("./middlewares/errors");
const twod_1 = __importDefault(require("./routers/twod"));
const app = (0, express_1.default)();
const server = (0, node_http_1.createServer)(app);
const io = new socket_io_1.Server(server);
exports.default = io;
require("./utils/schedule");
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: false }));
app.use(express_1.default.static("src/public"));
app.get("/", (req, res) => {
    res.sendFile("index.html");
});
app.use("/twod", twod_1.default);
io.on("connection", (socket) => {
    console.log("a user connected");
    socket.on("disconnect", () => {
        console.log("user disconnected");
    });
});
app.use(errors_1.errorHandler);
server.listen(variables_1.PORT, () => {
    console.log(`🚀 Twod Representative API server is listening on port ${variables_1.PORT}`);
});
