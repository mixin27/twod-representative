const { env } = process as { env: { [key: string]: string } };

export const {
    PORT,
} = env;