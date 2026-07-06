const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const UserModel = require('../models/user.model');

async function register(req, res, next) {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: 'username, email y password son obligatorios' });
  }

  const [existingUsername, existingEmail] = await Promise.all([
    UserModel.findByUsername(username),
    UserModel.findByEmail(email),
  ]);

  if (existingUsername) return res.status(409).json({ error: 'El nombre de usuario ya está en uso' });
  if (existingEmail)    return res.status(409).json({ error: 'El email ya está registrado' });

  const password_hash = await bcrypt.hash(password, 10);
  const id = await UserModel.create({ username, email, password_hash });

  res.status(201).json({ id, username, email });
}

async function login(req, res, next) {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'email y password son obligatorios' });
  }

  const user = await UserModel.findByEmail(email);
  if (!user) return res.status(401).json({ error: 'Credenciales incorrectas' });

if (user.status !== 'active') return res.status(403).json({ error: 'Cuenta suspendida' });

  const valid = await bcrypt.compare(password, user.password_hash);
  if (!valid) return res.status(401).json({ error: 'Credenciales incorrectas' });

  const token = jwt.sign(
    { id: user.id, username: user.username, role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
  );

  res.json({ token });
}

async function me(req, res, next) {
  const user = await UserModel.findById(req.user.id);
  if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });
  res.json(user);
}

module.exports = { register, login, me };
