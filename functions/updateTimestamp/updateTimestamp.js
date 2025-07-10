const functions = require("firebase-functions");
const admin = require("firebase-admin");

module.exports = functions
  .region("europe-west1")
  .firestore
  .document("posts/{postId}")
  .onUpdate(async (change, context) => {
    /*const before = change.before.data();
    const after = change.after.data();

    if (before.timestamp === after.timestamp) {
      const newTimestamp = Date.now();
      await change.after.ref.update({
        timestamp: newTimestamp,
      });
    }

    return null;*/
  });