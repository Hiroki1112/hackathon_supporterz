"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
/// ユーザーの投稿があった際に他のドキュメントにコピーを作成する関数
/// users/{documentId}/simplePosts, allPosts, tagsに書き込む
exports.makeSimplePosts = functions.firestore.document('/api/v1/users/{userId}/posts/{postId}')
    .onCreate(async (snap, context) => {
    var _a;
    const v1CollectionRef = (_a = snap.ref.parent.parent) === null || _a === void 0 ? void 0 : _a.parent.parent;
    // 必要情報のみを取得
    const simplePost = {
        title: snap.data().title,
        techTag: snap.data().techTag,
        headerImageURL: snap.data().headerImageURL,
        postId: snap.data().postId,
        userId: snap.data().userId,
        goodCount: snap.data().goodCount,
        timeCreated: snap.data().timeCreated,
        timeUpdated: snap.data().timeUpdated,
    };
    /// 三箇所に書き込む
    await (v1CollectionRef === null || v1CollectionRef === void 0 ? void 0 : v1CollectionRef.collection('allPosts').add(simplePost));
    await snap.ref.collection('simplePosts').add(simplePost);
    // You must return a Promise when performing asynchronous tasks inside a Functions such as
    // writing to Firestore.
    // Setting an 'uppercase' field in Firestore document returns a Promise.
    // return snap.ref.set({ uppercase }, { merge: true });
    return 0;
});
//# sourceMappingURL=index.js.map