import cron from "node-cron";
import axios from "axios";

import io from "#/index";

// function getRandomArbitrary(min: number, max: number) {
//   return Math.random() * (max - min) + min;
// }

const fetchTwodLiveData = async () => {
  const { data } = await axios.get("https://api.thaistock2d.com/live");
  io.emit("twod_live", data);
};

// cron.schedule("*/5 * * * * *", async () => {
//   // this will run on every Mon-Fri
//   await fetchTwodLiveData();
// });

// */2 * * * * *
// 12 PM section
// 11:30 to 11:59 (min 0-59, hr 0-23)
cron.schedule("*/5 30-59 11 * * Mon,Tue,Wed,Thu,Fri", async () => {
  // this will run on every Mon-Fri
  await fetchTwodLiveData();
});
// 12:00 to 12:02
cron.schedule("*/5 0-2 12 * * Mon,Tue,Wed,Thu,Fri", async () => {
  // this will run on every Mon-Fri
  await fetchTwodLiveData();
});

// 4:30 PM section
cron.schedule("*/5 0-31 16,15 * * Mon,Tue,Wed,Thu,Fri", async () => {
  // this will run on every Mon-Fri
  await fetchTwodLiveData();
});
