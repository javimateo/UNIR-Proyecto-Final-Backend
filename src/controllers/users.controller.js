const UserModel = require('../models/user.model');

async function listUsers(req, res, next) {
  try {
    const { search, role, status } = req.query;
    const users = await UserModel.findAll({ search, role, status });
    res.json(users);
  } catch (err) {
    next(err);
  }
}

async function getUser(req, res, next) {
  try {
    const user = await UserModel.findById(req.params.id);
    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });
    const { password_hash, email, ...publicProfile } = user;
    res.json(publicProfile);
  } catch (err) {
    next(err);
  }
}

async function updateUser(req, res, next) {
  try {
    const { id } = req.params;
    const isOwner = req.user.id === Number(id);
    const isAdmin = req.user.role === 'admin';
    if (!isOwner && !isAdmin) {
      const err = new Error('No tienes permiso para editar este usuario');
      err.status = 403;
      return next(err);
    }

    const user = await UserModel.findById(id);
    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });

    const { username, email, avatar_url } = req.body;
    if (!username || !email) return res.status(400).json({ error: 'username y email son obligatorios' });

    await UserModel.update(id, { username, email, avatar_url });
    res.json({ id: Number(id), username, email, avatar_url: avatar_url || null });
  } catch (err) {
    next(err);
  }
}

async function updateRole(req, res, next) {
  try {
    const { id } = req.params;
    const { role } = req.body;
    const validRoles = ['user', 'moderator', 'admin'];
    if (!role || !validRoles.includes(role)) {
      return res.status(400).json({ error: 'Rol no válido. Valores permitidos: user, moderator, admin' });
    }

    const user = await UserModel.findById(id);
    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });

    await UserModel.updateRole(id, role);
    res.json({ id: Number(id), role });
  } catch (err) {
    next(err);
  }
}

async function updateStatus(req, res, next) {
  try {
    const { id } = req.params;
    const { status } = req.body;
    const validStatuses = ['active', 'blocked'];
    if (!status || !validStatuses.includes(status)) {
      return res.status(400).json({ error: 'Estado no válido. Valores permitidos: active, blocked' });
    }

    const user = await UserModel.findById(id);
    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });

    await UserModel.updateStatus(id, status);
    res.json({ id: Number(id), status });
  } catch (err) {
    next(err);
  }
}

async function deleteUser(req, res, next) {
  try {
    const { id } = req.params;
    const isOwner = req.user.id === Number(id);
    const isAdmin = req.user.role === 'admin';
    if (!isOwner && !isAdmin) {
      const err = new Error('No tienes permiso para eliminar este usuario');
      err.status = 403;
      return next(err);
    }

    const user = await UserModel.findById(id);
    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });

    await UserModel.updateStatus(id, 'deleted');
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = { listUsers, getUser, updateUser, updateRole, updateStatus, deleteUser };
