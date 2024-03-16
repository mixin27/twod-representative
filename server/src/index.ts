import express from "express";
import { createServer } from "node:http";
import "dotenv/config";
import "express-async-errors";
import { Server } from "socket.io";

import { PORT } from "#/utils/variables";
import { errorHandler } from "#/middlewares/errors";

import twodRouter from "#/routers/twod";

const app = express();
const server = createServer(app);
const io = new Server(server);
export default io;

import "#/utils/schedule";

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static("src/public"));

// routes here
app.get("/", (req, res) => {
  res.sendFile("index.html");
});

app.use("/twod", twodRouter);

io.on("connection", (socket) => {
  console.log("a user connected");

  socket.on("disconnect", () => {
    console.log("user disconnected");
  });
});

app.use(errorHandler);

server.listen(PORT, () => {
  console.log(`🚀 Twod Representative API server is listening on port ${PORT}`);
});
