const functions = require("firebase-functions");
const admin = require("firebase-admin");

module.exports = functions
  .region("europe-west1")
  .firestore
  .document("posts/{postId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.date === after.date) {
      const formattedDate = new Date().toISOString().slice(0, 10);
      await change.after.ref.update({ date: formattedDate });
    }

    return null;
  });