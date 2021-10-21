/* eslint-disable object-curly-spacing */
import { SimplePost } from "./interface";
import functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
import admin = require("firebase-admin");
admin.initializeApp();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

// ユーザーの投稿があった際に他のドキュメントにコピーを作成する関数
// users/{documentId}/simplePosts, allPosts, tagsに書き込む
exports.makeSimplePosts = functions.region("asia-northeast1").firestore
    .document("/api/v1/users/{userId}/posts/{postId}")
    .onCreate(async (snap, context) => {
      const v1CollectionRef = snap.ref.parent.parent?.parent.parent;

      // 必要情報のみを取得
      const simplePost: SimplePost = {
        title: snap.data().title,
        techTag: snap.data().techTag,
        headerImageURL: snap.data().headerImageURL,
        postId: snap.data().postId,
        userId: snap.data().userId,
        goodCount: snap.data().goodCount,
        timeCreated: snap.data().timeCreated,
        timeUpdated: snap.data().timeUpdated,
      };

      // 三箇所に書き込む
      await v1CollectionRef?.collection("allPosts").add(simplePost);
      await snap.ref.parent?.parent?.collection("simplePosts").add(simplePost);
      return 0;
    });


exports.deleteSimplePosts = functions.region("asia-northeast1").firestore
    .document("/api/v1/users/{userId}/posts/{postId}")
    .onDelete(async (snap, context) => {
      const v1CollectionRef = snap.ref.parent.parent?.parent.parent;

      // 関連するドキュメントを削除する
      await v1CollectionRef?.collection("allPosts")
            .where("postId", "==", snap.id).get()
            .then(async (result)=>{
              if (!result.empty) {
                // 削除する
                result.docs.forEach(async (value)=>{
                  await v1CollectionRef?.collection("allPosts")
                  .doc(value.id).delete();
                });
              }
            });
      await snap.ref.collection("simplePosts")
          .where("postId", "==", snap.id).get()
          .then(async (result)=>{
            if (!result.empty) {
              result.docs.forEach(async (doc)=> {
                await snap.ref.collection("simplePosts").doc(doc.id).delete();
              });
            }
          })
      ;
      return 0;
    });

