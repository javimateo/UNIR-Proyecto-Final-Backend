const ReportModel = require('../models/report.model');
const ItemModel = require('../models/item.model');

async function listReports(req, res, next) {
  try {
    const { status } = req.query;
    const reports = await ReportModel.findAll({ status });
    res.json(reports);
  } catch (err) {
    next(err);
  }
}

async function getReport(req, res, next) {
  try {
    const report = await ReportModel.findById(req.params.id);
    if (!report) return res.status(404).json({ error: 'Reporte no encontrado' });
    res.json(report);
  } catch (err) {
    next(err);
  }
}

async function createReport(req, res, next) {
  try {
    const { item_id, reason } = req.body;
    const reporter_id = req.user.id;

    if (!item_id || !reason) {
      return res.status(400).json({ error: 'item_id y reason son obligatorios' });
    }

    const item = await ItemModel.findById(item_id);
    if (!item) return res.status(404).json({ error: 'Artículo no encontrado' });
    if (item.user_id === reporter_id) {
      return res.status(400).json({ error: 'No puedes reportar tu propio artículo' });
    }

    const alreadyReported = await ReportModel.existsByReporterAndItem(reporter_id, item_id);
    if (alreadyReported) {
      return res.status(409).json({ error: 'Ya tienes un reporte pendiente sobre este artículo' });
    }

    const reportId = await ReportModel.create({ item_id, reporter_id, reason });
    await ItemModel.updateStatus(item_id, 'under_review');

    res.status(201).json({ id: reportId, item_id, reason, status: 'pending' });
  } catch (err) {
    next(err);
  }
}

async function resolveReport(req, res, next) {
  try {
    const { id } = req.params;
    const { resolution, moderator_note } = req.body;
    const moderator_id = req.user.id;

    const validResolutions = ['resolved_active', 'resolved_removed'];
    if (!resolution || !validResolutions.includes(resolution)) {
      return res.status(400).json({ error: 'resolution no válido. Valores permitidos: resolved_active, resolved_removed' });
    }

    const report = await ReportModel.findById(id);
    if (!report) return res.status(404).json({ error: 'Reporte no encontrado' });
    if (report.status !== 'pending') {
      return res.status(400).json({ error: 'Este reporte ya ha sido resuelto' });
    }

    await ReportModel.resolve(id, { moderator_id, moderator_note, status: resolution });

    const newItemStatus = resolution === 'resolved_removed' ? 'removed' : 'published';
    await ItemModel.updateStatus(report.item_id, newItemStatus);

    res.json({ id: Number(id), status: resolution, item_status: newItemStatus });
  } catch (err) {
    next(err);
  }
}

module.exports = { listReports, getReport, createReport, resolveReport };
