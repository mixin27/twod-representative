"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_cron_1 = __importDefault(require("node-cron"));
const axios_1 = __importDefault(require("axios"));
const index_1 = __importDefault(require("../index"));
const fetchTwodLiveData = () => __awaiter(void 0, void 0, void 0, function* () {
    const { data } = yield axios_1.default.get("https://api.thaistock2d.com/live");
    index_1.default.emit("twod_live", data);
});
node_cron_1.default.schedule("*/5 30-59 11 * * Mon,Tue,Wed,Thu,Fri", () => __awaiter(void 0, void 0, void 0, function* () {
    yield fetchTwodLiveData();
}));
node_cron_1.default.schedule("*/5 0-2 12 * * Mon,Tue,Wed,Thu,Fri", () => __awaiter(void 0, void 0, void 0, function* () {
    yield fetchTwodLiveData();
}));
node_cron_1.default.schedule("*/5 0-31 16,15 * * Mon,Tue,Wed,Thu,Fri", () => __awaiter(void 0, void 0, void 0, function* () {
    yield fetchTwodLiveData();
}));
