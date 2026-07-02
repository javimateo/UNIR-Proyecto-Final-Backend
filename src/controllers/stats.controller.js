const StatsModel = require('../models/stats.model');

async function getStats(req, res, next) {
  const stats = await StatsModel.getStats();
  res.json(stats);
}

module.exports = { getStats };
