import { ErrorRequestHandler } from 'express';

export const errorHandler: ErrorRequestHandler = (err: Error, req, res, next) => {
    res.status(500).json({
        error: err.message,
    });
}