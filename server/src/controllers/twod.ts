import { RequestHandler } from "express";
import axios from "axios";

// "live": {
//     "set": "1,386.04",
//     "value": "49,752.04",
//     "time": "2024-03-15 16:31:57",
//     "twod": "42",
//     "date": "2024-03-15"
//   },
export const live: RequestHandler = async (req, res) => {
  const { data } = await axios.get("https://api.thaistock2d.com/live");

  return res.status(200).json(data);
};
