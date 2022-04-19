import { rest } from 'msw';

export const handlers = [
  rest.get('/api/foo', (req, res, ctx) => {
    return res(ctx.status(200), ctx.json({ foo: 'bar' }));
  }),
];
